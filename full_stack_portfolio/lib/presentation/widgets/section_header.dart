import 'package:flutter/material.dart';
import 'animated_section.dart';

/// Reusable animated section header with the "gradient line + label + giant title" pattern.
/// Reduces duplication across all section pages.
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final double titleFontSize;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.titleFontSize = 80,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Gradient accent line
              Container(
                width: 35,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                label,
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withValues(alpha: 0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ).createShader(bounds),
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 2,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
