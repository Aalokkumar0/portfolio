import 'package:flutter/material.dart';
import '../layouts/responsive_layout.dart';

class HeroSection extends StatefulWidget {
  final Function(String)? onSectionTap;

  const HeroSection({super.key, this.onSectionTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;

  // Staggered animations
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;
  late Animation<double> _nameFade;
  late Animation<Offset> _nameSlide;
  late Animation<double> _lastNameFade;
  late Animation<Offset> _lastNameSlide;
  late Animation<double> _bioFade;
  late Animation<Offset> _bioSlide;
  late Animation<double> _buttonsFade;
  late Animation<Offset> _buttonsSlide;
  late Animation<double> _imageFade;
  late Animation<double> _imageScale;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Staggered entrance animations
    _subtitleFade = _createFade(0.0, 0.3);
    _subtitleSlide = _createSlide(0.0, 0.3);

    _nameFade = _createFade(0.1, 0.4);
    _nameSlide = _createSlide(0.1, 0.4);

    _lastNameFade = _createFade(0.15, 0.45);
    _lastNameSlide = _createSlide(0.15, 0.45);

    _bioFade = _createFade(0.25, 0.55);
    _bioSlide = _createSlide(0.25, 0.55);

    _buttonsFade = _createFade(0.35, 0.65);
    _buttonsSlide = _createSlide(0.35, 0.65);

    _imageFade = _createFade(0.3, 0.7);
    _imageScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _entranceController.forward();
  }

  Animation<double> _createFade(double begin, double end) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  Animation<Offset> _createSlide(double begin, double end) {
    return Tween<Offset>(begin: const Offset(0, 40), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Interval(begin, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Widget _animatedChild({
    required Animation<double> fade,
    required Animation<Offset> slide,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, _) {
        return Transform.translate(
          offset: slide.value,
          child: Opacity(opacity: fade.value, child: child),
        );
      },
    );
  }

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
        horizontal: isDesktop ? 100 : 24,
        vertical: isDesktop ? 0 : 80,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Large background watermark
          if (isDesktop)
            Positioned(
              right: -20,
              child: Opacity(
                opacity: 0.02,
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.5),
                      theme.colorScheme.secondary.withValues(alpha: 0.3),
                    ],
                  ).createShader(bounds),
                  child: const Text(
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
            ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left content
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: isDesktop
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        // Subtitle
                        _animatedChild(
                          fade: _subtitleFade,
                          slide: _subtitleSlide,
                          child: Row(
                            mainAxisAlignment: isDesktop
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 35,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.primary,
                                      theme.colorScheme.secondary,
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Flexible(
                                child: Text(
                                  'SOFTWARE DEVELOPER & GENAI INTERN',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isDesktop ? 12 : 10,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),

                        // First name — solid white
                        _animatedChild(
                          fade: _nameFade,
                          slide: _nameSlide,
                          child: Text(
                            'AALOK',
                            style: TextStyle(
                              fontSize: isDesktop ? 110 : 64,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1,
                              letterSpacing: 3,
                            ),
                          ),
                        ),

                        // Last name — gradient shimmer
                        _animatedChild(
                          fade: _lastNameFade,
                          slide: _lastNameSlide,
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                                theme.colorScheme.tertiary,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              'KUMAR',
                              style: TextStyle(
                                fontSize: isDesktop ? 110 : 64,
                                fontWeight: FontWeight.w900,
                                height: 1,
                                letterSpacing: 3,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Tech stack
                        _animatedChild(
                          fade: _bioFade,
                          slide: _bioSlide,
                          child: Column(
                            crossAxisAlignment: isDesktop
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              // Tech pills
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
                                children: ['Flutter', 'Kotlin', 'FastAPI', 'PostgreSQL', 'GenAI']
                                    .map((tech) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 6),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white.withValues(alpha: 0.04),
                                            border: Border.all(
                                              color: Colors.white.withValues(alpha: 0.08),
                                            ),
                                          ),
                                          child: Text(
                                            tech,
                                            style: TextStyle(
                                              color: Colors.white.withValues(alpha: 0.6),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                              const SizedBox(height: 30),
                              // Bio
                              SizedBox(
                                width: isDesktop ? 550 : double.infinity,
                                child: Text(
                                  'Aspiring Software Developer skilled in Flutter, Kotlin, FastAPI, PostgreSQL, Firebase, and Generative AI, building scalable mobile, backend, and AI-powered applications with a focus on performance and user experience.',
                                  textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    height: 1.7,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 45),

                        // Buttons
                        _animatedChild(
                          fade: _buttonsFade,
                          slide: _buttonsSlide,
                          child: Column(
                            crossAxisAlignment: isDesktop
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              Wrap(
                                alignment: isDesktop
                                    ? WrapAlignment.start
                                    : WrapAlignment.center,
                                spacing: 16,
                                runSpacing: 12,
                                children: [
                                  // Primary gradient button
                                  _GradientButton(
                                    text: 'VIEW WORK',
                                    onTap: () =>
                                        widget.onSectionTap?.call('projects'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () =>
                                        widget.onSectionTap?.call('contact'),
                                    child: const Text('GET IN TOUCH'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 35),
                              // Location
                              Row(
                                mainAxisAlignment: isDesktop
                                    ? MainAxisAlignment.start
                                    : MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on_rounded,
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.5),
                                      size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Bengaluru, India',
                                    style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.4),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right — Stylized avatar area
                  if (isDesktop)
                    Expanded(
                      flex: 2,
                      child: AnimatedBuilder(
                        animation: _entranceController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _imageScale.value,
                            child: Opacity(
                                opacity: _imageFade.value, child: child),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow behind avatar
                            Container(
                              width: 350,
                              height: 350,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    theme.colorScheme.primary
                                        .withValues(alpha: 0.1),
                                    theme.colorScheme.secondary
                                        .withValues(alpha: 0.05),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            // Main image
                            Container(
                              height: 450,
                              width: 360,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.06),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.1),
                                    blurRadius: 60,
                                    offset: const Offset(0, 30),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          theme.colorScheme.surface,
                                          theme.colorScheme.surface
                                              .withValues(alpha: 0.5),
                                        ],
                                      ),
                                    ),
                                    child: Icon(Icons.person,
                                        size: 120,
                                        color: Colors.white
                                            .withValues(alpha: 0.05)),
                                  ),
                                ),
                              ),
                            ),
                            // Available badge with pulse
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: AnimatedBuilder(
                                animation: _pulse,
                                builder: (context, child) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: LinearGradient(
                                        colors: [
                                          theme.colorScheme.primary,
                                          theme.colorScheme.secondary,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: theme.colorScheme.primary
                                              .withValues(
                                                  alpha: 0.4 * _pulse.value),
                                          blurRadius: 20,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white.withValues(
                                                alpha: _pulse.value),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'AVAILABLE FOR WORK',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              // Scroll indicator
              if (isDesktop)
                _animatedChild(
                  fade: _buttonsFade,
                  slide: _buttonsSlide,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: _ScrollIndicator(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Primary gradient button with hover effect
class _GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const _GradientButton({required this.text, this.onTap});

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: _isHovered
                  ? [
                      theme.colorScheme.secondary,
                      theme.colorScheme.primary,
                    ]
                  : [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary
                    .withValues(alpha: _isHovered ? 0.4 : 0.2),
                blurRadius: _isHovered ? 30 : 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Animated scroll-down indicator
class _ScrollIndicator extends StatefulWidget {
  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _bounce = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounce.value),
          child: Column(
            children: [
              Text(
                'SCROLL',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.2),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white.withValues(alpha: 0.2),
                size: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}
