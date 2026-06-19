import 'package:flutter/material.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'skills_page.dart';
import 'experience_page.dart';
import 'projects_page.dart';
import 'beyond_code_page.dart';
import 'contact_page.dart';

class MainScrollPage extends StatefulWidget {
  const MainScrollPage({super.key});

  @override
  State<MainScrollPage> createState() => _MainScrollPageState();
}

class _MainScrollPageState extends State<MainScrollPage> {
  final ScrollController _scrollController = ScrollController();
  
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _beyondCodeKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(key: _homeKey, child: const HomePage()),
            Container(key: _aboutKey, child: const AboutPage()),
            Container(key: _skillsKey, child: const SkillsPage()),
            Container(key: _experienceKey, child: const ExperiencePage()),
            Container(key: _projectsKey, child: const ProjectsPage()),
            Container(key: _beyondCodeKey, child: const BeyondCodePage()),
            Container(key: _contactKey, child: const ContactPage()),
          ],
        ),
      ),
    );
  }
}
