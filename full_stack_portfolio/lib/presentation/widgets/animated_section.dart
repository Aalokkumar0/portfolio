import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A widget that fades in and slides up when it enters the viewport.
/// Reliably works inside [SingleChildScrollView] by polling each frame.
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 450),
    this.slideOffset = 36,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  // Keep everything as double to avoid any Offset-cast issues
  late final Animation<double> _fade;
  late final Animation<double> _slide; // 1.0 → 0.0 (multiplied by slideOffset)

  bool _triggered = false;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    _slide = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );

    // Poll every frame until the widget is visible
    SchedulerBinding.instance.addPostFrameCallback(_poll);
  }

  void _poll(Duration _) {
    if (!mounted || _triggered) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      SchedulerBinding.instance.addPostFrameCallback(_poll);
      return;
    }

    try {
      final topLeft = box.localToGlobal(Offset.zero);
      final h = MediaQuery.of(context).size.height;
      final inView = topLeft.dy < h * 0.93 && topLeft.dy + box.size.height > 0;

      if (inView) {
        _triggered = true;
        if (widget.delay == Duration.zero) {
          _ctrl.forward();
        } else {
          Future.delayed(widget.delay, () {
            if (mounted) _ctrl.forward();
          });
        }
      } else {
        SchedulerBinding.instance.addPostFrameCallback(_poll);
      }
    } catch (_) {
      SchedulerBinding.instance.addPostFrameCallback(_poll);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, child) {
        final dy = _slide.value * widget.slideOffset;
        return Transform.translate(
          offset: Offset(0, dy),
          child: Opacity(opacity: _fade.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
