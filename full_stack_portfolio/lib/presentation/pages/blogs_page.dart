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
              // Dedicated Clean Blog Header (Devity Style)
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Row(
                  children: [
                    // Logo back to Portfolio
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.bolt, color: Color(0xFF6366F1), size: 24),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Devity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (isDesktop) ...[
                      _headerLink('Blog'),
                      _headerLink('Tags'),
                      _headerLink('Tools'),
                      _headerLink('Extensions'),
                      const SizedBox(width: 20),
                      const Icon(Icons.search, color: Colors.white70, size: 20),
                    ] else
                      IconButton(
                        onPressed: () => context.go('/'),
                        icon: const Icon(Icons.close, color: Colors.white70),
                      ),
                  ],
                ),
              ),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 3 : 1,
                  crossAxisSpacing: 35,
                  mainAxisSpacing: 60,
                  mainAxisExtent: isDesktop ? 620 : 650,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _BlogCard extends StatelessWidget {
  final Map<String, dynamic> blog;
  const _BlogCard({required this.blog});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  blog['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Meta Row
            Row(
              children: [
                const CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=aalok'),
                ),
                const SizedBox(width: 10),
                Text(
                  blog['author'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Text('•', style: TextStyle(color: Colors.white38)),
                const SizedBox(width: 8),
                Text(
                  blog['date'],
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Title
            Text(
              blog['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.3,
                letterSpacing: -0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            // Excerpt
            Text(
              blog['excerpt'],
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                height: 1.6,
                fontSize: 14,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (blog['tags'] as List<String>).map((tag) {
                return Text(
                  tag,
                  style: const TextStyle(
                    color: Color(0xFF6366F1),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
