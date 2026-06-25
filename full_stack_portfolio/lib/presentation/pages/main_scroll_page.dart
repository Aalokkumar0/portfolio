import 'package:flutter/material.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'skills_page.dart';
import 'experience_page.dart';
import 'projects_page.dart';
import 'beyond_code_page.dart';
import 'contact_page.dart';

class MainScrollPage extends StatefulWidget {
  final String? initialSection;
  const MainScrollPage({super.key, this.initialSection});

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

  @override
  void initState() {
    super.initState();
    if (widget.initialSection != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToSection(widget.initialSection!);
      });
    }
  }

  void scrollToSection(String section) {
    GlobalKey? targetKey;
    switch (section) {
      case 'home': targetKey = _homeKey; break;
      case 'about': targetKey = _aboutKey; break;
      case 'skills': targetKey = _skillsKey; break;
      case 'experience': targetKey = _experienceKey; break;
      case 'projects': targetKey = _projectsKey; break;
      case 'beyond-code': targetKey = _beyondCodeKey; break;
      case 'contact': targetKey = _contactKey; break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          HomePage(key: _homeKey, onSectionTap: scrollToSection),
          AboutPage(key: _aboutKey),
          SkillsPage(key: _skillsKey),
          ExperiencePage(key: _experienceKey),
          ProjectsPage(key: _projectsKey),
          BeyondCodePage(key: _beyondCodeKey),
          ContactPage(key: _contactKey),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
