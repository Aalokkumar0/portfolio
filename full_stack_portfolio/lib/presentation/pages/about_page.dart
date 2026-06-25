import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Column(
      children: [
        // Section 1: About Intro
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100 : 20,
            vertical: 120,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildAboutIntro(context)),
                    const SizedBox(width: 80),
                    Expanded(flex: 2, child: _buildEducation(context)),
                  ],
                )
              : Column(
                  children: [
                    _buildAboutIntro(context),
                    const SizedBox(height: 80),
                    _buildEducation(context),
                  ],
                ),
        ),

        // Section 2: Technical Skills (Full Width Darker Background)
        _buildSkillsSection(context),

        // Section 3: Experience
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100 : 20,
            vertical: 120,
          ),
          child: _buildExperienceTimeline(context),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildAboutIntro(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 30, height: 2, color: theme.colorScheme.primary),
            const SizedBox(width: 15),
            Text(
              'WHO AM I',
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
          'ABOUT ME',
          style: TextStyle(
            fontSize: 90,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
            height: 1,
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Software Developer with experience building mobile and backend applications using Flutter, Kotlin, FastAPI, PostgreSQL, Firebase, and Generative AI technologies.',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            height: 1.5,
            fontWeight: FontWeight.w300,
            fontSize: 26,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Passionate about building high-performance, user-centric solutions with modern development frameworks and industry best practices. Experienced in developing real-time applications, integrating cloud services, and delivering end-to-end software solutions from concept to deployment.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
            height: 1.8,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surface.withValues(alpha: 0.2),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TECHNICAL SKILLS',
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 80),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 35,
            crossAxisSpacing: 35,
            childAspectRatio: 1.4,
            children: [
              _buildSkillCard(context, 'MOBILE', 'Flutter, Dart, Kotlin, Jetpack Compose, Android SDK', Icons.smartphone),
              _buildSkillCard(context, 'BACKEND', 'Python, FastAPI, JWT, SQLAlchemy, Microservices', Icons.dns),
              _buildSkillCard(context, 'CLOUD & DB', 'PostgreSQL, Firebase, AWS S3, Google Cloud', Icons.cloud),
              _buildSkillCard(context, 'GENERATIVE AI', 'Google AI Studio, Prompt Engineering, LLM Integration', Icons.auto_awesome),
              _buildSkillCard(context, 'STATE MANAGEMENT', 'GetX, Provider, Bloc', Icons.account_tree_outlined),
              _buildSkillCard(context, 'TOOLS', 'Git, Docker, Android Studio, VS Code, Firebase Console', Icons.handyman),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, String title, String skills, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 35),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                skills,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEducation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'EDUCATION',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 40),
        _buildEduItem(
          context,
          'B.E. - INFORMATION SCIENCE',
          'AMC Engineering College, Bengaluru',
          '2022 - 2026',
        ),
        const SizedBox(height: 35),
        _buildEduItem(
          context,
          'HIGHER SECONDARY (12TH)',
          'BSEB Board | 62.7%',
          '2021',
        ),
        const SizedBox(height: 35),
        _buildEduItem(
          context,
          'SECONDARY (10TH)',
          'BSEB Board | 51%',
          '2019',
        ),
      ],
    );
  }

  Widget _buildEduItem(BuildContext context, String title, String sub, String year) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1),
        ),
        const SizedBox(height: 8),
        Text(
          sub,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          year,
          style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
        ),
      ],
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'EXPERIENCE',
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 80),
        _buildTimelineItem(
          context,
          'Android App Development (GenAI) Intern',
          'MindMatrix.io',
          'FEB 2026 - MAY 2026',
          'Successfully completed an industry-oriented internship focused on Android Development, Generative AI, and Cloud Technologies. Worked with Kotlin, Jetpack Compose, Firebase, Google AI Studio, and Google Cloud Labs. Recognized with an Excellent performance rating for overall contribution.',
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, String role, String company, String period, String desc) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 180,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                period,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                role.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                company,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  height: 1.8,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
