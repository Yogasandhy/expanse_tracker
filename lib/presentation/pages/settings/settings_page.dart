import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/theme/theme_bloc.dart';
import '../../blocs/theme/theme_event.dart';
import '../../blocs/theme/theme_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : const Color(0xFFFAFAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Settings',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
              Text(
                'Customize your app experience',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 32),
              
              // User Profile Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Doe',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : const Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'john.doe@email.com',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: isDark ? Colors.grey[400] : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: isDark ? Colors.grey[400] : const Color(0xFF64748B),
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Settings List
              _buildSettingsSection(
                'Appearance',
                [
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, themeState) {
                      return _buildSettingsTile(
                        'Theme',
                        _getThemeText(themeState.themeMode),
                        Icons.palette_rounded,
                        onTap: () => _showThemeDialog(context),
                        isDark: isDark,
                      );
                    },
                  ),
                  _buildSettingsTile(
                    'Language',
                    'English',
                    Icons.language_rounded,
                    isDark: isDark,
                  ),
                ],
                isDark,
              ),
              const SizedBox(height: 20),
              
              _buildSettingsSection(
                'Preferences',
                [
                  _buildSettingsTile(
                    'Notifications',
                    'Enabled',
                    Icons.notifications_rounded,
                    isDark: isDark,
                  ),
                  _buildSettingsTile(
                    'Currency',
                    'IDR (Rp)',
                    Icons.attach_money_rounded,
                    isDark: isDark,
                  ),
                  _buildSettingsTile(
                    'Export Data',
                    'CSV, PDF',
                    Icons.download_rounded,
                    isDark: isDark,
                  ),
                ],
                isDark,
              ),
              const SizedBox(height: 20),
              
              _buildSettingsSection(
                'Support',
                [
                  _buildSettingsTile(
                    'Help Center',
                    'Get support',
                    Icons.help_rounded,
                    isDark: isDark,
                  ),
                  _buildSettingsTile(
                    'Privacy Policy',
                    'View policy',
                    Icons.privacy_tip_rounded,
                    isDark: isDark,
                  ),
                  _buildSettingsTile(
                    'About',
                    'Version 1.0.0',
                    Icons.info_rounded,
                    isDark: isDark,
                  ),
                ],
                isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(
    String title,
    List<Widget> children,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E7EB),
            ),
          ),
          child: Column(
            children: children.map((child) {
              final index = children.indexOf(child);
              return Container(
                decoration: BoxDecoration(
                  border: index < children.length - 1
                      ? Border(
                          bottom: BorderSide(
                            color: isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E7EB),
                          ),
                        )
                      : null,
                ),
                child: child,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon, {
    VoidCallback? onTap,
    required bool isDark,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF667EEA).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF667EEA),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF1E293B),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: isDark ? Colors.grey[400] : const Color(0xFF64748B),
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: isDark ? Colors.grey[400] : const Color(0xFF64748B),
        size: 16,
      ),
      onTap: onTap,
    );
  }

  String _getThemeText(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return AlertDialog(
              title: Text(
                'Choose Theme',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildThemeOption(
                    context,
                    'Light',
                    ThemeMode.light,
                    state.themeMode,
                  ),
                  _buildThemeOption(
                    context,
                    'Dark',
                    ThemeMode.dark,
                    state.themeMode,
                  ),
                  _buildThemeOption(
                    context,
                    'System',
                    ThemeMode.system,
                    state.themeMode,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    ThemeMode themeMode,
    ThemeMode currentTheme,
  ) {
    return RadioListTile<ThemeMode>(
      title: Text(
        title,
        style: GoogleFonts.inter(),
      ),
      value: themeMode,
      groupValue: currentTheme,
      onChanged: (ThemeMode? value) {
        if (value != null) {
          context.read<ThemeBloc>().add(SetTheme(value));
          Navigator.pop(context);
        }
      },
    );
  }
}
