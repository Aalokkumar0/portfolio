import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../layouts/responsive_layout.dart';
import 'animated_section.dart';

/// Reusable animated section header with dreamy cotton candy styling.
/// Automatically scales the title font size for mobile screens.
class SectionHeader extends StatelessWidget {
  final String label;
  final String title;

  /// Font size used on desktop. On mobile it is automatically scaled down.
  final double titleFontSize;

  /// Optional override for the mobile font size. If null, computed automatically.
  final double? mobileTitleFontSize;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.titleFontSize = 72,
    this.mobileTitleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);

    // Scale desktop size down proportionally for mobile, capped at 38
    final effectiveFontSize = isMobile
        ? (mobileTitleFontSize ?? (titleFontSize * 0.52).clamp(28.0, 42.0))
        : titleFontSize;

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
          // Giant title with gradient — no newlines on mobile for multi-word titles
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppTheme.textPrimary, AppTheme.lavender],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              // Replace literal newlines with a space on mobile so text
              // wraps naturally at word boundaries instead of mid-word.
              isMobile ? title.replaceAll('\n', ' ') : title,
              style: TextStyle(
                fontSize: effectiveFontSize,
                fontWeight: FontWeight.w900,
                color: AppTheme.textPrimary,
                letterSpacing: isMobile ? 0.5 : 1,
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
