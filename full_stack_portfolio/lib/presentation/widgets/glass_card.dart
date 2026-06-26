import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// A soft glassmorphism card with pastel cotton candy hover effects.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final bool enableHover;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(36),
    this.borderRadius = 24,
    this.enableHover = true,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _hoverAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: widget.enableHover ? (_) => _hoverController.forward() : null,
      onExit: widget.enableHover ? (_) => _hoverController.reverse() : null,
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverAnimation,
          builder: (context, child) {
            final h = _hoverAnimation.value;
            return Transform.translate(
              offset: Offset(0, -6 * h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.85 + 0.12 * h),
                      AppTheme.lavender.withValues(alpha: 0.05 + 0.07 * h),
                    ],
                  ),
                  border: Border.all(
                    color: Color.lerp(
                      const Color(0xFFEEDCFF),
                      AppTheme.lavender,
                      h * 0.6,
                    )!,
                    width: 1.5,
                  ),
                  boxShadow: [
                    // Soft pastel outer glow
                    BoxShadow(
                      color: AppTheme.lavender.withValues(alpha: 0.12 + 0.18 * h),
                      blurRadius: 20 + 20 * h,
                      spreadRadius: -2,
                      offset: Offset(0, 6 + 6 * h),
                    ),
                    // Inner white highlight
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.7),
                      blurRadius: 0,
                      spreadRadius: 0,
                      offset: const Offset(-2, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4 + 8 * h,
                      sigmaY: 4 + 8 * h,
                    ),
                    child: Padding(
                      padding: widget.padding,
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
