import 'package:flutter/material.dart';

class MobileScaffold extends StatelessWidget {
  final Widget child;
  final Function(String)? onSectionTap;

  const MobileScaffold({super.key, required this.child, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => onSectionTap?.call('home'),
          child: Text(
            'AK.',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF020617),
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'AK.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            _drawerTile(context, 'HOME', 'home', Icons.home_outlined),
            _drawerTile(context, 'ABOUT', 'about', Icons.person_outline),
            _drawerTile(context, 'SKILLS', 'skills', Icons.code),
            _drawerTile(context, 'EXPERIENCE', 'experience', Icons.work_outline),
            _drawerTile(context, 'PROJECTS', 'projects', Icons.rocket_launch_outlined),
            _drawerTile(context, 'BEYOND CODE', 'beyond-code', Icons.interests_outlined),
            _drawerTile(context, 'CONTACT', 'contact', Icons.contact_mail_outlined),
          ],
        ),
      ),
      body: child,
    );
  }

  Widget _drawerTile(BuildContext context, String title, String section, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      onTap: () {
        onSectionTap?.call(section);
        Navigator.pop(context);
      },
    );
  }
}
