import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/hero_section.dart';

class HomePage extends StatelessWidget {
  final Function(String)? onSectionTap;

  const HomePage({super.key, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeroSection(onSectionTap: onSectionTap),
        _buildServicesSection(context),
        _buildFeaturedProjects(context),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      color: theme.colorScheme.surface.withValues(alpha: 0.3),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 30, height: 2, color: theme.colorScheme.primary),
              const SizedBox(width: 15),
              Text(
                'WHAT I DO',
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
            'SERVICES',
            style: TextStyle(
              
              fontSize: 80,
              color: Colors.white,
              letterSpacing: 0.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 60),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isDesktop ? 3 : 1,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
            childAspectRatio: 1.2,
            children: [
              _buildServiceCard(context, 'MOBILE APPS', 'Building high-performance native-quality apps for iOS and Android using Flutter & Kotlin.', Icons.smartphone),
              _buildServiceCard(context, 'BACKEND SYSTEMS', 'Developing scalable REST APIs and microservices with FastAPI, Node.js, and PostgreSQL.', Icons.dns),
              _buildServiceCard(context, 'AI SOLUTIONS', 'Integrating Generative AI models and LLMs to create smart, automated digital experiences.', Icons.auto_awesome),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String desc, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  
                  fontSize: 28,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjects(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 30, height: 2, color: theme.colorScheme.primary),
              const SizedBox(width: 15),
              Text(
                'LATEST WORK',
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
            'FEATURED PROJECTS',
            style: TextStyle(
              
              fontSize: 80,
              color: Colors.white,
              letterSpacing: 0.5,
              height: 1,
            ),
          ),
          const SizedBox(height: 60),
          _buildFeaturedProjectRow(context, 'PARISARA CYCLE', 'KOTLIN • GOOGLE MAPS API', 'A smart cycling application for eco-impact monitoring and GPS tracking.'),
          const Divider(color: Colors.white10),
          _buildFeaturedProjectRow(context, 'ENGINOTES', 'FLUTTER • FIREBASE', 'Note-sharing platform with real-time data synchronization and PDF support.'),
          const SizedBox(height: 60),
          Center(
            child: OutlinedButton(
              onPressed: () => onSectionTap?.call('projects'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white24),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                shape: const RoundedRectangleBorder(),
              ),
              child: const Text('VIEW ALL PROJECTS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjectRow(BuildContext context, String title, String tags, String desc) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: isDesktop
          ? Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          
                          fontSize: 48,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        tags,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    desc,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_outward, color: Colors.white, size: 30),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    
                    fontSize: 40,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  tags,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  desc,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ],
            ),
    );
  }
}
