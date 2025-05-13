import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import 'dart:ui';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final experiences = [
      {
        'company': loc.translate('isc'),
        'role': loc.translate('flutterDeveloper'),
        'date': '2024-06 – present',
        'location': 'Zagazig, Egypt',
      },
      {
        'company': loc.translate('egcoco'),
        'role': loc.translate('flutterDevUiUx'),
        'date': '2023-06 – 2023-12',
        'location': 'Helwan, Egypt',
      },
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Container(
        decoration: AppTheme.neonBoxDecoration(context).copyWith(
          color: Theme.of(context).cardColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.translate('experience'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: experiences.map((exp) => _ExperienceCard(exp: exp, isDark: isDark)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Map<String, String> exp;
  final bool isDark;
  const _ExperienceCard({required this.exp, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.work, color: isDark ? Colors.cyanAccent : Colors.deepPurple, size: 32, shadows: isDark ? [Shadow(blurRadius: 12, color: Colors.cyanAccent, offset: Offset(0,0))] : []),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp['company']!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  exp['role']!,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: isDark ? Colors.cyanAccent : Colors.deepPurple),
                ),
                Text(
                  '${exp['date']} | ${exp['location']}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 