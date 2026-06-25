import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../layouts/responsive_layout.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final blogs = [
      {
        'title': 'Kairo — An Intelligent Break Reminder That Knows When You Actually Need One',
        'excerpt': 'Kairo is a macOS menu bar app that intelligently forces you to take breaks. It watches your work patterns, respects your meetings, credits natural idle time, and steps in when you have been at the screen too long — no manual timers, no guesswork.',
        'date': 'May 22, 2026',
        'author': 'Abhishek Thakur',
        'tags': ['MACOS-APP', 'HEALTH', 'PRODUCTIVITY', 'SWIFTUI', 'BREAK-REMINDER', 'DEVITY-ENGINEERING'],
        'image': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'Daily Flow — A Minimalist, Day-First Task Management System',
        'excerpt': 'Daily Flow is a minimalist, day-first task management system that helps you focus on what matters today. Unfinished tasks carry forward automatically, only one task can be "In Progress" at a time, and your complete history stays visible.',
        'date': 'April 21, 2026',
        'author': 'Abhishek Thakur',
        'tags': ['WEB-APP', 'TASK-MANAGEMENT', 'PRODUCTIVITY', 'DAY-FIRST', 'MINIMALIST', 'DEVITY-ENGINEERING'],
        'image': 'https://images.unsplash.com/photo-1484417894907-623942c8ee29?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'TailorFlow — A Privacy-First, Offline-Capable Digital Ledger for Tailors',
        'excerpt': 'TailorFlow is a privacy-first, offline-capable digital ledger for tailors and clothing businesses. Replaces physical order registers with a searchable, measurement-focused system where you own 100% of your data.',
        'date': 'April 21, 2026',
        'author': 'Abhishek Thakur',
        'tags': ['WEB-APP', 'TAILOR', 'OFFLINE-FIRST', 'PWA', 'SQLITE-WASM', 'PRIVACY', 'DEVITY-ENGINEERING'],
        'image': 'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'Building Modular Mobile Apps with Flutter',
        'excerpt': 'Modular architecture is key to scaling large applications. In this post, I dive deep into how we can use feature-first organization and clear boundaries to maintain velocity in large teams.',
        'date': 'January 23, 2026',
        'author': 'Abhishek Thakur',
        'tags': ['FLUTTER', 'MOBILE', 'ARCHITECTURE', 'ENGINEERING'],
        'image': 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?q=80&w=800&auto=format&fit=crop',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 150 : 20,
            vertical: 40,
          ),
          child: Column(
            children: [
              // Blog header
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Row(
                  children: [
                    // Logo
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.go('/'),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF6366F1).withValues(alpha: 0.15),
                                    const Color(0xFF818CF8).withValues(alpha: 0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.bolt_rounded, color: Color(0xFF6366F1), size: 22),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Devity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (isDesktop) ...[
                      _headerLink('Blog'),
                      _headerLink('Tags'),
                      _headerLink('Tools'),
                      _headerLink('Extensions'),
                      const SizedBox(width: 20),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withValues(alpha: 0.04),
                        ),
                        child: const Icon(Icons.search_rounded, color: Colors.white54, size: 20),
                      ),
                    ] else
                      IconButton(
                        onPressed: () => context.go('/'),
                        icon: const Icon(Icons.close_rounded, color: Colors.white54),
                      ),
                  ],
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 3 : 1,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 50,
                  mainAxisExtent: isDesktop ? 580 : 600,
                ),
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  return _BlogCard(blog: blogs[index]);
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerLink(String title) {
    return _HoverLink(title: title);
  }
}

class _HoverLink extends StatefulWidget {
  final String title;
  const _HoverLink({required this.title});

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: _isHovered ? Colors.white : Colors.white54,
            fontSize: 14,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
          ),
          child: Text(widget.title),
        ),
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  final Map<String, dynamic> blog;
  const _BlogCard({required this.blog});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard>
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: () {},
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final hv = _animation.value;
            return Transform.translate(
              offset: Offset(0, -4 * hv),
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image with gradient overlay
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.blog['image'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF6366F1).withValues(alpha: 0.2),
                                const Color(0xFF38BDF8).withValues(alpha: 0.1),
                              ],
                            ),
                          ),
                          child: const Icon(Icons.image, color: Colors.white24, size: 48),
                        ),
                      ),
                      // Gradient overlay at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 80,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xFF020617)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Meta row
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.2),
                    child: Text(
                      (widget.blog['author'] as String)[0],
                      style: const TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.blog['author'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('•', style: TextStyle(color: Colors.white.withValues(alpha: 0.3))),
                  const SizedBox(width: 8),
                  Text(
                    widget.blog['date'],
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.3),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Title
              Text(
                widget.blog['title'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.3,
                  letterSpacing: -0.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              // Excerpt
              Text(
                widget.blog['excerpt'],
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  height: 1.6,
                  fontSize: 13,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Tags
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: (widget.blog['tags'] as List<String>).take(4).map((tag) {
                  return Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFF6366F1),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
