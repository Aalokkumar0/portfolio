import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    final projects = [
      {
        'title': 'PARISARA CYCLE',
        'sub': 'Eco-Friendly Cycling Companion',
        'description': 'A smart cycling application using Kotlin, Google Maps API, and Fused Location Provider. Implemented real-time GPS tracking, ride analytics, and eco-impact monitoring.',
        'tags': ['KOTLIN', 'GOOGLE MAPS', 'MVVM'],
      },
      {
        'title': 'DEVITY SERVICE',
        'sub': 'User Profile Backend',
        'description': 'Scalable user profile management APIs using FastAPI and PostgreSQL. Implemented authentication workflows, CRUD operations, and database management using SQLAlchemy.',
        'tags': ['FASTAPI', 'POSTGRESQL', 'DOCKER'],
      },
      {
        'title': 'ENGINOTES',
        'sub': 'Note-Sharing Platform',
        'description': 'A note-sharing platform with Google Sign-In and email authentication. Implemented PDF upload/download and real-time data synchronization using Firebase.',
        'tags': ['FLUTTER', 'FIREBASE', 'CLOUD STORAGE'],
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 100 : 20,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 30, height: 2, color: theme.colorScheme.primary),
                const SizedBox(width: 15),
                Text(
                  'MY WORK',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'PROJECTS',
              style: TextStyle(
                fontFamily: 'ChelseaMarket',
                fontSize: 80,
                color: Colors.white,
                letterSpacing: 0.5,
                height: 1,
              ),
            ),
            const SizedBox(height: 60),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 2 : 1,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                mainAxisExtent: isDesktop ? 550 : 600,
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return _buildModernProjectCard(context, project);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernProjectCard(BuildContext context, Map<String, dynamic> project) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image Placeholder
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            ),
            child: Center(
              child: Icon(
                Icons.code,
                size: 60,
                color: theme.colorScheme.primary.withOpacity(0.2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title'],
                  style: const TextStyle(
                    fontFamily: 'ChelseaMarket',
                    fontSize: 32,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  project['sub'],
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  project['description'],
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    height: 1.6,
                    fontSize: 14,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: (project['tags'] as List<String>).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
