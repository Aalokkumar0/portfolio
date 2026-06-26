import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'animated_section.dart';

/// Reusable animated section header with dreamy cotton candy styling.
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final double titleFontSize;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.titleFontSize = 72,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pill label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                colors: [AppTheme.lavender, AppTheme.blushPink],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lavender.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Giant title with gradient
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppTheme.textPrimary, AppTheme.lavender],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w900,
                color: AppTheme.textPrimary,
                letterSpacing: 1,
                height: 1.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
