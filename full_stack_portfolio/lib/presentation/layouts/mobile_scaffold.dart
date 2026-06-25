import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class MobileScaffold extends StatelessWidget {
  final Widget child;
  final Function(String)? onSectionTap;

  const MobileScaffold({super.key, required this.child, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFF020617).withValues(alpha: 0.8),
        surfaceTintColor: Colors.transparent,
        title: GestureDetector(
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
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 24,
                letterSpacing: -1,
              ),
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white.withValues(alpha: 0.7)),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.transparent),
          ),
        ),
      ),
      drawer: _MobileDrawer(onSectionTap: onSectionTap),
      body: GradientBackground(child: child),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final Function(String)? onSectionTap;
  const _MobileDrawer({this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: const Color(0xFF0A0F1E),
      child: Column(
        children: [
          // Gradient header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(30, 80, 30, 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.15),
                  theme.colorScheme.secondary.withValues(alpha: 0.1),
                  const Color(0xFF0A0F1E),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ).createShader(bounds),
                  child: const Text(
                    'AK.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Full Stack Developer',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _DrawerTile(title: 'HOME', section: 'home', icon: Icons.home_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'ABOUT', section: 'about', icon: Icons.person_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'SKILLS', section: 'skills', icon: Icons.code_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'EXPERIENCE', section: 'experience', icon: Icons.work_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'PROJECTS', section: 'projects', icon: Icons.rocket_launch_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'BEYOND CODE', section: 'beyond-code', icon: Icons.interests_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'BLOGS', section: 'blogs', icon: Icons.article_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'CONTACT', section: 'contact', icon: Icons.mail_rounded, onSectionTap: onSectionTap),
          const Spacer(),
          // Bottom accent
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary.withValues(alpha: 0.5),
                    theme.colorScheme.secondary.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatefulWidget {
  final String title;
  final String section;
  final IconData icon;
  final Function(String)? onSectionTap;

  const _DrawerTile({
    required this.title,
    required this.section,
    required this.icon,
    this.onSectionTap,
  });

  @override
  State<_DrawerTile> createState() => _DrawerTileState();
}

class _DrawerTileState extends State<_DrawerTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _isHovered
              ? theme.colorScheme.primary.withValues(alpha: 0.08)
              : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: _isHovered
                ? theme.colorScheme.primary
                : Colors.white.withValues(alpha: 0.4),
            size: 22,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.6),
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          onTap: () {
            widget.onSectionTap?.call(widget.section);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
