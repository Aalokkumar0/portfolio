import 'dart:math';
import 'package:flutter/material.dart';

/// Animated background with floating gradient orbs that drift slowly,
/// creating a "living" ambient feel behind content.
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
      duration: const Duration(seconds: 20),
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
        // Animated gradient orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _OrbPainter(_controller.value),
              size: Size.infinite,
            );
          },
        ),
        widget.child,
      ],
    );
  }
}

class _OrbPainter extends CustomPainter {
  final double progress;
  _OrbPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final orbs = [
      _Orb(
        color: const Color(0xFF38BDF8),
        baseX: 0.15,
        baseY: 0.2,
        radius: size.width * 0.25,
        speed: 1.0,
        opacity: 0.06,
      ),
      _Orb(
        color: const Color(0xFF818CF8),
        baseX: 0.75,
        baseY: 0.15,
        radius: size.width * 0.3,
        speed: 0.7,
        opacity: 0.05,
      ),
      _Orb(
        color: const Color(0xFFA78BFA),
        baseX: 0.5,
        baseY: 0.7,
        radius: size.width * 0.28,
        speed: 0.5,
        opacity: 0.04,
      ),
      _Orb(
        color: const Color(0xFF38BDF8),
        baseX: 0.85,
        baseY: 0.8,
        radius: size.width * 0.2,
        speed: 0.8,
        opacity: 0.05,
      ),
    ];

    for (final orb in orbs) {
      final dx = sin(progress * 2 * pi * orb.speed) * size.width * 0.05;
      final dy = cos(progress * 2 * pi * orb.speed * 0.7) * size.height * 0.04;

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
  bool shouldRepaint(_OrbPainter oldDelegate) => oldDelegate.progress != progress;
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
