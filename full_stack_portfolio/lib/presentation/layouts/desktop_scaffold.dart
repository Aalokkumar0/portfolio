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
        toolbarHeight: 80,
        titleSpacing: 80,
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
          const SizedBox(width: 15),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 22),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colorScheme.primary.withOpacity(0.8)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text(
                'RESUME',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          const SizedBox(width: 80),
        ],
      ),
      body: child,
    );
  }

  Widget _navLink(String title, String section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextButton(
        onPressed: () => onSectionTap?.call(section),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
