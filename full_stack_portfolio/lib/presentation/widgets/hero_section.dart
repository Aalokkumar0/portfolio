import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class HeroSection extends StatelessWidget {
  final Function(String)? onSectionTap;

  const HeroSection({super.key, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isDesktop ? MediaQuery.of(context).size.height - 80 : 0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: isDesktop ? 0 : 60,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Large Background Watermark
          if (isDesktop)
            Positioned(
              right: -20,
              child: Opacity(
                opacity: 0.03,
                child: Text(
                  'DEVELOPER',
                  style: TextStyle(
                    fontSize: 220,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 10,
                  ),
                ),
              ),
            ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Content Area
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        // Professional Subtitle
                        Row(
                          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30,
                              height: 2,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'MOBILE APP DEVELOPER & GENAI INTERN',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Name: AALOK (Solid)
                        Text(
                          'AALOK',
                          style: TextStyle(
                            fontSize: isDesktop ? 110 : 70,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1,
                            letterSpacing: 2,
                          ),
                        ),
                        // Name: KUMAR (Outlined)
                        Text(
                          'KUMAR',
                          style: TextStyle(
                            fontSize: isDesktop ? 110 : 70,
                            fontWeight: FontWeight.w900,
                            height: 1,
                            letterSpacing: 2,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = theme.colorScheme.primary.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Tech Stack Dots
                        Text(
                          'Firebase  •  Kotlin  •  Flutter  •  FastAPI  •  Cross-Platform Builder',
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.4),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 35),
                        // Short Bio
                        SizedBox(
                          width: isDesktop ? 550 : double.infinity,
                          child: Text(
                            'Building scalable mobile and backend applications with Flutter, Kotlin, FastAPI, and Firebase. Crafting performance-optimized UI experiences with real-time systems and modular architecture.',
                            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              height: 1.7,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 45),
                        // Action Buttons
                        Row(
                          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => onSectionTap?.call('projects'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
                                shape: const RoundedRectangleBorder(),
                                elevation: 0,
                              ),
                              child: const Text('VIEW WORK', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            ),
                            const SizedBox(width: 20),
                            OutlinedButton(
                              onPressed: () => onSectionTap?.call('contact'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white24, width: 1.5),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text('GET IN TOUCH', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        // Location info
                        Row(
                          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_outlined, color: theme.colorScheme.primary.withValues(alpha: 0.5), size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Bangalore, India',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.4),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Right Content Area (Image)
                  if (isDesktop)
                    Expanded(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          // Main Image Container
                          Container(
                            height: 520,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  blurRadius: 30,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: theme.colorScheme.surface,
                                  child: Icon(Icons.person, size: 120, color: Colors.white.withValues(alpha: 0.05)),
                                ),
                              ),
                            ),
                          ),
                          // "Available for work" Badge
                          Container(
                            margin: const EdgeInsets.all(25),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'AVAILABLE FOR WORK',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 11,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
