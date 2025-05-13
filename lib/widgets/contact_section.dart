import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import 'dart:ui';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Container(
        decoration: AppTheme.neonBoxDecoration(
          context,
        ).copyWith(color: Theme.of(context).cardColor),
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
                    loc.translate('contact'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: isDark ? Colors.cyanAccent : Colors.deepPurple,
                        size: 24,
                        shadows:
                            isDark
                                ? [
                                  Shadow(
                                    blurRadius: 12,
                                    color: Colors.cyanAccent,
                                    offset: Offset(0, 0),
                                  ),
                                ]
                                : [],
                      ),
                      const SizedBox(width: 12),
                      SelectableText('amirgeorge841@gmail.com'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: isDark ? Colors.cyanAccent : Colors.deepPurple,
                        size: 24,
                        shadows:
                            isDark
                                ? [
                                  Shadow(
                                    blurRadius: 12,
                                    color: Colors.cyanAccent,
                                    offset: Offset(0, 0),
                                  ),
                                ]
                                : [],
                      ),
                      const SizedBox(width: 12),
                      SelectableText('01068780012'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.link,
                        color: isDark ? Colors.cyanAccent : Colors.deepPurple,
                        size: 24,
                        shadows:
                            isDark
                                ? [
                                  Shadow(
                                    blurRadius: 12,
                                    color: Colors.cyanAccent,
                                    offset: Offset(0, 0),
                                  ),
                                ]
                                : [],
                      ),
                      const SizedBox(width: 12),
                      SelectableText('linkedin.com/in/george-amir-570586216'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.code,
                        color: isDark ? Colors.cyanAccent : Colors.deepPurple,
                        size: 24,
                        shadows:
                            isDark
                                ? [
                                  Shadow(
                                    blurRadius: 12,
                                    color: Colors.cyanAccent,
                                    offset: Offset(0, 0),
                                  ),
                                ]
                                : [],
                      ),
                      const SizedBox(width: 12),
                      SelectableText('github.com/Georgeamir1'),
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
