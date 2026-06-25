import 'package:flutter/material.dart';

/// A widget that fades in and slides up when it becomes visible in the viewport.
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 800),
    this.slideOffset = 60,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupScrollListener();
    });
  }

  void _setupScrollListener() {
    if (!mounted || _hasAnimated) return;

    final scrollableState = Scrollable.maybeOf(context);
    if (scrollableState != null) {
      _scrollPosition = scrollableState.position;
      _scrollPosition!.addListener(_onScroll);
      _checkVisibility();
    } else {
      // No scrollable ancestor — animate immediately
      _triggerAnimation();
    }
  }

  void _onScroll() {
    if (!mounted || _hasAnimated) return;
    _checkVisibility();
  }

  void _checkVisibility() {
    if (_hasAnimated || !mounted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.attached) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final viewportHeight = MediaQuery.of(context).size.height;

    // Trigger when the top of the widget enters the lower 90% of the viewport
    if (offset.dy < viewportHeight * 0.9 && offset.dy + renderBox.size.height > 0) {
      _triggerAnimation();
    }
  }

  void _triggerAnimation() {
    if (_hasAnimated) return;
    _hasAnimated = true;
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    // Use the stored reference instead of looking up context during dispose
    _scrollPosition?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
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
