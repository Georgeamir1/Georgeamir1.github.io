import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../config/portfolio_config.dart';
import 'dart:math' as math;

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final skills = PortfolioConfig.skillsSection['skills'] as List;
    final knowledge = loc.translate('skillsKnowledge');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, loc, isDark),
              const SizedBox(height: 40),
              isWide
                  ? _buildWideLayout(context, skills, isDark)
                  : _buildNarrowLayout(context, skills, isDark),
              const SizedBox(height: 32),
              _buildKnowledgeSection(context, knowledge, isDark),
            ],
          );
        },
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
          loc.translate('skills'),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color:
                isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          PortfolioConfig.skillsSection['subTitle'] as String,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildWideLayout(BuildContext context, List skills, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: _buildSkillsList(context, skills, isDark)),
        Expanded(flex: 4, child: _buildSkillsIllustration(isDark)),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context, List skills, bool isDark) {
    return Column(
      children: [
        _buildSkillsIllustration(isDark),
        const SizedBox(height: 32),
        _buildSkillsList(context, skills, isDark),
      ],
    );
  }

  Widget _buildSkillsList(BuildContext context, List skills, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...skills
            .map((skill) => _buildSkillItem(context, skill, isDark))
            .toList(),
      ],
    );
  }

  Widget _buildSkillItem(
    BuildContext context,
    Map<String, dynamic> skill,
    bool isDark,
  ) {
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(skill['icon'] as IconData, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                skill['name'] as String,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: 10,
                    decoration: BoxDecoration(
                      color:
                          isDark ? AppTheme.cardColor : AppTheme.lightCardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * (skill['level'] as double),
                    height: 10,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsIllustration(bool isDark) {
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 0.05 * math.pi,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.cardColor : AppTheme.lightCardColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(Icons.code, size: 80, color: primaryColor),
            ),
          ),
        );
      },
    );
  }

  Widget _buildKnowledgeSection(
    BuildContext context,
    String knowledge,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppTheme.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Other Knowledge',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(knowledge, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
