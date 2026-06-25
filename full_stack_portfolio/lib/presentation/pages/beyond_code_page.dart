import 'package:flutter/material.dart';
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
        vertical: 120,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            label: 'LIFE OUTSIDE WORK',
            title: 'BEYOND\nCODE',
          ),
          const SizedBox(height: 100),
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
            delay: const Duration(milliseconds: 200),
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
            delay: const Duration(milliseconds: 400),
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
    final theme = Theme.of(context);
    final colors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      theme.colorScheme.tertiary,
    ];
    final accentColor = colors[index];

    return GlassCard(
      padding: const EdgeInsets.all(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accentColor.withValues(alpha: 0.15),
                  accentColor.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Icon(icon, color: accentColor, size: 32),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
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
      ),
    );
  }
}
