import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
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
  late AnimationController _floatController;

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
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4500),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _float = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
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
    _imageScale = Tween<double>(begin: 0.85, end: 1.0).animate(
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
    _floatController.dispose();
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
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isDesktop ? MediaQuery.of(context).size.height - 80 : 0,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: isDesktop ? 0 : 100,
      ),
      child: Column(
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
                    // Role badge
                    _animatedChild(
                      fade: _subtitleFade,
                      slide: _subtitleSlide,
                      child: Align(
                        alignment: isDesktop ? Alignment.centerLeft : Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppTheme.lavender.withValues(alpha: 0.12),
                            border: Border.all(
                              color: AppTheme.lavender.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [AppTheme.lavender, AppTheme.blushPink],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'SOFTWARE DEVELOPER & GENAI INTERN',
                                style: TextStyle(
                                  color: AppTheme.lavender,
                                  fontWeight: FontWeight.w700,
                                  fontSize: isDesktop ? 11 : 9,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // First name
                    _animatedChild(
                      fade: _nameFade,
                      slide: _nameSlide,
                      child: Text(
                        'AALOK',
                        style: TextStyle(
                          fontSize: isDesktop ? 105 : 60,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textPrimary,
                          height: 1,
                          letterSpacing: 3,
                        ),
                      ),
                    ),

                    // Last name — candy gradient shimmer
                    _animatedChild(
                      fade: _lastNameFade,
                      slide: _lastNameSlide,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            AppTheme.lavender,
                            AppTheme.blushPink,
                            AppTheme.mintCyan,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'KUMAR',
                          style: TextStyle(
                            fontSize: isDesktop ? 105 : 60,
                            fontWeight: FontWeight.w900,
                            height: 1,
                            letterSpacing: 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Tech stack + Bio
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
                            children: [
                              _techPill('Flutter', AppTheme.lavender),
                              _techPill('Kotlin', AppTheme.blushPink),
                              _techPill('FastAPI', AppTheme.mintCyan),
                              _techPill('PostgreSQL', AppTheme.softPink),
                              _techPill('GenAI', AppTheme.lavender),
                            ],
                          ),
                          const SizedBox(height: 28),
                          // Bio
                          SizedBox(
                            width: isDesktop ? 540 : double.infinity,
                            child: Text(
                              'Aspiring Software Developer skilled in Flutter, Kotlin, FastAPI, PostgreSQL, Firebase, and Generative AI, building scalable mobile, backend, and AI-powered applications with a focus on performance and user experience.',
                              textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                height: 1.75,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 44),

                    // Buttons + location
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
                              _CandyButton(
                                text: 'VIEW WORK',
                                onTap: () => widget.onSectionTap?.call('projects'),
                              ),
                              _OutlineButton(
                                text: 'GET IN TOUCH',
                                onTap: () => widget.onSectionTap?.call('contact'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          // Location
                          Row(
                            mainAxisAlignment: isDesktop
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: AppTheme.blushPink, size: 16),
                              const SizedBox(width: 8),
                              const Text(
                                'Bengaluru, India',
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
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

              // Right — floating avatar
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
                    child: AnimatedBuilder(
                      animation: _float,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _float.value),
                          child: child,
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Soft glow ring
                          Container(
                            width: 370,
                            height: 370,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  AppTheme.lavender.withValues(alpha: 0.2),
                                  AppTheme.blushPink.withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          // Outer decorative ring
                          Container(
                            width: 340,
                            height: 340,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppTheme.lavender.withValues(alpha: 0.25),
                                width: 1.5,
                              ),
                            ),
                          ),
                          // Main image card
                          Container(
                            height: 420,
                            width: 340,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFEEDCFF),
                                  Color(0xFFFFDDF0),
                                ],
                              ),
                              border: Border.all(
                                color: AppTheme.lavender.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.lavender.withValues(alpha: 0.2),
                                  blurRadius: 50,
                                  offset: const Offset(0, 20),
                                ),
                                BoxShadow(
                                  color: AppTheme.blushPink.withValues(alpha: 0.15),
                                  blurRadius: 30,
                                  offset: const Offset(15, 30),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=400&auto=format&fit=crop',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFEEDCFF),
                                        Color(0xFFFFDDF0),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.person_rounded,
                                    size: 100,
                                    color: AppTheme.lavender,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Available badge
                          Positioned(
                            bottom: 16,
                            right: 8,
                            child: AnimatedBuilder(
                              animation: _pulse,
                              builder: (context, child) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppTheme.lavender,
                                        AppTheme.blushPink,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.lavender.withValues(
                                            alpha: 0.45 * _pulse.value),
                                        blurRadius: 20,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
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
                          // Decorative floating chip (top-left)
                          Positioned(
                            top: 20,
                            left: 0,
                            child: _FloatingChip(
                              icon: Icons.code_rounded,
                              label: 'Full Stack',
                              color: AppTheme.mintCyan,
                            ),
                          ),
                        ],
                      ),
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
              child: const Padding(
                padding: EdgeInsets.only(top: 60),
                child: _ScrollIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _techPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withValues(alpha: 0.12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Decorative floating chip widget
class _FloatingChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _FloatingChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        border: Border.all(
          color: color.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Primary cotton candy gradient button
class _CandyButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const _CandyButton({required this.text, this.onTap});

  @override
  State<_CandyButton> createState() => _CandyButtonState();
}

class _CandyButtonState extends State<_CandyButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              colors: _isHovered
                  ? [AppTheme.blushPink, AppTheme.lavender]
                  : [AppTheme.lavender, AppTheme.blushPink],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lavender
                    .withValues(alpha: _isHovered ? 0.45 : 0.25),
                blurRadius: _isHovered ? 28 : 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Outline button with candy lavender border
class _OutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  const _OutlineButton({required this.text, this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: _isHovered
                ? AppTheme.lavender.withValues(alpha: 0.08)
                : Colors.white,
            border: Border.all(
              color: _isHovered ? AppTheme.lavender : AppTheme.lavender.withValues(alpha: 0.4),
              width: 2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppTheme.lavender.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: AppTheme.lavender,
              fontWeight: FontWeight.w800,
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
  const _ScrollIndicator();

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
      duration: const Duration(milliseconds: 1400),
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
              const Text(
                'SCROLL',
                style: TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.lavender.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppTheme.lavender,
                  size: 20,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
