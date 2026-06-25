import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Column(
      children: [
        // Section 1: About Intro + Education
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100 : 24,
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

        // Section 2: Technical Skills
        _buildSkillsSection(context),

        // Section 3: Experience
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 100 : 24,
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
        const SectionHeader(label: 'WHO AM I', title: 'ABOUT ME', titleFontSize: 80),
        const SizedBox(height: 40),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Aspiring Software Developer skilled in Flutter, Kotlin, FastAPI, PostgreSQL, Firebase, and Generative AI, building scalable mobile, backend, and AI-powered applications with a focus on performance and user experience.',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              height: 1.5,
              fontWeight: FontWeight.w300,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 30),
        AnimatedSection(
          delay: const Duration(milliseconds: 400),
          child: Text(
            'Passionate about building high-performance, user-centric solutions with modern development frameworks. Experienced in developing real-time applications, integrating cloud services, contributing across the full development lifecycle from UI/UX design to deployment and optimization.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.45),
              height: 1.8,
              fontSize: 16,
            ),
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
          const SectionHeader(
            label: 'MY TOOLKIT',
            title: 'TECHNICAL\nSKILLS',
            titleFontSize: 64,
          ),
          const SizedBox(height: 80),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: isDesktop ? 1.4 : 1.8,
            children: [
              _buildSkillCard(context, 'MOBILE', 'Flutter, Dart, Kotlin, Android SDK, Material Design', Icons.smartphone_rounded, 0),
              _buildSkillCard(context, 'BACKEND', 'Python, FastAPI, JWT Auth, SQLAlchemy, Microservices', Icons.dns_rounded, 1),
              _buildSkillCard(context, 'CLOUD & DB', 'PostgreSQL, Firebase, AWS S3, Google Cloud Platform', Icons.cloud_rounded, 2),
              _buildSkillCard(context, 'GENERATIVE AI', 'Google AI Studio, OpenAI APIs, Prompt Engineering, LLM Integration', Icons.auto_awesome_rounded, 3),
              _buildSkillCard(context, 'STATE MGMT', 'GetX, Provider, Bloc', Icons.account_tree_rounded, 4),
              _buildSkillCard(context, 'ARCHITECTURE', 'MVC, MVP, MVVM, Clean Architecture, OOP, API Integration', Icons.architecture_rounded, 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, String title, String skills, IconData icon, int index) {
    final theme = Theme.of(context);
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];

    return AnimatedSection(
      delay: Duration(milliseconds: 100 * index),
      child: GlassCard(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: colors[index].withValues(alpha: 0.1),
              ),
              child: Icon(icon, color: colors[index], size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
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
      ),
    );
  }

  Widget _buildEducation(BuildContext context) {
    return AnimatedSection(
      delay: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Colors.white, Colors.white.withValues(alpha: 0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            child: const Text(
              'EDUCATION',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _buildEduItem(
            context,
            'B.E. - INFORMATION SCIENCE & ENGINEERING',
            'AMC Engineering College, Bengaluru',
            'GRADUATING JUL 2026',
          ),
          const SizedBox(height: 35),
          _buildEduItem(
            context,
            'HIGHER SECONDARY (12TH)',
            'Sarvoday High School, Gangasagar',
            '2022',
          ),
          const SizedBox(height: 35),
          _buildEduItem(
            context,
            'SECONDARY (10TH)',
            'I S High School, Basopatti',
            '2019',
          ),
        ],
      ),
    );
  }

  Widget _buildEduItem(BuildContext context, String title, String sub, String year) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 15,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            sub,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          // Year badge with gradient
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.15),
                  theme.colorScheme.secondary.withValues(alpha: 0.1),
                ],
              ),
            ),
            child: Text(
              year,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          label: 'MY JOURNEY',
          title: 'EXPERIENCE',
          titleFontSize: 64,
        ),
        const SizedBox(height: 80),
        AnimatedSection(
          child: _buildTimelineItem(
            context,
            'Android App Development (GenAI) Intern',
            'MindMatrix.io',
            'FEB 2026 - MAY 2026',
            'Completed an Android Development and Generative AI internship, building cloud-integrated mobile applications with Kotlin, Jetpack Compose, Firebase, and Google Cloud. Contributed across the full development lifecycle, from UI/UX design to deployment and optimization, earning an Excellent Performance Rating.',
          ),
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
            // Pulsing dot
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            // Gradient line
            Container(
              width: 2,
              height: 180,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.15),
                      theme.colorScheme.secondary.withValues(alpha: 0.1),
                    ],
                  ),
                ),
                child: Text(
                  period,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                role.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                company,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.45),
                  height: 1.8,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
