import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final projects = [
      {
        'title': 'PARISARA CYCLE',
        'sub': 'Smart Cycling & Eco-Tracking Platform',
        'description': 'Developed a smart cycling application using Kotlin and Google Maps API, featuring real-time GPS tracking, ride analytics, route visualization, and community-based hazard reporting.',
        'tags': ['KOTLIN', 'GOOGLE MAPS', 'MVVM'],
        'colors': [AppTheme.lavender, AppTheme.mintCyan],
        'icon': Icons.directions_bike_rounded,
        'github': 'https://github.com/Aalokkumar0/Parisara-Cycle/releases/tag/v1.0',
      },
      {
        'title': 'DEVITY SERVICE',
        'sub': 'User Profile Management Microservice',
        'description': 'Built a scalable user management API using FastAPI and PostgreSQL, implementing secure authentication, CRUD operations, Docker containerization, and cloud-integrated backend services.',
        'tags': ['FASTAPI', 'POSTGRESQL', 'DOCKER'],
        'colors': [AppTheme.blushPink, AppTheme.lavender],
        'icon': Icons.dns_rounded,
        'github': 'https://github.com/Aalokkumar0/devity-user-profile-server',
      },
      {
        'title': 'ENGINOTES',
        'sub': 'Engineering Resource Management System',
        'description': 'Built a Flutter and Firebase-powered note-sharing platform with secure authentication, PDF management, real-time Firestore synchronization, and advanced search and admin features.',
        'tags': ['FLUTTER', 'FIREBASE', 'FIRESTORE'],
        'colors': [AppTheme.mintCyan, AppTheme.blushPink],
        'icon': Icons.note_alt_rounded,
        'github': 'https://github.com/Aalokkumar0/EngiNotes',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'MY WORK', title: 'PROJECTS'),
          const SizedBox(height: 80),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: isDesktop ? 500 : 480,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return AnimatedSection(
                delay: Duration(milliseconds: 120 * index),
                child: _ProjectCard(project: project),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hoverAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.project['colors'] as List<Color>;
    final primaryColor = colors[0];
    final secondaryColor = colors[1];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          final hv = _hoverAnimation.value;
          return Transform.translate(
            offset: Offset(0, -7 * hv),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                border: Border.all(
                  color: Color.lerp(
                    primaryColor.withValues(alpha: 0.15),
                    primaryColor.withValues(alpha: 0.5),
                    hv,
                  )!,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.12 + 0.18 * hv),
                    blurRadius: 20 + 20 * hv,
                    offset: Offset(0, 8 + 8 * hv),
                  ),
                  BoxShadow(
                    color: secondaryColor.withValues(alpha: 0.08 * hv),
                    blurRadius: 30 * hv,
                    offset: Offset(10 * hv, 20 * hv),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gradient header with icon
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(24)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          primaryColor.withValues(alpha: 0.12 + 0.08 * hv),
                          secondaryColor.withValues(alpha: 0.08 + 0.05 * hv),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.7),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.25),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          widget.project['icon'] as IconData,
                          size: 44,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project['title'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.textPrimary,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.project['sub'],
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            widget.project['description'],
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              height: 1.7,
                              fontSize: 13.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          // GitHub link
                          if (widget.project['github'] != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Icon(Icons.link_rounded,
                                      color: primaryColor.withValues(alpha: 0.7),
                                      size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                    'View on GitHub',
                                    style: TextStyle(
                                      color: primaryColor.withValues(alpha: 0.8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          // Tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (widget.project['tags'] as List<String>)
                                .map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: primaryColor.withValues(alpha: 0.1),
                                  border: Border.all(
                                    color: primaryColor.withValues(alpha: 0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
