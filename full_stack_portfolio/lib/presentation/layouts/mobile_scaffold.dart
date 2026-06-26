import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/gradient_background.dart';

class MobileScaffold extends StatelessWidget {
  final Widget child;
  final Function(String)? onSectionTap;

  const MobileScaffold({super.key, required this.child, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.82),
        surfaceTintColor: Colors.transparent,
        title: GestureDetector(
          onTap: () => onSectionTap?.call('home'),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppTheme.lavender, AppTheme.blushPink],
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
        iconTheme: const IconThemeData(color: AppTheme.lavender),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.transparent),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.lavender, AppTheme.blushPink, AppTheme.mintCyan],
              ),
            ),
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
    return Drawer(
      backgroundColor: AppTheme.scaffoldBg,
      child: Column(
        children: [
          // Gradient header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(28, 80, 28, 36),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFEEDCFF),
                  Color(0xFFFFDDF0),
                  Color(0xFFE0F6FA),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [AppTheme.lavender, AppTheme.blushPink],
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
                const Text(
                  'Full Stack Developer',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _DrawerTile(title: 'HOME', section: 'home', icon: Icons.home_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'ABOUT', section: 'about', icon: Icons.person_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'SKILLS', section: 'skills', icon: Icons.code_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'EXPERIENCE', section: 'experience', icon: Icons.work_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'PROJECTS', section: 'projects', icon: Icons.rocket_launch_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'BEYOND CODE', section: 'beyond-code', icon: Icons.interests_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'BLOGS', section: 'blogs', icon: Icons.article_rounded, onSectionTap: onSectionTap),
          _DrawerTile(title: 'CONTACT', section: 'contact', icon: Icons.mail_rounded, onSectionTap: onSectionTap),
          const Spacer(),
          // Bottom gradient bar
          Padding(
            padding: const EdgeInsets.all(28),
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [AppTheme.lavender, AppTheme.blushPink, AppTheme.mintCyan],
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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: _isHovered
              ? AppTheme.lavender.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: _isHovered
                ? AppTheme.lavender.withValues(alpha: 0.25)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: ListTile(
          leading: Icon(
            widget.icon,
            color: _isHovered ? AppTheme.lavender : AppTheme.textMuted,
            size: 22,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: _isHovered ? AppTheme.lavender : AppTheme.textSecondary,
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
