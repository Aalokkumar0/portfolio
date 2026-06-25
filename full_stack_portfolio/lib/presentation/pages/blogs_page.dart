import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final blogs = [
      {
        'title': 'Kairo — An Intelligent Break Reminder That Knows When You Actually Need One',
        'excerpt': 'Kairo is a macOS menu bar app that intelligently forces you to take breaks. It watches your work patterns, respects your meetings, credits natural idle time...',
        'date': 'May 22, 2026',
        'author': 'Aalok Kumar',
        'tags': ['MACOS-APP', 'HEALTH', 'PRODUCTIVITY', 'SWIFTUI'],
        'image': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'Daily Flow — A Minimalist, Day-First Task Management System',
        'excerpt': 'Daily Flow is a minimalist, day-first task management system that helps you focus on what matters today. Unfinished tasks carry forward automatically...',
        'date': 'April 21, 2026',
        'author': 'Aalok Kumar',
        'tags': ['WEB-APP', 'TASK-MANAGEMENT', 'PRODUCTIVITY', 'MINIMALIST'],
        'image': 'https://images.unsplash.com/photo-1484417894907-623942c8ee29?q=80&w=800&auto=format&fit=crop',
      },
      {
        'title': 'TailorFlow — A Privacy-First, Offline-Capable Digital Ledger for Tailors',
        'excerpt': 'TailorFlow is a privacy-first, offline-capable digital ledger for tailors and clothing businesses. Replaces physical order registers with a searchable...',
        'date': 'April 11, 2026',
        'author': 'Aalok Kumar',
        'tags': ['WEB-APP', 'TAILOR', 'OFFLINE-FIRST', 'PWA'],
        'image': 'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=800&auto=format&fit=crop',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 120,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 30, height: 2, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 15),
              Text(
                'LATEST UPDATES',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'BLOGS',
            style: TextStyle(
              fontSize: 90,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
              height: 1,
            ),
          ),
          const SizedBox(height: 100),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 1,
              crossAxisSpacing: 35,
              mainAxisSpacing: 50,
              mainAxisExtent: 600,
            ),
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              return _buildBlogCard(context, blogs[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, Map<String, dynamic> blog) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Blog Image
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(blog['image']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 25),
        // Meta data
        Row(
          children: [
            const CircleAvatar(radius: 10, backgroundColor: Colors.white10, child: Icon(Icons.person, size: 12, color: Colors.white54)),
            const SizedBox(width: 10),
            Text(
              blog['author'],
              style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            const Text('•', style: TextStyle(color: Colors.white24)),
            const SizedBox(width: 10),
            Text(
              blog['date'],
              style: const TextStyle(color: Colors.white38, fontSize: 13),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Title
        Text(
          blog['title'],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 15),
        // Excerpt
        Text(
          blog['excerpt'],
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            height: 1.6,
            fontSize: 15,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 20),
        // Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (blog['tags'] as List<String>).map((tag) {
            return Text(
              tag,
              style: TextStyle(
                color: theme.colorScheme.secondary.withValues(alpha: 0.8),
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
