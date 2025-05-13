import 'package:flutter/material.dart';
import '../config/portfolio_config.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import '../utils/url_launcher.dart';
import 'dart:math' as math;

class GreetingSection extends StatefulWidget {
  final void Function(String section)? onNav;
  const GreetingSection({super.key, this.onNav});

  @override
  State<GreetingSection> createState() => _GreetingSectionState();
}

class _GreetingSectionState extends State<GreetingSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
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
    final greeting = PortfolioConfig.greeting;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      constraints: const BoxConstraints(minHeight: 600),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          return isWide
              ? _buildWideLayout(context, loc, isDark, greeting)
              : _buildNarrowLayout(context, loc, isDark, greeting);
        },
      ),
    );
  }

  Widget _buildWideLayout(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Map<String, String> greeting,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildGreetingContent(context, loc, isDark, greeting),
        ),
        Expanded(flex: 5, child: _buildIllustration(isDark)),
      ],
    );
  }

  Widget _buildNarrowLayout(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Map<String, String> greeting,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGreetingContent(context, loc, isDark, greeting),
        const SizedBox(height: 40),
        _buildIllustration(isDark),
      ],
    );
  }

  Widget _buildGreetingContent(
    BuildContext context,
    AppLocalizations loc,
    bool isDark,
    Map<String, String> greeting,
  ) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi there! 👋',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:
                    isDark
                        ? AppTheme.secondaryColor
                        : AppTheme.lightSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              greeting['title']!,
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              greeting['subtitle']!,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color:
                    isDark ? AppTheme.subTextColor : AppTheme.lightSubTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              loc.translate('profileDescription'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                _buildButton(
                  context,
                  loc.translate('downloadCV'),
                  Icons.download,
                  isDark,
                  isPrimary: true,
                  onPressed: () {
                    UrlLauncher.launchUrl(greeting['resumeLink']!);
                  },
                ),
                const SizedBox(width: 16),
                _buildButton(
                  context,
                  loc.translate('contact'),
                  Icons.email,
                  isDark,
                  isPrimary: false,
                  onPressed: () {
                    // Scroll to contact section
                    widget.onNav?.call('contact');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    IconData icon,
    bool isDark, {
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;
    final backgroundColor = isPrimary ? primaryColor : Colors.transparent;
    final textColor =
        isPrimary
            ? (isDark
                ? AppTheme.buttonTextColor
                : AppTheme.lightButtonTextColor)
            : primaryColor;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)],
      ),
    );
  }

  Widget _buildIllustration(bool isDark) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Transform.translate(
        offset: Offset(0, 10 * math.sin(_controller.value * math.pi)),
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.cardColor : AppTheme.lightCardColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.code,
              size: 120,
              color:
                  isDark
                      ? AppTheme.secondaryColor
                      : AppTheme.lightSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
