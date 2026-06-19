import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../layouts/responsive_layout.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

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
                  'MY JOURNEY',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'EXPERIENCE',
              style: GoogleFonts.bebasNeue(
                fontSize: 80,
                color: Colors.white,
                letterSpacing: 2,
                height: 1,
              ),
            ),
            const SizedBox(height: 80),
            _buildExperienceItem(
              context,
              'MindMatrix.io',
              'Android App Development (GenAI) Intern',
              'FEB 2026 - MAY 2026',
              'Successfully completed an industry-oriented internship focused on Android Development, Generative AI, and Cloud Technologies. Worked with Kotlin, Jetpack Compose, Firebase, Google AI Studio, and Google Cloud Labs. Contributed to UI/UX design, feature development, testing, debugging, and performance optimization.',
              ['KOTLIN', 'JETPACK COMPOSE', 'GENAI', 'FIREBASE', 'GOOGLE CLOUD'],
            ),
            const SizedBox(height: 60),
            _buildExperienceItem(
              context,
              'Self-Employed / Freelance',
              'Full Stack Developer',
              '2024 - PRESENT',
              'Building and deploying end-to-end applications for clients. Focused on creating scalable backends with FastAPI and high-performance mobile frontends with Flutter. Managed multiple projects from initial concept to final production deployment.',
              ['FLUTTER', 'DART', 'FASTAPI', 'POSTGRESQL', 'DOCKER'],
            ),
          ],
        ),
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
  ) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDesktop)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  period,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.toUpperCase(),
                      style: GoogleFonts.bebasNeue(
                        fontSize: 32,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      company,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        height: 1.8,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
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
              Text(
                period,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                role.toUpperCase(),
                style: GoogleFonts.bebasNeue(
                  fontSize: 28,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                company,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  height: 1.6,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: tags.map((tag) => _buildTag(tag)).toList(),
              ),
            ],
          ),
        const SizedBox(height: 40),
        const Divider(color: Colors.white10),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
