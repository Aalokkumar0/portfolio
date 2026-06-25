import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 30, height: 2, color: theme.colorScheme.primary),
              const SizedBox(width: 15),
              Text(
                'WHAT I KNOW',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'TECHNICAL SKILLS',
            style: TextStyle(
              fontSize: 90,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
              height: 1,
            ),
          ),
          const SizedBox(height: 100),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 35,
            crossAxisSpacing: 35,
            childAspectRatio: isDesktop ? 1.3 : 1.5,
            children: [
              _buildSkillCategory(context, 'MOBILE', ['Flutter', 'Dart', 'Kotlin', 'Jetpack Compose', 'Android SDK'], Icons.smartphone),
              _buildSkillCategory(context, 'BACKEND', ['Python', 'FastAPI', 'JWT', 'SQLAlchemy', 'Microservices'], Icons.dns),
              _buildSkillCategory(context, 'AI & GENAI', ['Google AI Studio', 'Prompt Engineering', 'LLM Integration', 'OpenAI APIs'], Icons.auto_awesome),
              _buildSkillCategory(context, 'DATABASE', ['PostgreSQL', 'Firebase Firestore', 'Realtime DB'], Icons.storage),
              _buildSkillCategory(context, 'CLOUD', ['AWS S3', 'Google Cloud', 'Firebase Console'], Icons.cloud_queue),
              _buildSkillCategory(context, 'ARCH & TOOLS', ['MVVM', 'Clean Architecture', 'Git', 'Docker', 'CI/CD'], Icons.architecture),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(45),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((skill) => Text(
                  skill + (skill == skills.last ? '' : '  • '),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
