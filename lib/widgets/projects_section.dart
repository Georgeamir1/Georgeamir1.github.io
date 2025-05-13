import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../themes/app_theme.dart';
import 'dart:ui';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final projects = [
      {
        'title': loc.translate('projectsEttaminUi'),
        'desc': loc.translate('projectsEttaminDesc'),
      },
      {
        'title': loc.translate('projectsCastyUi'),
        'desc': loc.translate('projectsCastyUiDesc'),
      },
      {
        'title': loc.translate('projectsCasty'),
        'desc': loc.translate('projectsCastyDesc'),
      },
      {
        'title': loc.translate('projectsOrchida'),
        'desc': loc.translate('projectsOrchidaDesc'),
      },
      {
        'title': loc.translate('projectsPinion'),
        'desc': loc.translate('projectsPinionDesc'),
      },
      {
        'title': loc.translate('projectsPerfect'),
        'desc': loc.translate('projectsPerfectDesc'),
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
                    loc.translate('projects'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 700;
                      return Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: projects.map((project) => SizedBox(
                          width: isWide ? 320 : double.infinity,
                          child: _ProjectCard(project: project, isDark: isDark),
                        )).toList(),
                      );
                    },
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

class _ProjectCard extends StatefulWidget {
  final Map<String, String> project;
  final bool isDark;
  const _ProjectCard({required this.project, required this.isDark});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  double _tiltX = 0;
  double _tiltY = 0;
  bool _hovering = false;

  void _onPointerMove(PointerEvent event, BoxConstraints constraints) {
    final size = constraints.biggest;
    final dx = (event.localPosition.dx - size.width / 2) / (size.width / 2);
    final dy = (event.localPosition.dy - size.height / 2) / (size.height / 2);
    setState(() {
      _tiltX = dy * 10;
      _tiltY = -dx * 10;
    });
  }

  void _onPointerExit(PointerEvent event) {
    setState(() {
      _tiltX = 0;
      _tiltY = 0;
      _hovering = false;
    });
  }

  void _onPointerEnter(PointerEvent event) {
    setState(() {
      _hovering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (e) => _onPointerMove(e, constraints),
          onExit: _onPointerExit,
          onEnter: _onPointerEnter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_tiltX * 0.017)
              ..rotateY(_tiltY * 0.017)
              ..scale(_hovering ? 1.04 : 1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.isDark ? Colors.white10 : Colors.white.withOpacity(0.7),
              boxShadow: widget.isDark && _hovering
                  ? [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.4),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(0.08),
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
              border: Border.all(
                color: widget.isDark && _hovering ? Colors.cyanAccent : Colors.transparent,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project['title']!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.isDark ? Colors.cyanAccent : Colors.deepPurple),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.project['desc']!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 