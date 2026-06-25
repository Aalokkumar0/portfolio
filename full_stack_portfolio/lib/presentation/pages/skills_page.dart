import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 20,
          vertical: 80,
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
                    letterSpacing: 0.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'TECHNICAL SKILLS',
              style: TextStyle(
                fontFamily: 'ChelseaMarket',
                fontSize: 80,
                color: Colors.white,
                letterSpacing: 0.5,
                height: 1,
              ),
            ),
            const SizedBox(height: 80),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isDesktop ? 3 : 1,
              mainAxisSpacing: 30,
              crossAxisSpacing: 30,
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
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, List<String> skills, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 40),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'ChelseaMarket',
              fontSize: 28,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => Text(
              skill + (skill == skills.last ? '' : ' • '),
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
