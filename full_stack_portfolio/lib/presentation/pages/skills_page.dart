import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  static const _categories = [
    _SkillCategory('MOBILE', ['Flutter', 'Dart', 'Kotlin', 'Android SDK', 'Material Design'], Icons.smartphone_rounded, 0),
    _SkillCategory('BACKEND', ['Python', 'FastAPI', 'JWT Auth', 'SQLAlchemy', 'Microservices'], Icons.dns_rounded, 1),
    _SkillCategory('AI & LLMS', ['Google AI Studio', 'OpenAI APIs', 'Prompt Engineering', 'LLM Integration'], Icons.auto_awesome_rounded, 2),
    _SkillCategory('DATABASE & CLOUD', ['PostgreSQL', 'Firebase', 'AWS S3', 'Google Cloud'], Icons.storage_rounded, 3),
    _SkillCategory('ARCHITECTURE', ['MVC', 'MVP', 'MVVM', 'Clean Architecture', 'OOP'], Icons.architecture_rounded, 4),
    _SkillCategory('DEV TOOLS', ['Git', 'GitHub', 'Docker', 'Android Studio', 'VS Code'], Icons.handyman_rounded, 5),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: isDesktop ? 100 : 60,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'WHAT I KNOW',
            title: 'TECHNICAL SKILLS',
          ),
          SizedBox(height: isDesktop ? 80 : 40),
          if (isDesktop)
            // Desktop: 3-col fixed-ratio grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: _categories
                  .map((c) => _SkillCard(category: c))
                  .toList(),
            )
          else
            // Mobile: Column of rows — cards grow to fit content, no overflow
            _MobileSkillGrid(categories: _categories),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Data model
// ──────────────────────────────────────────────────────────
class _SkillCategory {
  final String title;
  final List<String> skills;
  final IconData icon;
  final int index;
  const _SkillCategory(this.title, this.skills, this.icon, this.index);
}

// ──────────────────────────────────────────────────────────
// Mobile 2-column grid using Row + IntrinsicHeight so each
// pair of cards stretches to the taller sibling's height.
// ──────────────────────────────────────────────────────────
class _MobileSkillGrid extends StatelessWidget {
  final List<_SkillCategory> categories;
  const _MobileSkillGrid({required this.categories});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < categories.length; i += 2) {
      final left = categories[i];
      final right = i + 1 < categories.length ? categories[i + 1] : null;

      rows.add(
        AnimatedSection(
          delay: Duration(milliseconds: 80 * (i ~/ 2)),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _SkillCard(category: left, animated: false)),
                const SizedBox(width: 12),
                if (right != null)
                  Expanded(child: _SkillCard(category: right, animated: false))
                else
                  const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      );

      if (i + 2 < categories.length) {
        rows.add(const SizedBox(height: 12));
      }
    }
    return Column(children: rows);
  }
}

// ──────────────────────────────────────────────────────────
// Individual skill card
// ──────────────────────────────────────────────────────────
class _SkillCard extends StatelessWidget {
  final _SkillCategory category;
  final bool animated;

  const _SkillCard({required this.category, this.animated = true});

  static const _colors = [
    AppTheme.lavender,
    AppTheme.mintCyan,
    AppTheme.blushPink,
    AppTheme.lavender,
    AppTheme.mintCyan,
    AppTheme.blushPink,
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final color = _colors[category.index];

    final card = GlassCard(
      padding: EdgeInsets.all(isDesktop ? 28 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(isDesktop ? 12 : 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: color.withValues(alpha: 0.15),
              border: Border.all(color: color.withValues(alpha: 0.25), width: 1),
            ),
            child: Icon(category.icon, color: color, size: isDesktop ? 26 : 20),
          ),
          SizedBox(height: isDesktop ? 20 : 12),
          // Title
          Text(
            category.title,
            style: TextStyle(
              fontSize: isDesktop ? 16 : 13,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              letterSpacing: 0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: isDesktop ? 14 : 10),
          // Skill chips
          Wrap(
            spacing: isDesktop ? 8 : 5,
            runSpacing: isDesktop ? 8 : 5,
            children: category.skills.map((skill) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 12 : 8,
                vertical: isDesktop ? 6 : 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: color.withValues(alpha: 0.1),
                border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
              ),
              child: Text(
                skill,
                style: TextStyle(
                  color: color,
                  fontSize: isDesktop ? 11 : 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );

    if (!animated) return card;
    return AnimatedSection(
      delay: Duration(milliseconds: 100 * category.index),
      child: card,
    );
  }
}
