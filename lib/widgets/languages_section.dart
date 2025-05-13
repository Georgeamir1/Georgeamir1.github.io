import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import 'dart:ui';

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
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
                    loc.translate('languages'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(Icons.language, color: isDark ? Colors.cyanAccent : Colors.deepPurple, size: 28, shadows: isDark ? [Shadow(blurRadius: 12, color: Colors.cyanAccent, offset: Offset(0,0))] : []),
                      const SizedBox(width: 12),
                      Text(loc.translate('arabic'), style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.language, color: isDark ? Colors.cyanAccent : Colors.deepPurple, size: 28, shadows: isDark ? [Shadow(blurRadius: 12, color: Colors.cyanAccent, offset: Offset(0,0))] : []),
                      const SizedBox(width: 12),
                      Text(loc.translate('english'), style: Theme.of(context).textTheme.bodyLarge),
                    ],
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