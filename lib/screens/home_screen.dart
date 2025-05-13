import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section_new.dart' as new_projects;
import '../widgets/education_section_new.dart';
import '../widgets/greeting_section.dart';
import '../widgets/contact_section_new.dart';
import '../widgets/navbar.dart';
import '../widgets/experience_section_new.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Using GlobalKey<State> to ensure the keys are properly registered
  final homeKey = GlobalKey(debugLabel: 'homeKey');
  final projectsKey = GlobalKey(debugLabel: 'projectsKey');
  final aboutKey = GlobalKey(debugLabel: 'aboutKey');
  final skillsKey = GlobalKey(debugLabel: 'skillsKey');
  final contactKey = GlobalKey(debugLabel: 'contactKey');

  // Add a ScrollController
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(String section) {
    // Use a delay to ensure the UI has been built
    Future.delayed(Duration(milliseconds: 100), () {
      print('Scrolling to section: $section');
      final contextMap = {
        'home': homeKey,
        'projects': projectsKey,
        'about': aboutKey,
        'skills': skillsKey,
        'contact': contactKey,
      };

      final key = contextMap[section];
      if (key != null && key.currentContext != null) {
        print('Found context for section: $section');
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        print('Context not found for section: $section');

        // Try scrolling by offset as a fallback
        final scrollOffsets = {
          'home': 0.0,
          'about': 600.0,
          'skills': 1200.0,
          'projects': 1800.0,
          'contact': 2400.0,
        };

        if (scrollOffsets.containsKey(section) && mounted) {
          print('Fallback to offset scrolling for section: $section');
          // Use our ScrollController
          _scrollController.animateTo(
            scrollOffsets[section]!,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Add a post-frame callback to ensure the keys are properly registered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('Post-frame callback executed');
      print('homeKey context: ${homeKey.currentContext != null}');
      print('aboutKey context: ${aboutKey.currentContext != null}');
      print('skillsKey context: ${skillsKey.currentContext != null}');
      print('projectsKey context: ${projectsKey.currentContext != null}');
      print('contactKey context: ${contactKey.currentContext != null}');
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: isDark ? AppTheme.primaryColor : AppTheme.lightPrimaryColor,
          ),

          // Navbar

          // Content
          ListView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 80),
            children: [
              // Home/Greeting Section
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: 1.0,
                child: Container(
                  key: homeKey,
                  child: GreetingSection(onNav: _scrollToSection),
                ),
              ),

              // About Section
              AnimatedSlide(
                duration: const Duration(milliseconds: 500),
                offset: Offset.zero,
                child: Container(key: aboutKey, child: const AboutSection()),
              ),

              // Skills Section
              AnimatedScale(
                duration: const Duration(milliseconds: 500),
                scale: 1.0,
                child: Container(key: skillsKey, child: const SkillsSection()),
              ),

              // Projects Section
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: 1.0,
                child: Container(
                  key: projectsKey,
                  child: const new_projects.ProjectsSection(),
                ),
              ),

              // Experience Section
              const ExperienceSection(),

              // Education Section
              const EducationSection(),

              // Contact Section
              AnimatedSlide(
                duration: const Duration(milliseconds: 500),
                offset: Offset.zero,
                child: Container(
                  key: contactKey,
                  child: const ContactSection(),
                ),
              ),

              // Footer
              _buildFooter(context, isDark),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(onNav: _scrollToSection),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark) {
    final primaryColor =
        isDark ? AppTheme.secondaryColor : AppTheme.lightSecondaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} George Amir. All Rights Reserved.',
            style: TextStyle(
              color:
                  isDark ? AppTheme.subTextColor : AppTheme.lightSubTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Made with Flutter ❤️',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
