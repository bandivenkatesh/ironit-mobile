/// Help & Support Page
/// Page for user support and FAQ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/profile_providers.dart';
import '../widgets/support_card.dart';

class HelpSupportPage extends ConsumerWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Map<String, dynamic>>> faqAsync =
        ref.watch(supportFaqProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: faqAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Failed to load support information',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (List<Map<String, dynamic>> faqItems) {
          return _buildHelpContent(context, faqItems);
        },
      ),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Help & Support',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the help content
  Widget _buildHelpContent(
      BuildContext context, List<Map<String, dynamic>> faqItems) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Contact support section
          _buildContactSupportSection(context),
          const SizedBox(height: AppSpacing.large),

          // FAQ section
          _buildFaqSection(context, faqItems),
          const SizedBox(height: AppSpacing.xLarge),
        ],
      ),
    );
  }

  /// Build contact support section
  Widget _buildContactSupportSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.surfaceContainer,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Need Help?',
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Our support team is available 24/7 to assist you',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.medium),

          // Contact buttons
          Row(
            children: <Widget>[
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement phone support
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Phone support coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Call Us'),
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.small),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement chat support
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Chat support coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.chat),
                  label: const Text('Live Chat'),
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.small),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.small),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement email support
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email support coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.email),
            label: const Text('Email Support'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.xSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build FAQ section
  Widget _buildFaqSection(
      BuildContext context, List<Map<String, dynamic>> faqItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Frequently Asked Questions',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Find answers to common questions',
            style: AppTypography.bodyText2.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),

          // FAQ items
          ...faqItems.map((Map<String, dynamic> faq) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.small),
              child: SupportCard(
                question: faq['question'] as String,
                answer: faq['answer'] as String,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
