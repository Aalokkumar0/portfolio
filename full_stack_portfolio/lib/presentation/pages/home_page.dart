import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
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
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'WHAT I DO', title: 'SERVICES', titleFontSize: 70),
          const SizedBox(height: 40),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: isDesktop ? 20 : 16,
            crossAxisSpacing: isDesktop ? 20 : 16,
            childAspectRatio: isDesktop ? 1.05 : 1.4,
            children: [
              _buildServiceCard(
                context,
                'MOBILE APPS',
                'Building high-performance native-quality apps for iOS and Android using Flutter & Kotlin.',
                Icons.smartphone_rounded,
                0,
              ),
              _buildServiceCard(
                context,
                'BACKEND SYSTEMS',
                'Developing scalable REST APIs and microservices with FastAPI, PostgreSQL, and Docker.',
                Icons.dns_rounded,
                1,
              ),
              _buildServiceCard(
                context,
                'AI SOLUTIONS',
                'Integrating Generative AI models and LLMs to create smart, automated digital experiences.',
                Icons.auto_awesome_rounded,
                2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
      BuildContext context, String title, String desc, IconData icon, int index) {
    final cardColors = [
      AppTheme.lavender,
      AppTheme.mintCyan,
      AppTheme.blushPink,
    ];
    final cardGradients = [
      const LinearGradient(colors: [Color(0xFFF0E8FF), Color(0xFFFDF5FF)]),
      const LinearGradient(colors: [Color(0xFFE4F7FA), Color(0xFFF5FDFF)]),
      const LinearGradient(colors: [Color(0xFFFFE8F5), Color(0xFFFFF5FB)]),
    ];

    final color = cardColors[index];

    return AnimatedSection(
      delay: Duration(milliseconds: 120 * index),
      child: GlassCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: cardGradients[index],
                border: Border.all(
                  color: color.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
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
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lavender.withValues(alpha: 0.05),
            AppTheme.blushPink.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'LATEST WORK', title: 'FEATURED\nPROJECTS', titleFontSize: 70),
          const SizedBox(height: 64),
          AnimatedSection(
            child: _buildFeaturedProjectRow(
              context,
              'PARISARA CYCLE',
              'KOTLIN • GOOGLE MAPS API',
              'A smart cycling application featuring real-time GPS tracking, ride analytics, and community-based hazard reporting.',
              AppTheme.lavender,
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppTheme.lavender,
                  AppTheme.blushPink,
                  Colors.transparent,
                ],
              ),
            ),
          ),
          AnimatedSection(
            delay: const Duration(milliseconds: 150),
            child: _buildFeaturedProjectRow(
              context,
              'ENGINOTES',
              'FLUTTER • FIREBASE',
              'A note-sharing platform with secure authentication, PDF management, and real-time Firestore synchronization.',
              AppTheme.blushPink,
            ),
          ),
          const SizedBox(height: 60),
          AnimatedSection(
            delay: const Duration(milliseconds: 300),
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
      BuildContext context, String title, String tags, String desc, Color accentColor) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
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
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: accentColor.withValues(alpha: 0.12),
                        ),
                        child: Text(
                          tags,
                          style: TextStyle(
                            color: accentColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    desc,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 15,
                      height: 1.75,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.15),
                        accentColor.withValues(alpha: 0.05),
                      ],
                    ),
                    border: Border.all(
                      color: accentColor.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(Icons.arrow_outward_rounded,
                      color: accentColor, size: 22),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: accentColor.withValues(alpha: 0.12),
                  ),
                  child: Text(
                    tags,
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 15,
                    height: 1.75,
                  ),
                ),
              ],
            ),
    );
  }
}

/// Pill-shaped outlined button with candy hover
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: _isHovered
                ? const LinearGradient(
                    colors: [AppTheme.lavender, AppTheme.blushPink],
                  )
                : null,
            color: _isHovered ? null : Colors.white,
            border: Border.all(
              color: _isHovered
                  ? AppTheme.lavender.withValues(alpha: 0.0)
                  : AppTheme.lavender.withValues(alpha: 0.4),
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.lavender.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: _isHovered ? Colors.white : AppTheme.lavender,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
