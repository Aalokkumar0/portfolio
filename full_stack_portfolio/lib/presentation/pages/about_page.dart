import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
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
            vertical: isDesktop ? 100 : 60,
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
                    const SizedBox(height: 60),
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
            vertical: isDesktop ? 100 : 60,
          ),
          child: _buildExperienceTimeline(context),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildAboutIntro(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(label: 'WHO AM I', title: 'ABOUT ME', titleFontSize: 72),
        const SizedBox(height: 40),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Aspiring Software Developer skilled in Flutter, Kotlin, FastAPI, PostgreSQL, Firebase, and Generative AI, building scalable mobile, backend, and AI-powered applications with a focus on performance and user experience.',
            style: TextStyle(
              color: AppTheme.textPrimary,
              height: 1.55,
              fontWeight: FontWeight.w500,
              fontSize: isDesktop ? 22 : 16,
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedSection(
          delay: const Duration(milliseconds: 400),
          child: const Text(
            'Passionate about building high-performance, user-centric solutions with modern development frameworks. Experienced in developing real-time applications, integrating cloud services, contributing across the full development lifecycle from UI/UX design to deployment and optimization.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              height: 1.8,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final skillData = [
      _SkillItem('MOBILE', 'Flutter, Dart, Kotlin, Android SDK, Material Design', Icons.smartphone_rounded, AppTheme.lavender),
      _SkillItem('BACKEND', 'Python, FastAPI, JWT Auth, SQLAlchemy, Microservices', Icons.dns_rounded, AppTheme.mintCyan),
      _SkillItem('CLOUD & DB', 'PostgreSQL, Firebase, AWS S3, Google Cloud Platform', Icons.cloud_rounded, AppTheme.blushPink),
      _SkillItem('GENERATIVE AI', 'Google AI Studio, OpenAI APIs, Prompt Engineering, LLM Integration', Icons.auto_awesome_rounded, AppTheme.lavender),
      _SkillItem('STATE MGMT', 'GetX, Provider, Bloc', Icons.account_tree_rounded, AppTheme.mintCyan),
      _SkillItem('ARCHITECTURE', 'MVC, MVP, MVVM, Clean Architecture, OOP, API Integration', Icons.architecture_rounded, AppTheme.blushPink),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.lavender.withValues(alpha: 0.07),
            AppTheme.mintCyan.withValues(alpha: 0.07),
            AppTheme.blushPink.withValues(alpha: 0.05),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'MY TOOLKIT',
            title: 'TECHNICAL SKILLS',
            titleFontSize: 60,
          ),
          SizedBox(height: isDesktop ? 64 : 36),
          if (isDesktop)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.4,
              children: skillData.asMap().entries.map((e) =>
                _buildSkillCard(context, e.value, e.key)
              ).toList(),
            )
          else
            // Mobile: IntrinsicHeight row pairs — no overflow
            Column(
              children: [
                for (var i = 0; i < skillData.length; i += 2) ...[
                  AnimatedSection(
                    delay: Duration(milliseconds: 80 * (i ~/ 2)),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: _buildSkillCard(context, skillData[i], i, animated: false)),
                          const SizedBox(width: 12),
                          if (i + 1 < skillData.length)
                            Expanded(child: _buildSkillCard(context, skillData[i + 1], i + 1, animated: false))
                          else
                            const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  if (i + 2 < skillData.length) const SizedBox(height: 12),
                ],
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, _SkillItem item, int idx, {bool animated = true}) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final card = GlassCard(
      padding: EdgeInsets.all(isDesktop ? 28 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop ? 10 : 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: item.color.withValues(alpha: 0.15),
              border: Border.all(
                color: item.color.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Icon(item.icon, color: item.color, size: isDesktop ? 22 : 18),
          ),
          SizedBox(height: isDesktop ? 16 : 10),
          Text(
            item.title,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: isDesktop ? 15 : 12,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: isDesktop ? 8 : 6),
          Text(
            item.skills,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: isDesktop ? 13 : 11,
              height: 1.55,
            ),
          ),
        ],
      ),
    );

    if (!animated) return card;
    return AnimatedSection(
      delay: Duration(milliseconds: 100 * idx),
      child: card,
    );
  }

  Widget _buildEducation(BuildContext context) {
    return AnimatedSection(
      delay: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppTheme.textPrimary, AppTheme.lavender],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'EDUCATION',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: AppTheme.textPrimary,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 36),
          _buildEduItem(
            context,
            'B.E. - INFORMATION SCIENCE & ENGINEERING',
            'AMC Engineering College, Bengaluru',
            'GRADUATING JUL 2026',
            AppTheme.lavender,
          ),
          const SizedBox(height: 20),
          _buildEduItem(
            context,
            'HIGHER SECONDARY (12TH)',
            'Sarvoday High School, Gangasagar',
            '2022',
            AppTheme.blushPink,
          ),
          const SizedBox(height: 20),
          _buildEduItem(
            context,
            'SECONDARY (10TH)',
            'I S High School, Basopatti',
            '2019',
            AppTheme.mintCyan,
          ),
        ],
      ),
    );
  }

  Widget _buildEduItem(BuildContext context, String title, String sub, String year, Color color) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            sub,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: color.withValues(alpha: 0.12),
            ),
            child: Text(
              year,
              style: TextStyle(
                color: color,
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
          titleFontSize: 60,
        ),
        const SizedBox(height: 64),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
            Container(
              width: 2,
              height: 180,
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
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(
                    colors: [AppTheme.lavender, AppTheme.blushPink],
                  ),
                ),
                child: Text(
                  period,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = ResponsiveLayout.isMobile(context);
                  return Text(
                    role.toUpperCase(),
                    style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 18 : 26,
                      letterSpacing: 0.5,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                company,
                style: const TextStyle(
                  color: AppTheme.lavender,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                desc,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
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

// ──────────────────────────────────────────────────────────
// Data class for skill cards
// ──────────────────────────────────────────────────────────
class _SkillItem {
  final String title;
  final String skills;
  final IconData icon;
  final Color color;
  const _SkillItem(this.title, this.skills, this.icon, this.color);
}
