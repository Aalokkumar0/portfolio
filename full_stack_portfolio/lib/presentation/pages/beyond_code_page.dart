import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/animated_section.dart';

class BeyondCodePage extends StatelessWidget {
  const BeyondCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 100,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'LIFE OUTSIDE WORK',
            title: 'BEYOND\nCODE',
          ),
          const SizedBox(height: 80),
          AnimatedSection(
            child: _buildInterestItem(
              context,
              'OPEN SOURCE CONTRIBUTOR',
              'I am passionate about giving back to the community. Whether it\'s fixing bugs in libraries I use or sharing my own tools, I believe open source is the heart of innovation.',
              Icons.terminal_rounded,
              0,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSection(
            delay: const Duration(milliseconds: 150),
            child: _buildInterestItem(
              context,
              'CONTINUOUS LEARNING',
              'The tech world moves fast. I spend a significant amount of my time experimenting with new frameworks, reading research papers on AI, and building prototypes of future-ready applications.',
              Icons.auto_stories_rounded,
              1,
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSection(
            delay: const Duration(milliseconds: 300),
            child: _buildInterestItem(
              context,
              'CYCLING & FITNESS',
              'When I\'m not at my desk, I\'m likely out cycling. It helps me clear my head and find solutions to complex problems I\'m working on.',
              Icons.directions_bike_rounded,
              2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestItem(BuildContext context, String title, String description, IconData icon, int index) {
    const cardColors = [AppTheme.lavender, AppTheme.mintCyan, AppTheme.blushPink];
    final accentColor = cardColors[index];

    return GlassCard(
      padding: const EdgeInsets.all(36),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: accentColor.withValues(alpha: 0.12),
              border: Border.all(
                color: accentColor.withValues(alpha: 0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: accentColor, size: 30),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  description,
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
      ),
    );
  }
}
