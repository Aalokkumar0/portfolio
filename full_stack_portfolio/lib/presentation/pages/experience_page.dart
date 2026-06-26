import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(label: 'MY JOURNEY', title: 'EXPERIENCE'),
          const SizedBox(height: 80),
          AnimatedSection(
            child: _buildExperienceItem(
              context,
              'MindMatrix.io',
              'Android App Development (GenAI) Intern',
              'FEB 2026 - MAY 2026',
              'Completed an Android Development and Generative AI internship, building cloud-integrated mobile applications with Kotlin, Jetpack Compose, Firebase, and Google Cloud. Contributed across the full development lifecycle, from UI/UX design to deployment and optimization, earning an Excellent Performance Rating.',
              ['KOTLIN', 'JETPACK COMPOSE', 'GENAI', 'FIREBASE', 'GOOGLE CLOUD'],
              0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
    BuildContext context,
    String company,
    String role,
    String period,
    String description,
    List<String> tags,
    int index,
  ) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline indicator
              Column(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppTheme.lavender, AppTheme.blushPink],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.lavender,
                          blurRadius: 12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 2,
                    height: 280,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppTheme.lavender, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [AppTheme.lavender, AppTheme.blushPink],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.lavender.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'FEB 2026 - MAY 2026',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      role.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textPrimary,
                        letterSpacing: 0.5,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'MindMatrix.io',
                      style: TextStyle(
                        color: AppTheme.lavender,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        height: 1.8,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: tags.map((tag) => _buildTag(tag)).toList(),
                    ),
                  ],
                ),
              ),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppTheme.lavender, AppTheme.blushPink],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        colors: [AppTheme.lavender, AppTheme.blushPink],
                      ),
                    ),
                    child: const Text(
                      'FEB 2026 - MAY 2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                role.toUpperCase(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'MindMatrix.io',
                style: TextStyle(
                  color: AppTheme.lavender,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                description,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  height: 1.75,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags.map((tag) => _buildTag(tag)).toList(),
              ),
            ],
          ),
        const SizedBox(height: 40),
        Container(
          height: 2,
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
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppTheme.lavender.withValues(alpha: 0.1),
        border: Border.all(
          color: AppTheme.lavender.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: AppTheme.lavender,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
