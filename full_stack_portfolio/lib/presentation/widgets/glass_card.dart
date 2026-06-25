import 'dart:ui';
import 'package:flutter/material.dart';

/// A glassmorphism card with optional hover effects.
/// Features: frosted glass background, gradient border on hover,
/// subtle lift animation.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final bool enableHover;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(40),
    this.borderRadius = 16,
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
      duration: const Duration(milliseconds: 300),
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
            final hoverValue = _hoverAnimation.value;
            return Transform.translate(
              offset: Offset(0, -4 * hoverValue),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.03 + 0.03 * hoverValue),
                      Colors.white.withValues(alpha: 0.01 + 0.02 * hoverValue),
                    ],
                  ),
                  border: Border.all(
                    color: Color.lerp(
                      Colors.white.withValues(alpha: 0.06),
                      const Color(0xFF38BDF8).withValues(alpha: 0.3),
                      hoverValue,
                    )!,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.05 * hoverValue),
                      blurRadius: 30 * hoverValue,
                      offset: Offset(0, 10 * hoverValue),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10 * hoverValue,
                      sigmaY: 10 * hoverValue,
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
