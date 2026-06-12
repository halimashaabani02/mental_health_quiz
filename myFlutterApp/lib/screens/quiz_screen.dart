import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../providers/auth_provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/api_response.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().loadQuestions();
    });
  }

  Future<void> _submitQuiz() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Submit Quiz'),
        content: const Text(
            'Are you ready to submit your answers? You cannot change them after submission.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Review'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final auth = context.read<AuthProvider>();
    await auth.init();
    final userId = auth.userId ?? 0;
    final success =
        await context.read<QuizProvider>().submitQuiz(userId);

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/result');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              context.read<QuizProvider>().submitState.message ??
                  'Submission failed'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<QuizProvider>().resetQuiz();
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quiz, _) {
          if (quiz.questionsState.isLoading) {
            return const LoadingWidget(message: 'Loading questions...');
          }
          if (quiz.questionsState.isError) {
            return AppErrorWidget(
              message: quiz.questionsState.message ?? 'Failed to load questions',
              onRetry: quiz.loadQuestions,
            );
          }
          if (quiz.questions.isEmpty) {
            return const Center(child: Text('No questions available.'));
          }

          final question = quiz.currentQuestion!;

          return Column(
            children: [
              // Progress bar
              Container(
                color: AppTheme.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${quiz.currentIndex + 1} of ${quiz.questions.length}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                        ),
                        Text(
                          '${quiz.answeredCount} answered',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: quiz.progress,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),

              // Question content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Question card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Question ${quiz.currentIndex + 1}',
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                question.questionText,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Answer options
                      ...question.answers.map((answer) {
                        final isSelected =
                            quiz.getSelectedAnswer(question.id) == answer.id;
                        return GestureDetector(
                          onTap: () =>
                              quiz.selectAnswer(question.id, answer.id),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.primaryColor
                                    : const Color(0xFFE0E0E0),
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? AppTheme.primaryColor.withOpacity(0.2)
                                      : Colors.black.withOpacity(0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.white
                                          : AppTheme.textSecondary,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Center(
                                          child: Icon(Icons.check,
                                              size: 14,
                                              color: Colors.white),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    answer.answerText,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : AppTheme.textPrimary,
                                      fontSize: 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Navigation buttons
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -2))
                  ],
                ),
                child: Row(
                  children: [
                    if (!quiz.isFirstQuestion)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: quiz.goToPrevious,
                          icon: const Icon(Icons.arrow_back_ios, size: 16),
                          label: const Text('Previous'),
                        ),
                      ),
                    if (!quiz.isFirstQuestion) const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: quiz.isLastQuestion
                          ? ElevatedButton(
                              onPressed: quiz.submitState.isLoading
                                  ? null
                                  : _submitQuiz,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.successColor),
                              child: quiz.submitState.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white, strokeWidth: 2),
                                    )
                                  : const Text('Submit Quiz'),
                            )
                          : ElevatedButton.icon(
                              onPressed: quiz.goToNext,
                              icon: const Icon(Icons.arrow_forward_ios, size: 16),
                              label: const Text('Next'),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
