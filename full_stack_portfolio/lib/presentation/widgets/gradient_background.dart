import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Animated background with soft floating cotton candy orbs.
class GradientBackground extends StatefulWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dreamy base gradient
        Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.heroGradient,
          ),
        ),
        // Animated soft orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _CandyOrbPainter(_controller.value),
              size: Size.infinite,
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _CandyOrbPainter extends CustomPainter {
  final double progress;
  _CandyOrbPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final orbs = [
      _Orb(
        color: AppTheme.lavender,
        baseX: 0.1,
        baseY: 0.1,
        radius: size.width * 0.3,
        speed: 1.0,
        opacity: 0.18,
      ),
      _Orb(
        color: AppTheme.blushPink,
        baseX: 0.8,
        baseY: 0.15,
        radius: size.width * 0.28,
        speed: 0.65,
        opacity: 0.14,
      ),
      _Orb(
        color: AppTheme.mintCyan,
        baseX: 0.5,
        baseY: 0.75,
        radius: size.width * 0.32,
        speed: 0.45,
        opacity: 0.12,
      ),
      _Orb(
        color: AppTheme.softPink,
        baseX: 0.9,
        baseY: 0.85,
        radius: size.width * 0.22,
        speed: 0.8,
        opacity: 0.15,
      ),
      _Orb(
        color: AppTheme.lavender,
        baseX: 0.3,
        baseY: 0.6,
        radius: size.width * 0.18,
        speed: 1.2,
        opacity: 0.10,
      ),
    ];

    for (final orb in orbs) {
      final dx = sin(progress * 2 * pi * orb.speed) * size.width * 0.04;
      final dy = cos(progress * 2 * pi * orb.speed * 0.7) * size.height * 0.035;

      final center = Offset(
        size.width * orb.baseX + dx,
        size.height * orb.baseY + dy,
      );

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            orb.color.withValues(alpha: orb.opacity),
            orb.color.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: orb.radius));

      canvas.drawCircle(center, orb.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_CandyOrbPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _Orb {
  final Color color;
  final double baseX, baseY, radius, speed, opacity;
  const _Orb({
    required this.color,
    required this.baseX,
    required this.baseY,
    required this.radius,
    required this.speed,
    required this.opacity,
  });
}
