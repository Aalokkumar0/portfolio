import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A widget that fades in and slides up when it becomes visible in the viewport.
/// Uses a persistent frame callback for reliable visibility detection inside
/// any scroll view, including [SingleChildScrollView].
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
    this.slideOffset = 40,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Slide: drive a 0→1 value and multiply in the build
    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Start checking visibility every frame
    SchedulerBinding.instance.addPostFrameCallback(_checkVisibilityLoop);
  }

  void _checkVisibilityLoop(Duration _) {
    if (!mounted || _hasAnimated) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) {
      // Not laid out yet — try again next frame
      SchedulerBinding.instance.addPostFrameCallback(_checkVisibilityLoop);
      return;
    }

    try {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final screenHeight = MediaQuery.of(context).size.height;

      // Trigger when the top of the widget is within the viewport
      final isVisible = position.dy < screenHeight * 0.92 &&
          position.dy + size.height > 0;

      if (isVisible) {
        _triggerAnimation();
      } else {
        // Not visible yet — check again next frame
        SchedulerBinding.instance.addPostFrameCallback(_checkVisibilityLoop);
      }
    } catch (_) {
      // Coordinate transform failed, retry
      SchedulerBinding.instance.addPostFrameCallback(_checkVisibilityLoop);
    }
  }

  void _triggerAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;
    if (widget.delay == Duration.zero) {
      if (mounted) _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final slideValue = _slideAnimation.value * widget.slideOffset;
        return Transform.translate(
          offset: Offset(0, slideValue),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
