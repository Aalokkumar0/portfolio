import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class BeyondCodePage extends StatelessWidget {
  const BeyondCodePage({super.key});

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 30, height: 2, color: theme.colorScheme.primary),
              const SizedBox(width: 15),
              Text(
                'LIFE OUTSIDE WORK',
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
            'BEYOND CODE',
            style: TextStyle(
              fontSize: 90,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
              height: 1,
            ),
          ),
          const SizedBox(height: 100),
          _buildInterestItem(
            context,
            'OPEN SOURCE CONTRIBUTOR',
            'I am passionate about giving back to the community. Whether it\'s fixing bugs in libraries I use or sharing my own tools, I believe open source is the heart of innovation.',
            Icons.terminal_rounded,
          ),
          const SizedBox(height: 45),
          _buildInterestItem(
            context,
            'CONTINUOUS LEARNING',
            'The tech world moves fast. I spend a significant amount of my time experimenting with new frameworks, reading research papers on AI, and building prototypes of future-ready applications.',
            Icons.auto_stories_rounded,
          ),
          const SizedBox(height: 45),
          _buildInterestItem(
            context,
            'CYCLING & FITNESS',
            'When I\'m not at my desk, I\'m likely out cycling. It helps me clear my head and find solutions to complex problems I\'m working on.',
            Icons.directions_bike_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildInterestItem(BuildContext context, String title, String description, IconData icon) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 45),
          const SizedBox(width: 40),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    height: 1.8,
                    fontSize: 17,
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
