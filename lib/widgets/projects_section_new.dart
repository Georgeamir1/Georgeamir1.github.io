import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../config/portfolio_config.dart';
import '../utils/url_launcher.dart';
import 'dart:math' as math;

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final Map<int, bool> _hoveredItems = {};

  void _setHovered(int index, bool isHovered) {
    setState(() {
      _hoveredItems[index] = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final projects = PortfolioConfig.projects;

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
              final isMedium =
                  constraints.maxWidth > 600 && constraints.maxWidth <= 900;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: List.generate(projects.length, (index) {
                  final width =
                      isWide
                          ? (constraints.maxWidth - 48) / 3
                          : isMedium
                          ? (constraints.maxWidth - 24) / 2
                          : constraints.maxWidth;

                  return SizedBox(
                    width: width,
                    child: _buildProjectCard(
                      context,
                      projects[index] as Map<String, String>,
                      isDark,
                      index,
                    ),
                  );
                }),
              );
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
          loc.translate('projects'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color:
                isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Some Things I\'ve Built',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    Map<String, String> project,
    bool isDark,
    int index,
  ) {
    final isHovered = _hoveredItems[index] ?? false;
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return MouseRegion(
      onEnter: (_) => _setHovered(index, true),
      onExit: (_) => _setHovered(index, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform:
            Matrix4.identity()..translate(0.0, isHovered ? -8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardColor : AppTheme.lightCardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color:
                  isHovered
                      ? (isDark
                          ? primaryColor.withAlpha(50)
                          : primaryColor.withAlpha(30))
                      : Colors.transparent,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Container(
                height: 180,
                width: double.infinity,
                color:
                    isDark ? AppTheme.primaryColor : AppTheme.lightPrimaryColor,
                child: Center(
                  child: Icon(Icons.web_asset, size: 60, color: primaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title']!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['description']!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildIconButton(
                        Icons.link,
                        'View Project',
                        primaryColor,
                        isDark,
                        onPressed: () {
                          if (project['link']!.isNotEmpty) {
                            UrlLauncher.launchUrl(project['link']!);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(
    IconData icon,
    String tooltip,
    Color color,
    bool isDark, {
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark ? AppTheme.primaryColor : AppTheme.lightPrimaryColor,
          ),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }
}
