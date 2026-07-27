import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';

/// Premium onboarding experience that introduces users to Ironit services.
/// Features smooth animations, interactive navigation, and state persistence.
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding page data
  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: 'Book Trusted Home Services',
      description: 'Find experienced professionals for every household need.',
      icon: Icons.handyman_outlined,
    ),
    OnboardingPageData(
      title: 'Real-time Tracking',
      description: 'Track your technician and receive live updates.',
      icon: Icons.track_changes_outlined,
    ),
    OnboardingPageData(
      title: 'Fast Secure Payments',
      description: 'Pay securely and manage all bookings in one place.',
      icon: Icons.payment_outlined,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Marks onboarding as completed and navigates to welcome screen
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    if (mounted) {
      GoRouter.of(context).go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with onboarding content
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildOnboardingPage(_pages[index]);
            },
          ),

          // Navigation controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildNavigationFooter(),
          ),
        ],
      ),
    );
  }

  /// Builds individual onboarding page content
  Widget _buildOnboardingPage(OnboardingPageData pageData) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.medium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration placeholder
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Icon(
                pageData.icon,
                size: 120,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xLarge),

          // Title
          Text(
            pageData.title,
            style: AppTypography.headline5.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.medium),

          // Description
          Text(
            pageData.description,
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds navigation footer with page indicator and buttons
  Widget _buildNavigationFooter() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.large),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Page indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              _pages.length,
              (index) => _buildPageIndicator(index),
            ),
          ),
          const SizedBox(height: AppSpacing.large),

          // Action buttons
          Row(
            children: [
              if (_currentPage > 0)
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Back'),
                  ),
                )
              else
                const Expanded(child: SizedBox()),
              const SizedBox(width: AppSpacing.medium),
              if (_currentPage < _pages.length - 1)
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Next'),
                  ),
                )
              else
                Expanded(
                  child: PrimaryButton(
                    onPressed: _completeOnboarding,
                    child: const Text('Get Started'),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.small),

          // Skip button
          TextButton(
            onPressed: _completeOnboarding,
            child: Text(
              'Skip',
              style: AppTypography.bodyText2.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds individual page indicator dot
  Widget _buildPageIndicator(int index) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
      ),
    );
  }
}

/// Data model for individual onboarding pages
class OnboardingPageData {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
