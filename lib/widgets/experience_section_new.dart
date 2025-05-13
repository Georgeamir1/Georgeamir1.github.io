import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../config/portfolio_config.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;
    final experiences = PortfolioConfig.workExperience;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, loc, isDark),
          const SizedBox(height: 40),
          _buildExperienceTimeline(context, loc, isDark, primaryColor, experiences),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(BuildContext context, AppLocalizations loc, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.translate('experience'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Where I\'ve Worked',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildExperienceTimeline(
    BuildContext context, 
    AppLocalizations loc, 
    bool isDark, 
    Color primaryColor,
    List<Map<String, String>> experiences,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        children: [
          for (int i = 0; i < experiences.length; i++) ...[
            _ExperienceCard(
              experience: experiences[i],
              isDark: isDark,
              primaryColor: primaryColor,
              isLast: i == experiences.length - 1,
            ),
            if (i < experiences.length - 1) const SizedBox(height: 32),
          ],
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Map<String, String> experience;
  final bool isDark;
  final Color primaryColor;
  final bool isLast;
  
  const _ExperienceCard({
    required this.experience,
    required this.isDark,
    required this.primaryColor,
    required this.isLast,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark ? AppTheme.primaryColor : AppTheme.lightPrimaryColor,
                  width: 3,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 100,
                color: primaryColor.withAlpha(100),
              ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    experience['date']!,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      experience['location']!,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                experience['role']!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                experience['company']!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: isDark ? AppTheme.subTextColor : AppTheme.lightSubTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                experience['description']!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
