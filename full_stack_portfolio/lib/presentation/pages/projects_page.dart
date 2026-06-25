import 'package:flutter/material.dart';
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
        'description': 'Developed a smart cycling application using Kotlin and Google Maps API, featuring real-time GPS tracking, ride analytics, route visualization, and community-based hazard reporting with a clean Material Design interface.',
        'tags': ['KOTLIN', 'GOOGLE MAPS', 'MVVM'],
        'gradient': [const Color(0xFF38BDF8), const Color(0xFF818CF8)],
        'icon': Icons.directions_bike_rounded,
        'github': 'https://github.com/Aalokkumar0/Parisara-Cycle/releases/tag/v1.0',
      },
      {
        'title': 'DEVITY SERVICE',
        'sub': 'User Profile Management Microservice',
        'description': 'Built a scalable user management API using FastAPI and PostgreSQL, implementing secure authentication, CRUD operations, Docker containerization, and cloud-integrated backend services.',
        'tags': ['FASTAPI', 'POSTGRESQL', 'DOCKER'],
        'gradient': [const Color(0xFF818CF8), const Color(0xFFA78BFA)],
        'icon': Icons.dns_rounded,
        'github': 'https://github.com/Aalokkumar0/devity-user-profile-server',
      },
      {
        'title': 'ENGINOTES',
        'sub': 'Engineering Resource Management System',
        'description': 'Built a Flutter and Firebase-powered note-sharing platform with secure authentication, PDF management, real-time Firestore synchronization, and advanced search and admin features.',
        'tags': ['FLUTTER', 'FIREBASE', 'FIRESTORE'],
        'gradient': [const Color(0xFFA78BFA), const Color(0xFF38BDF8)],
        'icon': Icons.note_alt_rounded,
        'github': 'https://github.com/Aalokkumar0/EngiNotes',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'MY WORK', title: 'PROJECTS'),
          const SizedBox(height: 100),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: isDesktop ? 520 : 500,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return AnimatedSection(
                delay: Duration(milliseconds: 150 * index),
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
    final gradient = widget.project['gradient'] as List<Color>;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _hoverController.forward(),
      onExit: (_) => _hoverController.reverse(),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          final hv = _hoverAnimation.value;
          return Transform.translate(
            offset: Offset(0, -6 * hv),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withValues(alpha: 0.02 + 0.02 * hv),
                border: Border.all(
                  color: Color.lerp(
                    Colors.white.withValues(alpha: 0.06),
                    gradient[0].withValues(alpha: 0.3),
                    hv,
                  )!,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: gradient[0].withValues(alpha: 0.08 * hv),
                    blurRadius: 40 * hv,
                    offset: Offset(0, 15 * hv),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gradient header with icon
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          gradient[0].withValues(alpha: 0.08 + 0.06 * hv),
                          gradient[1].withValues(alpha: 0.04 + 0.04 * hv),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        widget.project['icon'] as IconData,
                        size: 64,
                        color: gradient[0].withValues(alpha: 0.2 + 0.2 * hv),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.project['title'],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.project['sub'],
                            style: TextStyle(
                              color: gradient[0],
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            widget.project['description'],
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.4),
                              height: 1.7,
                              fontSize: 14,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          // GitHub link row
                          if (widget.project['github'] != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: Row(
                                children: [
                                  Icon(Icons.link_rounded,
                                      color: gradient[0].withValues(alpha: 0.6),
                                      size: 16),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'View on GitHub',
                                      style: TextStyle(
                                        color: gradient[0].withValues(alpha: 0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withValues(alpha: 0.04),
                                  border: Border.all(
                                    color:
                                        Colors.white.withValues(alpha: 0.08),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    color:
                                        Colors.white.withValues(alpha: 0.5),
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
