import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../main.dart';
import '../themes/app_theme.dart';
import '../config/portfolio_config.dart';
import '../utils/url_launcher.dart';

class Navbar extends StatefulWidget {
  final void Function(String section)? onNav;
  const Navbar({super.key, this.onNav});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isScrolled = false;
  int _selectedIndex = 0;
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    // Add scroll listener in a real implementation
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Define the sections in the correct order
    final sections = ['home', 'about', 'skills', 'projects', 'contact'];

    // Make sure we're within bounds
    if (index >= 0 && index < sections.length) {
      // Call the navigation function with a slight delay to ensure the UI has updated
      Future.delayed(Duration.zero, () {
        if (widget.onNav != null) {
          widget.onNav!(sections[index]);
        } else {
          print('Navigation function is null');
        }
      });
    }
  }

  void _toggleMobileMenu() {
    setState(() {
      _isMobileMenuOpen = !_isMobileMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;
    final backgroundColor =
        isDark
            ? AppTheme.navbarColor.withAlpha(_isScrolled ? 230 : 180)
            : AppTheme.lightNavbarColor.withAlpha(_isScrolled ? 230 : 180);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow:
                _isScrolled
                    ? [
                      BoxShadow(
                        color:
                            isDark
                                ? Colors.black.withAlpha(50)
                                : Colors.black.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 1),
                      ),
                    ]
                    : null,
          ),
          child:
              isMobile
                  ? _buildMobileNavbar(loc, themeProvider, isDark, primaryColor)
                  : _buildDesktopNavbar(
                    loc,
                    themeProvider,
                    isDark,
                    primaryColor,
                  ),
        );
      },
    );
  }

  Widget _buildDesktopNavbar(
    AppLocalizations loc,
    ThemeProvider themeProvider,
    bool isDark,
    Color primaryColor,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [_buildLogo(isDark, primaryColor)]),
        Row(
          children: [
            _NavButton(
              label: loc.translate('home'),
              index: 0,
              isSelected: _selectedIndex == 0,
              onTap: () => _setSelectedIndex(0),
              isDark: isDark,
            ),
            _NavButton(
              label: loc.translate('about'),
              index: 1,
              isSelected: _selectedIndex == 1,
              onTap: () => _setSelectedIndex(1),
              isDark: isDark,
            ),
            _NavButton(
              label: loc.translate('skills'),
              index: 2,
              isSelected: _selectedIndex == 2,
              onTap: () => _setSelectedIndex(2),
              isDark: isDark,
            ),
            _NavButton(
              label: loc.translate('projects'),
              index: 3,
              isSelected: _selectedIndex == 3,
              onTap: () => _setSelectedIndex(3),
              isDark: isDark,
            ),
            _NavButton(
              label: loc.translate('contact'),
              index: 4,
              isSelected: _selectedIndex == 4,
              onTap: () => _setSelectedIndex(4),
              isDark: isDark,
            ),
            const SizedBox(width: 16),
            _buildThemeToggle(themeProvider, loc, isDark, primaryColor),
            const SizedBox(width: 16),
            _buildLanguageToggle(themeProvider, loc, isDark, primaryColor),
          ],
        ),
        Row(children: [_buildSocialButtons(isDark, primaryColor)]),
      ],
    );
  }

  Widget _buildMobileNavbar(
    AppLocalizations loc,
    ThemeProvider themeProvider,
    bool isDark,
    Color primaryColor,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(isDark, primaryColor),
            Row(
              children: [
                _buildThemeToggle(themeProvider, loc, isDark, primaryColor),
                const SizedBox(width: 8),
                _buildLanguageToggle(themeProvider, loc, isDark, primaryColor),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    _isMobileMenuOpen ? Icons.close : Icons.menu,
                    color: primaryColor,
                  ),
                  onPressed: _toggleMobileMenu,
                ),
              ],
            ),
          ],
        ),
        if (_isMobileMenuOpen) ...[
          const SizedBox(height: 16),
          Column(
            children: [
              _MobileNavButton(
                label: loc.translate('home'),
                index: 0,
                isSelected: _selectedIndex == 0,
                onTap: () {
                  _setSelectedIndex(0);
                  _toggleMobileMenu();
                },
                isDark: isDark,
              ),
              _MobileNavButton(
                label: loc.translate('about'),
                index: 1,
                isSelected: _selectedIndex == 1,
                onTap: () {
                  _setSelectedIndex(1);
                  _toggleMobileMenu();
                },
                isDark: isDark,
              ),
              _MobileNavButton(
                label: loc.translate('skills'),
                index: 2,
                isSelected: _selectedIndex == 2,
                onTap: () {
                  _setSelectedIndex(2);
                  _toggleMobileMenu();
                },
                isDark: isDark,
              ),
              _MobileNavButton(
                label: loc.translate('projects'),
                index: 3,
                isSelected: _selectedIndex == 3,
                onTap: () {
                  _setSelectedIndex(3);
                  _toggleMobileMenu();
                },
                isDark: isDark,
              ),
              _MobileNavButton(
                label: loc.translate('contact'),
                index: 4,
                isSelected: _selectedIndex == 4,
                onTap: () {
                  _setSelectedIndex(4);
                  _toggleMobileMenu();
                },
                isDark: isDark,
              ),
              const SizedBox(height: 16),
              _buildSocialButtons(isDark, primaryColor),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildLogo(bool isDark, Color primaryColor) {
    return Text(
      'George Amir',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: primaryColor,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildThemeToggle(
    ThemeProvider themeProvider,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
  ) {
    return IconButton(
      icon: Icon(
        themeProvider.themeMode == ThemeMode.light
            ? Icons.dark_mode
            : Icons.light_mode,
        color: primaryColor,
      ),
      onPressed: () {
        themeProvider.toggleTheme();
        print('Theme toggled to: ${themeProvider.themeMode}');
      },
      tooltip:
          themeProvider.themeMode == ThemeMode.light
              ? loc.translate('darkTheme')
              : loc.translate('lightTheme'),
    );
  }

  Widget _buildLanguageToggle(
    ThemeProvider themeProvider,
    AppLocalizations loc,
    bool isDark,
    Color primaryColor,
  ) {
    return TextButton(
      onPressed: () {
        final newLocale =
            themeProvider.locale.languageCode == 'en'
                ? const Locale('ar')
                : const Locale('en');
        themeProvider.setLocale(newLocale);
        print('Language changed to: ${newLocale.languageCode}');
      },
      child: Text(
        themeProvider.locale.languageCode == 'en'
            ? loc.translate('switchToArabic')
            : loc.translate('switchToEnglish'),
        style: TextStyle(color: primaryColor),
      ),
    );
  }

  Widget _buildSocialButtons(bool isDark, Color primaryColor) {
    final socialLinks = PortfolioConfig.socialMediaLinks;

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.link),
          tooltip: 'LinkedIn',
          onPressed: () => _launchUrl(socialLinks['linkedin']!),
          color: primaryColor,
        ),
        IconButton(
          icon: const Icon(Icons.code),
          tooltip: 'GitHub',
          onPressed: () => _launchUrl(socialLinks['github']!),
          color: primaryColor,
        ),
        IconButton(
          icon: const Icon(Icons.email),
          tooltip: 'Email',
          onPressed: () => _launchUrl('mailto:${socialLinks['email']}'),
          color: primaryColor,
        ),
      ],
    );
  }

  void _launchUrl(String url) {
    UrlLauncher.launchUrl(url);
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _NavButton({
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        widget.isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color:
                    widget.isSelected || _isHovered
                        ? primaryColor
                        : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isSelected || _isHovered ? primaryColor : null,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavButton extends StatelessWidget {
  final String label;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _MobileNavButton({
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? (isDark ? AppTheme.cardColor : AppTheme.lightCardColor)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? primaryColor : null,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
