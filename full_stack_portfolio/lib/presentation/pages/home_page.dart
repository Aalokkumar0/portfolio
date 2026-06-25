import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/hero_section.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class HomePage extends StatelessWidget {
  final Function(String)? onSectionTap;

  const HomePage({super.key, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeroSection(onSectionTap: onSectionTap),
        _buildServicesSection(context),
        _buildFeaturedProjects(context),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface.withValues(alpha: 0.3),
            theme.colorScheme.surface.withValues(alpha: 0.1),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'WHAT I DO', title: 'SERVICES'),
          const SizedBox(height: 80),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: isDesktop ? 1.1 : 1.4,
            children: [
              _buildServiceCard(
                context, 'MOBILE APPS',
                'Building high-performance native-quality apps for iOS and Android using Flutter & Kotlin.',
                Icons.smartphone_rounded, 0,
              ),
              _buildServiceCard(
                context, 'BACKEND SYSTEMS',
                'Developing scalable REST APIs and microservices with FastAPI, PostgreSQL, and Docker.',
                Icons.dns_rounded, 1,
              ),
              _buildServiceCard(
                context, 'AI SOLUTIONS',
                'Integrating Generative AI models and LLMs to create smart, automated digital experiences.',
                Icons.auto_awesome_rounded, 2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, String desc, IconData icon, int index) {
    final theme = Theme.of(context);
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];

    return AnimatedSection(
      delay: Duration(milliseconds: 150 * index),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon with glow
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: colors[index].withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: colors[index], size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 14,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedProjects(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'LATEST WORK', title: 'FEATURED\nPROJECTS'),
          const SizedBox(height: 80),
          AnimatedSection(
            child: _buildFeaturedProjectRow(
              context, 'PARISARA CYCLE', 'KOTLIN • GOOGLE MAPS API',
              'A smart cycling application featuring real-time GPS tracking, ride analytics, and community-based hazard reporting.',
            ),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.primary.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          AnimatedSection(
            delay: const Duration(milliseconds: 200),
            child: _buildFeaturedProjectRow(
              context, 'ENGINOTES', 'FLUTTER • FIREBASE',
              'A note-sharing platform with secure authentication, PDF management, and real-time Firestore synchronization.',
            ),
          ),
          const SizedBox(height: 60),
          AnimatedSection(
            delay: const Duration(milliseconds: 400),
            child: Center(
              child: _ViewAllButton(
                text: 'VIEW ALL PROJECTS',
                onTap: () => onSectionTap?.call('projects'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjectRow(
      BuildContext context, String title, String tags, String desc) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: isDesktop
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tags,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    desc,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 16,
                      height: 1.7,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: const Icon(Icons.arrow_outward_rounded,
                      color: Colors.white, size: 22),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  tags,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 16,
                    height: 1.7,
                  ),
                ),
              ],
            ),
    );
  }
}

/// Outlined button with hover gradient fill
class _ViewAllButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const _ViewAllButton({required this.text, this.onTap});

  @override
  State<_ViewAllButton> createState() => _ViewAllButtonState();
}

class _ViewAllButtonState extends State<_ViewAllButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? theme.colorScheme.primary.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.12),
              width: 1.5,
            ),
            color: _isHovered
                ? theme.colorScheme.primary.withValues(alpha: 0.08)
                : Colors.transparent,
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.7),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
