import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'WHAT I KNOW',
            title: 'TECHNICAL\nSKILLS',
          ),
          const SizedBox(height: 100),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: isDesktop ? 1.15 : 1.5,
            children: [
              _buildSkillCategory(context, 'MOBILE', ['Flutter', 'Dart', 'Kotlin', 'Android SDK', 'Material Design'], Icons.smartphone_rounded, 0),
              _buildSkillCategory(context, 'BACKEND', ['Python', 'FastAPI', 'JWT Auth', 'SQLAlchemy', 'Microservices'], Icons.dns_rounded, 1),
              _buildSkillCategory(context, 'AI & LLMS', ['Google AI Studio', 'OpenAI APIs', 'Prompt Engineering', 'LLM Integration'], Icons.auto_awesome_rounded, 2),
              _buildSkillCategory(context, 'DATABASE & CLOUD', ['PostgreSQL', 'Firebase', 'AWS S3', 'Google Cloud'], Icons.storage_rounded, 3),
              _buildSkillCategory(context, 'ARCHITECTURE', ['MVC', 'MVP', 'MVVM', 'Clean Architecture', 'OOP'], Icons.architecture_rounded, 4),
              _buildSkillCategory(context, 'DEV TOOLS', ['Git', 'GitHub', 'Docker', 'Android Studio', 'VS Code'], Icons.handyman_rounded, 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills, IconData icon, int index) {
    final theme = Theme.of(context);
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];
    final accentColor = colors[index];

    return AnimatedSection(
      delay: Duration(milliseconds: 100 * index),
      child: GlassCard(
        padding: const EdgeInsets.all(36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: accentColor.withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: accentColor, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Modern pill chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skills.map((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withValues(alpha: 0.04),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
