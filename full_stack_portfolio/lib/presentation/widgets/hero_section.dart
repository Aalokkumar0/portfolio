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
      height: isDesktop ? MediaQuery.of(context).size.height - 80 : null,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 20,
        vertical: isDesktop ? 0 : 60,
      ),
      child: Stack(
        children: [
          if (isDesktop)
            Positioned(
              right: -50,
              top: 100,
              child: Text(
                'DEVELOPER',
                style: TextStyle(
                  fontFamily: 'ChelseaMarket',
                  fontSize: 250,
                  color: Colors.white.withOpacity(0.03),
                  height: 0.8,
                ),
              ),
            ),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            Container(width: 20, height: 2, color: theme.colorScheme.primary),
                            const SizedBox(width: 10),
                            Text(
                              'MOBILE APP DEVELOPER & GENAI INTERN',
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'AALOK',
                          style: TextStyle(
                            fontFamily: 'ChelseaMarket',
                            fontSize: 110,
                            color: Colors.white,
                            height: 0.9,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          'KUMAR',
                          style: TextStyle(
                            fontFamily: 'ChelseaMarket',
                            fontSize: 110,
                            height: 0.9,
                            letterSpacing: 0.5,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Firebase  •  Kotlin  •  Flutter  •  FastAPI  •  Cross-Platform Builder',
                          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: isDesktop ? 500 : double.infinity,
                          child: Text(
                            'Building scalable mobile and backend applications with Flutter, Kotlin, FastAPI, and Firebase. Crafting performance-optimized UI experiences with real-time systems and modular architecture.',
                            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              height: 1.6,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => onSectionTap?.call('projects'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text('VIEW WORK', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                            ),
                            const SizedBox(width: 15),
                            OutlinedButton(
                              onPressed: () => onSectionTap?.call('contact'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white24),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 22),
                                shape: const RoundedRectangleBorder(),
                              ),
                              child: const Text('GET IN TOUCH', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: isDesktop ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on_outlined, color: Colors.white38, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              'Bangalore, India',
                              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  if (isDesktop)
                    Expanded(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 450,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: theme.colorScheme.surface,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=350&auto=format&fit=crop',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Center(
                                  child: Icon(Icons.person, size: 100, color: Colors.white10),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'AVAILABLE FOR WORK',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
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
