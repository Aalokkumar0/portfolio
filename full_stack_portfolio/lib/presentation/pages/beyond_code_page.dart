import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class BeyondCodePage extends StatelessWidget {
  const BeyondCodePage({super.key});

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
                  'LIFE OUTSIDE WORK',
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
              'BEYOND CODE',
              style: TextStyle(
                fontFamily: 'ChelseaMarket',
                fontSize: 80,
                color: Colors.white,
                letterSpacing: 0.5,
                height: 1,
              ),
            ),
            const SizedBox(height: 80),
            _buildInterestItem(
              context,
              'OPEN SOURCE CONTRIBUTOR',
              'I am passionate about giving back to the community. Whether it\'s fixing bugs in libraries I use or sharing my own tools, I believe open source is the heart of innovation.',
              Icons.terminal,
            ),
            const SizedBox(height: 40),
            _buildInterestItem(
              context,
              'CONTINUOUS LEARNING',
              'The tech world moves fast. I spend a significant amount of my time experimenting with new frameworks, reading research papers on AI, and building prototypes of future-ready applications.',
              Icons.menu_book,
            ),
            const SizedBox(height: 40),
            _buildInterestItem(
              context,
              'CYCLING & FITNESS',
              'When I\'m not at my desk, I\'m likely out cycling. It helps me clear my head and find solutions to complex problems I\'m working on.',
              Icons.directions_bike,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestItem(BuildContext context, String title, String description, IconData icon) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 40),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'ChelseaMarket',
                    fontSize: 32,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    height: 1.8,
                    fontSize: 16,
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
