import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../providers/quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  Color _getScoreColor(int score, int maxScore) {
    final ratio = maxScore > 0 ? score / maxScore : 0;
    if (ratio >= 0.75) return AppTheme.successColor;
    if (ratio >= 0.5) return Colors.orange;
    return AppTheme.errorColor;
  }

  IconData _getScoreIcon(int score, int maxScore) {
    final ratio = maxScore > 0 ? score / maxScore : 0;
    if (ratio >= 0.75) return Icons.sentiment_very_satisfied_rounded;
    if (ratio >= 0.5) return Icons.sentiment_neutral_rounded;
    return Icons.sentiment_dissatisfied_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    final result = quiz.submitState.data ?? {};
    final score = result['score'] != null
        ? int.tryParse(result['score'].toString()) ?? 0
        : 0;
    final feedback = result['feedback']?.toString() ??
        'Thank you for completing the quiz!';
    final submissionId = result['submission_id'] ?? result['id'];
    final maxScore = result['max_score'] != null
        ? int.tryParse(result['max_score'].toString()) ?? 100
        : 100;

    final scoreColor = _getScoreColor(score, maxScore);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scoreColor.withOpacity(0.8), scoreColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      // Score circle
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.4), width: 3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getScoreIcon(score, maxScore),
                              size: 40,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$score',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'out of $maxScore',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Quiz Complete!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Here are your results',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8), fontSize: 14),
                      ),
                      const SizedBox(height: 32),

                      // Feedback card
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(28)),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: scoreColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.psychology_rounded,
                                      color: scoreColor, size: 22),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Your Feedback',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Text(
                                feedback,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppTheme.textPrimary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            if (submissionId != null) ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(Icons.receipt_outlined,
                                      size: 16, color: AppTheme.textSecondary),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Submission ID: #$submissionId',
                                    style: const TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 28),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: scoreColor),
                                onPressed: () {
                                  quiz.resetQuiz();
                                  Navigator.pushReplacementNamed(
                                      context, '/quiz');
                                },
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Take Quiz Again'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.primaryColor,
                                  side: const BorderSide(
                                      color: AppTheme.primaryColor),
                                ),
                                onPressed: () {
                                  quiz.resetQuiz();
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                },
                                icon: const Icon(Icons.home_rounded),
                                label: const Text('Go Home'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton.icon(
                                onPressed: () {
                                  quiz.resetQuiz();
                                  Navigator.pushReplacementNamed(
                                      context, '/history');
                                },
                                icon: const Icon(Icons.history_rounded,
                                    color: AppTheme.textSecondary),
                                label: const Text(
                                  'View History',
                                  style:
                                      TextStyle(color: AppTheme.textSecondary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
