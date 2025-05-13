import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../config/portfolio_config.dart';
import '../utils/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, loc, isDark),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;

              return isWide
                  ? _buildWideLayout(context, loc, isDark, primaryColor)
                  : _buildNarrowLayout(context, loc, isDark, primaryColor);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.translate('about'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color:
                isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Who I Am',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWideLayout(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: _buildAboutContent(context, loc, isDark, primaryColor),
        ),
        Expanded(flex: 4, child: _buildProfileImage(isDark, primaryColor)),
      ],
    );
  }

  Widget _buildNarrowLayout(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
  ) {
    return Column(
      children: [
        _buildProfileImage(isDark, primaryColor),
        const SizedBox(height: 32),
        _buildAboutContent(context, loc, isDark, primaryColor),
      ],
    );
  }

  Widget _buildProfileImage(bool isDark, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? AppTheme.cardColor : AppTheme.lightCardColor,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withAlpha(50),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Icon(Icons.person, size: 120, color: primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
  ) {
    final socialLinks = PortfolioConfig.socialMediaLinks;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            PortfolioConfig.greeting['title']!,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            PortfolioConfig.greeting['subtitle']!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            loc.translate('profileDescription'),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          _buildInfoRow(Icons.email, socialLinks['email']!, primaryColor),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.phone, socialLinks['phone']!, primaryColor),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.link, socialLinks['linkedin']!, primaryColor),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.code, socialLinks['github']!, primaryColor),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {
              UrlLauncher.launchUrl(PortfolioConfig.greeting['resumeLink']!);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download, color: primaryColor),
                const SizedBox(width: 8),
                Text(
                  loc.translate('downloadCV'),
                  style: TextStyle(color: primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color primaryColor) {
    return InkWell(
      onTap: () {
        if (icon == Icons.email) {
          UrlLauncher.launchEmail(text);
        } else if (icon == Icons.phone) {
          UrlLauncher.launchPhone(text);
        } else if (icon == Icons.link) {
          UrlLauncher.launchUrl(text);
        } else if (icon == Icons.code) {
          UrlLauncher.launchUrl(text);
        }
      },
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: SelectableText(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
