import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class DesktopScaffold extends StatelessWidget {
  final Widget child;
  final Function(String)? onSectionTap;

  const DesktopScaffold({super.key, required this.child, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _GlassAppBar(onSectionTap: onSectionTap),
      ),
      body: GradientBackground(child: child),
    );
  }
}

class _GlassAppBar extends StatelessWidget {
  final Function(String)? onSectionTap;
  const _GlassAppBar({this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            color: const Color(0xFF020617).withValues(alpha: 0.7),
            child: Row(
              children: [
                // Logo
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onSectionTap?.call('home'),
                    child: ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        'AK.',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Nav links
                _NavLink(title: 'ABOUT', section: 'about', onTap: onSectionTap),
                _NavLink(title: 'SKILLS', section: 'skills', onTap: onSectionTap),
                _NavLink(title: 'EXPERIENCE', section: 'experience', onTap: onSectionTap),
                _NavLink(title: 'PROJECTS', section: 'projects', onTap: onSectionTap),
                _NavLink(title: 'BEYOND CODE', section: 'beyond-code', onTap: onSectionTap),
                _NavLink(title: 'CONTACT', section: 'contact', onTap: onSectionTap),
                const SizedBox(width: 20),
                // Blogs button with gradient border
                _BlogsButton(onTap: () => onSectionTap?.call('blogs')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual nav link with animated hover underline
class _NavLink extends StatefulWidget {
  final String title;
  final String section;
  final Function(String)? onTap;

  const _NavLink({required this.title, required this.section, this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _widthAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: () => widget.onTap?.call(widget.section),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Text(
                    widget.title,
                    style: TextStyle(
                      color: Color.lerp(
                        Colors.white.withValues(alpha: 0.5),
                        Colors.white,
                        _widthAnimation.value,
                      ),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _widthAnimation,
                builder: (context, _) {
                  return Container(
                    height: 2,
                    width: 20 * _widthAnimation.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Blogs button with gradient border and hover fill
class _BlogsButton extends StatefulWidget {
  final VoidCallback? onTap;
  const _BlogsButton({this.onTap});

  @override
  State<_BlogsButton> createState() => _BlogsButtonState();
}

class _BlogsButtonState extends State<_BlogsButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.1 + 0.9 * _animation.value),
                    theme.colorScheme.secondary.withValues(alpha: 0.1 + 0.9 * _animation.value),
                  ],
                ),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Text(
                'BLOGS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
