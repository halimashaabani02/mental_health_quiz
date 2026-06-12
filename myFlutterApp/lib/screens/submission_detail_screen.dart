import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_theme.dart';
import '../providers/history_provider.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class SubmissionDetailScreen extends StatefulWidget {
  const SubmissionDetailScreen({super.key});

  @override
  State<SubmissionDetailScreen> createState() => _SubmissionDetailScreenState();
}

class _SubmissionDetailScreenState extends State<SubmissionDetailScreen> {
  int? _submissionId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)?.settings.arguments as int?;
    if (id != null && id != _submissionId) {
      _submissionId = id;
      context.read<HistoryProvider>().loadSubmissionDetails(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submission #${_submissionId ?? ''}'),
      ),
      body: Consumer<HistoryProvider>(
        builder: (context, history, _) {
          final state = history.detailState;

          if (state.isLoading) {
            return const LoadingWidget(message: 'Loading details...');
          }
          if (state.isError) {
            return AppErrorWidget(
              message: state.message ?? 'Failed to load details',
              onRetry: () {
                if (_submissionId != null) {
                  history.loadSubmissionDetails(_submissionId!);
                }
              },
            );
          }

          final details = state.data ?? [];
          if (details.isEmpty) {
            return const EmptyStateWidget(
              icon: Icons.info_outline_rounded,
              message: 'No details available for this submission.',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: details.length,
            itemBuilder: (ctx, i) {
              final d = details[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Q${i + 1}',
                              style: const TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        d.questionText,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: AppTheme.secondaryColor.withOpacity(0.2)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline_rounded,
                                color: AppTheme.secondaryColor, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                d.answerText,
                                style: const TextStyle(
                                  color: AppTheme.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (d.score != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '+${d.score}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
