import 'package:flutter/material.dart';

class DesktopScaffold extends StatelessWidget {
  final Widget child;
  final Function(String)? onSectionTap;

  const DesktopScaffold({super.key, required this.child, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        titleSpacing: 100,
        backgroundColor: Colors.transparent,
        title: GestureDetector(
          onTap: () => onSectionTap?.call('home'),
          child: Text(
            'AK.',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        actions: [
          _navLink('ABOUT', 'about'),
          _navLink('SKILLS', 'skills'),
          _navLink('EXPERIENCE', 'experience'),
          _navLink('PROJECTS', 'projects'),
          _navLink('BEYOND CODE', 'beyond-code'),
          _navLink('CONTACT', 'contact'),
          const SizedBox(width: 25),
          // Blogs Button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.6), width: 1.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: () => onSectionTap?.call('blogs'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                'BLOGS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 100),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: child,
    );
  }

  Widget _navLink(String title, String section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TextButton(
        onPressed: () => onSectionTap?.call(section),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
