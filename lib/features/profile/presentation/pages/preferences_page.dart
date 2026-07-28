/// Preferences Page
/// Page for managing user preferences and settings
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/profile_providers.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class PreferencesPage extends ConsumerWidget {
  const PreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<String, dynamic> preferences = ref.watch(preferencesProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Notifications section
            SettingsSection(
              title: 'Notifications',
              children: <Widget>[
                SettingsTile.switchTile(
                  icon: Icons.notifications,
                  title: 'Push Notifications',
                  subtitle: 'Receive booking updates and promotions',
                  value: preferences['notifications'] as bool,
                  onChanged: (bool value) {
                    // TODO: Implement notification toggle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notification settings coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SettingsTile.switchTile(
                  icon: Icons.email,
                  title: 'Email Updates',
                  subtitle: 'Get news and offers by email',
                  value: preferences['emailUpdates'] as bool,
                  onChanged: (bool value) {
                    // TODO: Implement email toggle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email settings coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SettingsTile.switchTile(
                  icon: Icons.sms,
                  title: 'SMS Alerts',
                  subtitle: 'Receive text message notifications',
                  value: preferences['smsAlerts'] as bool,
                  onChanged: (bool value) {
                    // TODO: Implement SMS toggle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('SMS settings coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.large),

            // Appearance section
            SettingsSection(
              title: 'Appearance',
              children: <Widget>[
                SettingsTile.switchTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme for the app',
                  value: preferences['darkMode'] as bool,
                  onChanged: (bool value) {
                    // TODO: Implement dark mode toggle
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Dark mode coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.large),

            // About section
            SettingsSection(
              title: 'About',
              children: <Widget>[
                SettingsTile(
                  icon: Icons.info,
                  title: 'App Version',
                  subtitle: '1.0.0 (Build 202307)',
                  onTap: () {
                    // TODO: Show version info
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Version info coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {
                    // TODO: Show privacy policy
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Privacy policy coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                SettingsTile(
                  icon: Icons.description,
                  title: 'Terms of Service',
                  subtitle: 'Review our terms and conditions',
                  onTap: () {
                    // TODO: Show terms of service
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Terms of service coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.xLarge),
          ],
        ),
      ),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Preferences',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }
}