import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../constants/app_theme.dart';
import '../models/submission_model.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final auth = context.read<AuthProvider>();
      await auth.init();
      final userId = auth.userId ?? 0;
      context.read<HistoryProvider>().loadSubmissions(userId);
    });
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d, yyyy • h:mm a').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Color _getFeedbackColor(int score) {
    if (score >= 75) return AppTheme.successColor;
    if (score >= 50) return Colors.orange;
    return AppTheme.errorColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz History')),
      body: Consumer<HistoryProvider>(
        builder: (context, history, _) {
          final state = history.submissionsState;

          if (state.isLoading) {
            return const LoadingWidget(message: 'Loading your history...');
          }
          if (state.isError) {
            return AppErrorWidget(
              message: state.message ?? 'Failed to load history',
              onRetry: () async {
                final auth = context.read<AuthProvider>();
                await auth.init();
                history.loadSubmissions(auth.userId ?? 0);
              },
            );
          }
          final submissions = state.data ?? [];
          if (submissions.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.history_rounded,
              message: 'No quiz history yet.\nTake your first quiz!',
              onAction: () => Navigator.pushReplacementNamed(context, '/quiz'),
              actionLabel: 'Take Quiz',
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              final auth = context.read<AuthProvider>();
              await auth.init();
              await history.loadSubmissions(auth.userId ?? 0);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: submissions.length,
              itemBuilder: (ctx, i) {
                final s = submissions[i];
                return _SubmissionCard(
                  submission: s,
                  dateFormatted: _formatDate(s.submittedAt),
                  color: _getFeedbackColor(s.score),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/submission-detail',
                    arguments: s.id,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SubmissionCard extends StatelessWidget {
  final SubmissionModel submission;
  final String dateFormatted;
  final Color color;
  final VoidCallback onTap;

  const _SubmissionCard({
    required this.submission,
    required this.dateFormatted,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${submission.score}',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      submission.feedback,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormatted,
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: #${submission.id}',
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
