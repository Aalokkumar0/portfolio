import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const DevPortfolioApp());
}

// ── CONSTANTS ────────────────────────────────────────────────────────────────

class AppColors {
  static const bg = Color(0xFF0A0E1A);
  static const surface = Color(0xFF111827);
  static const card = Color(0xFF1A2235);
  static const border = Color(0xFF1E2D45);
  static const flutterBlue = Color(0xFF02569B);
  static const dartBlue = Color(0xFF0175C2);
  static const cyan = Color(0xFF00B4D8);
  static const teal = Color(0xFF00D4AA);
  static const accent = Color(0xFF54C5F8);
  static const white = Colors.white;
  static const textMuted = Color(0xFF64748B);
  static const textSub = Color(0xFF94A3B8);
  static const codeGreen = Color(0xFF4ADE80);
  static const codePurple = Color(0xFFC084FC);
  static const codeYellow = Color(0xFFFBBF24);
  static const codeOrange = Color(0xFFFB923C);
}

// ── RESPONSIVE ────────────────────────────────────────────────────────────────

class R {
  static bool mob(BuildContext c) => MediaQuery.of(c).size.width < 600;
  static bool tab(BuildContext c) {
    final w = MediaQuery.of(c).size.width;
    return w >= 600 && w < 900;
  }

  static bool desk(BuildContext c) => MediaQuery.of(c).size.width >= 900;
  static double px(BuildContext c) => mob(c)
      ? 20
      : tab(c)
      ? 40
      : 80;
  static double heroFs(BuildContext c) => mob(c)
      ? 36
      : tab(c)
      ? 52
      : 72;
  static double secFs(BuildContext c) => mob(c)
      ? 28
      : tab(c)
      ? 36
      : 48;
}

// ── APP ───────────────────────────────────────────────────────────────────────

class DevPortfolioApp extends StatelessWidget {
  const DevPortfolioApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dev Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: AppColors.bg),
      home: const PortfolioPage(),
    );
  }
}

// ── PAGE ──────────────────────────────────────────────────────────────────────

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  late final AnimationController _bgCtrl;
  late final AnimationController _entryCtrl;

  @override
  void initState() {
    super.initState();
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
  }

  @override
  void dispose() {
    _bgCtrl.dispose();
    _entryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMob = R.mob(context);
    return Scaffold(
      backgroundColor: AppColors.bg,
      endDrawer: isMob ? _drawer(context) : null,
      body: Builder(
        builder: (ctx) {
          return Stack(
            children: [
              Positioned.fill(child: RepaintBoundary(child: _GridBg(ctrl: _bgCtrl))),
              Positioned.fill(child: RepaintBoundary(child: _GlowOrbs(ctrl: _bgCtrl))),
              RepaintBoundary(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _NavBar(ctrl: _entryCtrl, scaffoldCtx: ctx, isMob: isMob),
                      _HeroSection(entryCtrl: _entryCtrl),
                      const _TechBand(),
                      const _ProjectsSection(),
                      const _SkillsSection(),
                      const _ExperienceSection(),
                      const _TestimonialsSection(),
                      const _ContactSection(),
                      const _Footer(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const FlutterLogo(size: 40),
            const SizedBox(height: 8),
            const Text(
              'Aalok Kumar',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ...['Projects', 'Skills', 'Experience', 'Contact'].map(
              (l) => ListTile(
                title: Text(
                  l,
                  style: const TextStyle(
                    color: AppColors.textSub,
                    fontFamily: 'monospace',
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── ANIMATED 3D RIBBON BG ─────────────────────────────────────────────────────

class _GridBg extends StatelessWidget {
  final AnimationController ctrl;
  const _GridBg({required this.ctrl});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: ctrl,
    builder: (_, _) => CustomPaint(painter: _Ribbon3DPainter(ctrl.value)),
  );
}

class _Ribbon3DPainter extends CustomPainter {
  final double t;
  _Ribbon3DPainter(this.t);

  // Ribbon definition: (inner color, outer color, base radius fraction, phase offset)
  static const _ribbons = [
    (AppColors.dartBlue,    AppColors.flutterBlue, 0.28, 0.00),
    (AppColors.flutterBlue, AppColors.cyan,        0.40, 0.18),
    (AppColors.cyan,        AppColors.teal,        0.53, 0.34),
    (AppColors.teal,        AppColors.accent,      0.66, 0.50),
    (AppColors.accent,      AppColors.cyan,        0.80, 0.66),
  ];

  static const _startAngle = -math.pi * 0.94;
  static const _sweepAngle =  math.pi * 0.80;

  void _drawRibbon(Canvas canvas, Size s, int i) {
    final (c1, c2, rFrac, phase) = _ribbons[i];

    final breathe = math.sin((t + phase) * math.pi * 2) * 9.0;
    final radius   = s.height * rFrac + breathe;
    final origin   = Offset(s.width * 0.98, s.height * 0.98);
    final rect     = Rect.fromCircle(center: origin, radius: radius);

    // ── 1. Outer glow (optimized, removed extreme blur for performance) ──────
    canvas.drawArc(
      rect, _startAngle, _sweepAngle, false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 70
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [
            c1.withValues(alpha: 0.08 - i * 0.010),
            c2.withValues(alpha: 0.05 - i * 0.005),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect),
    );

    // ── 2. Main ribbon body ──────────────────────────────────────────────────
    final thickness = 50.0 - i * 2.5;
    canvas.drawArc(
      rect, _startAngle, _sweepAngle, false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickness
        ..strokeCap = StrokeCap.round
        ..shader = LinearGradient(
          colors: [
            c1.withValues(alpha: 0.52 - i * 0.07),
            c2.withValues(alpha: 0.38 - i * 0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.centerRight,
        ).createShader(rect),
    );

    // ── 3. Glass highlight edge (inner rim, brighter thin arc) ───────────────
    final hiRect = Rect.fromCircle(center: origin, radius: radius - thickness / 2 + 2);
    canvas.drawArc(
      hiRect, _startAngle + 0.04, _sweepAngle - 0.08, false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round
        ..color = c2.withValues(alpha: 0.55 - i * 0.08),
    );

    // ── 4. Outer rim highlight ───────────────────────────────────────────────
    final outRect = Rect.fromCircle(center: origin, radius: radius + thickness / 2 - 2);
    canvas.drawArc(
      outRect, _startAngle + 0.04, _sweepAngle - 0.08, false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..strokeCap = StrokeCap.round
        ..color = c1.withValues(alpha: 0.30 - i * 0.04),
    );
  }

  @override
  void paint(Canvas canvas, Size s) {
    // Draw back-to-front so front ribbons appear on top
    for (int i = _ribbons.length - 1; i >= 0; i--) {
      _drawRibbon(canvas, s, i);
    }
  }

  @override
  bool shouldRepaint(_Ribbon3DPainter o) => o.t != t;
}

// ── GLOW ORBS ─────────────────────────────────────────────────────────────────

class _GlowOrbs extends StatelessWidget {
  final AnimationController ctrl;
  const _GlowOrbs({required this.ctrl});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: ctrl,
    builder: (_, _) => CustomPaint(painter: _OrbsPainter(ctrl.value)),
  );
}

class _OrbsPainter extends CustomPainter {
  final double t;
  _OrbsPainter(this.t);

  void _orb(
    Canvas c,
    Size s,
    double x,
    double y,
    double r,
    Color col,
    double ph,
  ) {
    final dy = math.sin((t + ph) * math.pi * 2) * 25;
    final center = Offset(s.width * x, s.height * y + dy);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [col.withValues(alpha: 0.18), col.withValues(alpha: 0)],
      ).createShader(Rect.fromCircle(center: center, radius: r));
    c.drawCircle(center, r, paint);
  }

  @override
  void paint(Canvas c, Size s) {
    _orb(c, s, 0.1, 0.2, 220, AppColors.dartBlue, 0.0);
    _orb(c, s, 0.85, 0.1, 180, AppColors.cyan, 0.4);
    _orb(c, s, 0.7, 0.75, 260, AppColors.teal, 0.7);
    _orb(c, s, 0.15, 0.9, 160, AppColors.flutterBlue, 0.2);
  }

  @override
  bool shouldRepaint(_OrbsPainter o) => o.t != t;
}

// ── NAVBAR ────────────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  final AnimationController ctrl;
  final BuildContext scaffoldCtx;
  final bool isMob;
  const _NavBar({
    required this.ctrl,
    required this.scaffoldCtx,
    required this.isMob,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: ctrl,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: R.px(context), vertical: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.6)),
          ),
        ),
        child: Row(
          children: [
            const FlutterLogo(size: 20),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'flutter',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(
                    text: '.dev',
                    style: TextStyle(
                      color: AppColors.teal,
                      fontSize: 15,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (isMob)
              IconButton(
                onPressed: () => Scaffold.of(scaffoldCtx).openEndDrawer(),
                icon: const Icon(Icons.menu, color: Colors.white70),
              )
            else
              Row(
                children: [
                  ...[
                    'Projects',
                    'Skills',
                    'Experience',
                    'Contact',
                  ].map((l) => _NavLink(label: l)),
                  const SizedBox(width: 20),
                  _GlowBtn(label: 'Hire Me', onTap: () {}, small: true),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  const _NavLink({required this.label});
  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  bool _h = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _h = true);
        _c.forward();
      },
      onExit: (_) {
        setState(() => _h = false);
        _c.reverse();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                color: _h ? AppColors.accent : AppColors.textSub,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 3),
            AnimatedBuilder(
              animation: _c,
              builder: (_, _) => Container(
                height: 1,
                width: 28 * _c.value,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.cyan, AppColors.teal],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── HERO SECTION ──────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  final AnimationController entryCtrl;
  const _HeroSection({required this.entryCtrl});

  @override
  Widget build(BuildContext context) {
    final isMob = R.mob(context);
    final px = R.px(context);

    return Container(
      padding: EdgeInsets.fromLTRB(px, isMob ? 50 : 70, px, isMob ? 60 : 100),
      child: isMob
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroText(context),
                const SizedBox(height: 48),
                _codeCard(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: _heroText(context)),
                if (!R.mob(context)) ...[
                  const SizedBox(width: 48),
                  Expanded(flex: 2, child: _codeCard(context)),
                ],
              ],
            ),
    );
  }

  Widget _heroText(BuildContext context) {
    final fs = R.heroFs(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Reveal(
          d: 0,
          child: _PulseBadge(label: 'Open to Work', color: AppColors.teal),
        ),
        const SizedBox(height: 28),
        _Reveal(
          d: 150,
          child: Text(
            'Hi, I\'m',
            style: TextStyle(
              fontSize: fs * 0.3,
              color: AppColors.textSub,
              fontFamily: 'monospace',
              letterSpacing: 2,
            ),
          ),
        ),
        _Reveal(
          d: 250,
          child: ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [Colors.white, AppColors.accent],
            ).createShader(b),
            child: Text(
              'Aalok Kumar',
              style: TextStyle(
                fontSize: fs,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.0,
              ),
            ),
          ),
        ),
        _Reveal(
          d: 380,
          child: _Typewriter(
            texts: const [
              'Flutter Developer',
              'Dart Enthusiast',
              'UI/UX Craftsman',
              'Cross-platform Expert',
            ],
            fontSize: fs * 0.36,
          ),
        ),
        const SizedBox(height: 20),
        _Reveal(
          d: 520,
          child: SizedBox(
            width: 460,
            child: Text(
              '3+ years crafting pixel-perfect Flutter apps for iOS, Android & Web. I turn complex UI into smooth, performant experiences.',
              style: TextStyle(
                fontSize: R.mob(context) ? 13 : 15,
                color: AppColors.textSub,
                height: 1.8,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        _Reveal(
          d: 680,
          child: Wrap(
            spacing: 14,
            runSpacing: 12,
            children: [
              _GlowBtn(label: 'View Projects', onTap: () {}),
              _OutlineBtn(
                label: 'Download CV',
                onTap: () {},
                icon: Icons.download,
              ),
            ],
          ),
        ),
        const SizedBox(height: 44),
        _Reveal(
          d: 850,
          child: Row(
            children: [
              _Stat(value: '50+', label: 'APPS BUILT'),
              _vd(),
              _Stat(value: '3+', label: 'YEARS EXP'),
              _vd(),
              _Stat(value: '100%', label: 'SATISFACTION'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _vd() => Container(
    width: 1,
    height: 36,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    color: AppColors.border,
  );

  Widget _codeCard(BuildContext context) {
    return _Reveal(
      d: 400,
      fromRight: true,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withValues(alpha: 0.08),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Window dots
            Row(
              children: [
                _dot(const Color(0xFFFF5F57)),
                const SizedBox(width: 6),
                _dot(const Color(0xFFFFC433)),
                const SizedBox(width: 6),
                _dot(const Color(0xFF2AC845)),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'aalok_portfolio.dart',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _cl('// About me in Dart 🎯', AppColors.textMuted),
            const SizedBox(height: 2),
            _cl2(
              'class ',
              AppColors.codePurple,
              'Developer extends Widget {',
              Colors.white,
            ),
            _ind(
              _cl2(
                '  final String name = ',
                AppColors.codeYellow,
                '"Aalok Kumar";',
                AppColors.codeGreen,
              ),
            ),
            _ind(
              _cl2(
                '  final String role = ',
                AppColors.codeYellow,
                '"Flutter Dev";',
                AppColors.codeGreen,
              ),
            ),
            _ind(
              _cl2(
                '  final int experience = ',
                AppColors.codeYellow,
                '3; // years',
                AppColors.codeOrange,
              ),
            ),
            const SizedBox(height: 2),
            _ind(_cl('  List<String> skills = [', AppColors.codeYellow)),
            _ind(_cl('    "Flutter", "Dart",', AppColors.codeGreen)),
            _ind(_cl('    "Firebase", "Bloc",', AppColors.codeGreen)),
            _ind(_cl('    "Riverpod", "REST",', AppColors.codeGreen)),
            _ind(_cl('  ];', AppColors.codeYellow)),
            const SizedBox(height: 2),
            _ind(
              _cl2(
                '  Widget build(ctx) => ',
                AppColors.codePurple,
                'AmazingApp();',
                AppColors.accent,
              ),
            ),
            _cl('}', Colors.white),
            const SizedBox(height: 10),
            _BlinkCursor(),
          ],
        ),
      ),
    );
  }

  Widget _dot(Color c) => Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );

  Widget _cl(String text, Color color) => Text(
    text,
    style: TextStyle(color: color, fontSize: 12.5, fontFamily: 'monospace'),
  );

  Widget _cl2(String a, Color ca, String b, Color cb) => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: a,
          style: TextStyle(color: ca, fontSize: 12.5, fontFamily: 'monospace'),
        ),
        TextSpan(
          text: b,
          style: TextStyle(color: cb, fontSize: 12.5, fontFamily: 'monospace'),
        ),
      ],
    ),
  );

  Widget _ind(Widget w) =>
      Padding(padding: const EdgeInsets.only(left: 8), child: w);
}

// ── TECH BAND ─────────────────────────────────────────────────────────────────

class _TechBand extends StatelessWidget {
  const _TechBand();
  @override
  Widget build(BuildContext context) {
    final techs = [
      ('Flutter', AppColors.dartBlue, Icons.flutter_dash),
      ('Dart', AppColors.cyan, Icons.code),
      ('Firebase', const Color(0xFFF57C00), Icons.local_fire_department),
      ('Bloc', const Color(0xFF7C3AED), Icons.layers),
      ('Riverpod', const Color(0xFF059669), Icons.account_tree),
      ('REST API', const Color(0xFFDC2626), Icons.api),
      ('Git', const Color(0xFFF05032), Icons.merge_type),
      ('Figma', const Color(0xFFA259FF), Icons.design_services),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: R.px(context), vertical: 32),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.border)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '{ tech_stack }',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    letterSpacing: 2,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: techs
                .map((t) => _Chip(label: t.$1, color: t.$2, icon: t.$3))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatefulWidget {
  final String label;
  final Color color;
  final IconData icon;
  const _Chip({required this.label, required this.color, required this.icon});
  @override
  State<_Chip> createState() => _ChipState();
}

class _ChipState extends State<_Chip> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: _h ? widget.color.withValues(alpha: 0.15) : AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _h ? widget.color.withValues(alpha: 0.6) : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, color: widget.color, size: 15),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: TextStyle(
                color: _h ? Colors.white : AppColors.textSub,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── PROJECTS SECTION ──────────────────────────────────────────────────────────

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final px = R.px(context);
    final isMob = R.mob(context);
    final isTab = R.tab(context);

    final projects = [
      _ProjData(
        'ShopFlow',
        'E-Commerce App',
        'Full-featured shopping with real-time inventory, Stripe payments & buttery animations. 60fps on low-end devices.',
        ['Flutter', 'Firebase', 'Stripe', 'Bloc'],
        AppColors.dartBlue,
        Icons.shopping_bag_outlined,
        '2.4k',
      ),
      _ProjData(
        'MindTrack',
        'Mental Health App',
        'Mood tracking with AI insights, fl_chart visualizations, local notifications and offline-first architecture.',
        ['Flutter', 'SQLite', 'Riverpod', 'ML Kit'],
        const Color(0xFF7C3AED),
        Icons.psychology_outlined,
        '1.8k',
      ),
      _ProjData(
        'SwiftChat',
        'Real-time Messaging',
        'E2E encrypted chat with WebSocket, push notifications, media sharing and custom emoji reactions.',
        ['Flutter', 'WebSocket', 'Firebase', 'GoRouter'],
        AppColors.teal,
        Icons.chat_bubble_outline,
        '3.1k',
      ),
      _ProjData(
        'FitPulse',
        'Fitness Tracker',
        'Workout logging with animated progress rings, Apple Health & Google Fit integration, custom builder.',
        ['Flutter', 'HealthKit', 'Hive', 'Lottie'],
        const Color(0xFFDC2626),
        Icons.fitness_center_outlined,
        '950',
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SecHeader(tag: '// projects', title: 'Featured', hi: 'Work'),
          const SizedBox(height: 56),
          isMob
              ? Column(
                  children: projects
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: _Reveal(
                            d: e.key * 100,
                            child: _ProjCard(data: e.value),
                          ),
                        ),
                      )
                      .toList(),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTab ? 1 : 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: isTab ? 2.4 : 1.55,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (_, i) => _Reveal(
                    d: i * 100,
                    child: _ProjCard(data: projects[i]),
                  ),
                ),
        ],
      ),
    );
  }
}

class _ProjData {
  final String title, subtitle, desc, stars;
  final List<String> tags;
  final Color color;
  final IconData icon;
  const _ProjData(
    this.title,
    this.subtitle,
    this.desc,
    this.tags,
    this.color,
    this.icon,
    this.stars,
  );
}

class _ProjCard extends StatefulWidget {
  final _ProjData data;
  const _ProjCard({required this.data});
  @override
  State<_ProjCard> createState() => _ProjCardState();
}

class _ProjCardState extends State<_ProjCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 280),
  );
  bool _h = false;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _h = true);
        _c.forward();
      },
      onExit: (_) {
        setState(() => _h = false);
        _c.reverse();
      },
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, _) => Transform.translate(
          offset: Offset(0, -4 * _c.value),
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _h ? d.color.withValues(alpha: 0.5) : AppColors.border,
              ),
              boxShadow: _h
                  ? [
                      BoxShadow(
                        color: d.color.withValues(alpha: 0.14),
                        blurRadius: 28,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: d.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(d.icon, color: d.color, size: 20),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.codeYellow,
                      size: 13,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      d.stars,
                      style: const TextStyle(
                        color: AppColors.textSub,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.open_in_new,
                      color: AppColors.textMuted,
                      size: 15,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  d.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  d.subtitle,
                  style: TextStyle(
                    color: d.color,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  d.desc,
                  style: const TextStyle(
                    color: AppColors.textSub,
                    fontSize: 12.5,
                    height: 1.7,
                  ),
                ),
                const Spacer(),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: d.tags
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: d.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: d.color.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            t,
                            style: TextStyle(
                              color: d.color,
                              fontSize: 10,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── SKILLS SECTION ────────────────────────────────────────────────────────────

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();
  @override
  Widget build(BuildContext context) {
    final px = R.px(context);
    final isMob = R.mob(context);
    final skills = [
      ('Flutter / Dart', 0.95, AppColors.dartBlue),
      ('State Management', 0.90, AppColors.cyan),
      ('Firebase & Backend', 0.85, const Color(0xFFF57C00)),
      ('REST & GraphQL', 0.88, const Color(0xFF059669)),
      ('UI/UX Design', 0.80, const Color(0xFFA259FF)),
      ('Testing & CI/CD', 0.75, const Color(0xFFDC2626)),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SecHeader(tag: '// skills', title: 'My', hi: 'Expertise'),
          const SizedBox(height: 56),
          isMob
              ? Column(
                  children: skills
                      .map(
                        (s) => Padding(
                          padding: const EdgeInsets.only(bottom: 26),
                          child: _SkillBar(label: s.$1, pct: s.$2, color: s.$3),
                        ),
                      )
                      .toList(),
                )
              : GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 26,
                  crossAxisSpacing: 60,
                  childAspectRatio: 7,
                  children: skills
                      .map(
                        (s) => _SkillBar(label: s.$1, pct: s.$2, color: s.$3),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatefulWidget {
  final String label;
  final double pct;
  final Color color;
  const _SkillBar({
    required this.label,
    required this.pct,
    required this.color,
  });
  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );
  late final Animation<double> _a = CurvedAnimation(
    parent: _c,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            AnimatedBuilder(
              animation: _a,
              builder: (_, _) => Text(
                '${(_a.value * widget.pct * 100).round()}%',
                style: TextStyle(
                  color: widget.color,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _a,
          builder: (_, _) => Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _a.value * widget.pct,
                child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: [widget.color, widget.color.withValues(alpha: 0.55)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── EXPERIENCE SECTION ────────────────────────────────────────────────────────

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();
  @override
  Widget build(BuildContext context) {
    final px = R.px(context);
    final exps = [
      _ExpData('Senior Flutter Developer', 'TechNova Ltd.', '2023 – Present', [
        'Led team of 4 building fintech app with 300k+ users',
        'Reduced app size 40% via dynamic feature modules',
        'CI/CD pipeline saving 8hrs/week',
      ], AppColors.cyan),
      _ExpData('Flutter Developer', 'AppCraft Studio', '2022 – 2023', [
        'Built 12 cross-platform apps for startup clients',
        'Created reusable widget library across projects',
        'Mentored 2 junior developers',
      ], AppColors.teal),
      _ExpData(
        'Junior Mobile Developer',
        'ByteForge Inc.',
        '2021 – 2022',
        [
          'Contributed to 5 Flutter apps in Agile sprints',
          'Integrated 20+ third-party SDKs & REST APIs',
          'Wrote 200+ unit and widget tests',
        ],
        AppColors.codePurple,
      ),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SecHeader(tag: '// experience', title: 'Work', hi: 'History'),
          const SizedBox(height: 56),
          ...exps.asMap().entries.map(
            (e) => _Reveal(
              d: e.key * 150,
              child: _ExpItem(data: e.value, isLast: e.key == exps.length - 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpData {
  final String role, company, period;
  final List<String> items;
  final Color color;
  const _ExpData(this.role, this.company, this.period, this.items, this.color);
}

class _ExpItem extends StatelessWidget {
  final _ExpData data;
  final bool isLast;
  const _ExpItem({required this.data, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final isMob = R.mob(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 11,
                  height: 11,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: data.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: data.color.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.only(top: 4),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMob
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.role,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              data.company,
                              style: TextStyle(
                                color: data.color,
                                fontSize: 12,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              data.period,
                              style: const TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.role,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  data.company,
                                  style: TextStyle(
                                    color: data.color,
                                    fontSize: 12,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: data.color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: data.color.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                data.period,
                                style: TextStyle(
                                  color: data.color,
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 14),
                  ...data.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: data.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                color: AppColors.textSub,
                                fontSize: 13,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── TESTIMONIALS ──────────────────────────────────────────────────────────────

class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();
  @override
  Widget build(BuildContext context) {
    final px = R.px(context);
    final isMob = R.mob(context);
    final items = [
      (
        '"Aalok delivered a stunning Flutter app that exceeded expectations. The animations are buttery smooth and users love it."',
        'Sarah Mitchell',
        'CEO, TechNova',
        AppColors.cyan,
      ),
      (
        '"Outstanding Flutter skills. Our app went from idea to App Store in 6 weeks. Highly recommended for any mobile project!"',
        'James Park',
        'Founder, AppCraft',
        AppColors.teal,
      ),
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: px, vertical: 80),
      child: Column(
        children: [
          _SecHeader(tag: '// testimonials', title: 'Client', hi: 'Feedback'),
          const SizedBox(height: 56),
          isMob
              ? Column(
                  children: items
                      .map(
                        (t) => Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: _TCard(data: t),
                        ),
                      )
                      .toList(),
                )
              : Row(
                  children: items
                      .asMap()
                      .entries
                      .map(
                        (e) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: e.key == 0 ? 18 : 0,
                            ),
                            child: _TCard(data: e.value),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ],
      ),
    );
  }
}

class _TCard extends StatelessWidget {
  final (String, String, String, Color) data;
  const _TCard({required this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: data.$4.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '❝',
            style: TextStyle(
              fontSize: 36,
              color: data.$4.withValues(alpha: 0.4),
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.$1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.8,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: data.$4.withValues(alpha: 0.18),
                ),
                child: Center(
                  child: Text(
                    data.$2[0],
                    style: TextStyle(
                      color: data.$4,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.$2,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    data.$3,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                      fontFamily: 'monospace',
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

// ── CONTACT SECTION ───────────────────────────────────────────────────────────

class _ContactSection extends StatelessWidget {
  const _ContactSection();
  @override
  Widget build(BuildContext context) {
    final px = R.px(context);
    final isMob = R.mob(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: px, vertical: 40),
      padding: EdgeInsets.all(isMob ? 28 : 60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.dartBlue.withValues(alpha: 0.14),
            AppColors.teal.withValues(alpha: 0.07),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dartBlue.withValues(alpha: 0.3)),
      ),
      child: isMob
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ctText(context),
                const SizedBox(height: 36),
                _ctLinks(),
              ],
            )
          : Row(
              children: [
                Expanded(child: _ctText(context)),
                const SizedBox(width: 60),
                Expanded(child: _ctLinks()),
              ],
            ),
    );
  }

  Widget _ctText(BuildContext context) {
    final isMob = R.mob(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '// let\'s_work_together',
          style: TextStyle(
            color: AppColors.teal,
            fontSize: 11,
            fontFamily: 'monospace',
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Got a Flutter\nProject in Mind?',
          style: TextStyle(
            color: Colors.white,
            fontSize: isMob ? 26 : 36,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Available for freelance & full-time. Let\'s build something amazing.',
          style: TextStyle(
            color: AppColors.textSub,
            fontSize: 13.5,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),
        _GlowBtn(label: 'Send Message', onTap: () {}),
      ],
    );
  }

  Widget _ctLinks() {
    return Column(
      children: [
        _CLink(
          icon: Icons.email_outlined,
          label: 'aalok@flutter.dev',
          color: AppColors.cyan,
        ),
        const SizedBox(height: 12),
        _CLink(
          icon: Icons.code,
          label: 'github.com/aalokkumar',
          color: AppColors.teal,
        ),
        const SizedBox(height: 12),
        _CLink(
          icon: Icons.work_outline,
          label: 'linkedin.com/in/aalokkumar',
          color: AppColors.codePurple,
        ),
        const SizedBox(height: 12),
        _CLink(
          icon: Icons.flutter_dash,
          label: '@aalok.dart',
          color: AppColors.accent,
        ),
      ],
    );
  }
}

class _CLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _CLink({required this.icon, required this.label, required this.color});
  @override
  State<_CLink> createState() => _CLinkState();
}

class _CLinkState extends State<_CLink> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: _h ? widget.color.withValues(alpha: 0.1) : AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _h ? widget.color.withValues(alpha: 0.4) : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: widget.color, size: 17),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                color: _h ? Colors.white : AppColors.textSub,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              color: _h ? widget.color : AppColors.textMuted,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}

// ── FOOTER ────────────────────────────────────────────────────────────────────

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: R.px(context), vertical: 28),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          const FlutterLogo(size: 15),
          const SizedBox(width: 8),
          const Text(
            'Built with Flutter & ❤️  by Aalok Kumar',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const Spacer(),
          const Text(
            '© 2026',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ── REUSABLE SMALL WIDGETS ────────────────────────────────────────────────────

class _SecHeader extends StatelessWidget {
  final String tag, title, hi;
  const _SecHeader({required this.tag, required this.title, required this.hi});
  @override
  Widget build(BuildContext context) {
    final fs = R.secFs(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag,
          style: const TextStyle(
            color: AppColors.teal,
            fontSize: 11,
            fontFamily: 'monospace',
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fs,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              TextSpan(
                text: hi,
                style: TextStyle(
                  fontSize: fs,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [AppColors.cyan, AppColors.teal],
                    ).createShader(const Rect.fromLTWH(0, 0, 300, 60)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GlowBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool small;
  const _GlowBtn({
    required this.label,
    required this.onTap,
    this.small = false,
  });
  @override
  State<_GlowBtn> createState() => _GlowBtnState();
}

class _GlowBtnState extends State<_GlowBtn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withValues(alpha: 0.12 + _c.value * 0.18),
              blurRadius: 18 + _c.value * 10,
            ),
          ],
        ),
        child: child,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.dartBlue, AppColors.cyan],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.small ? 18 : 26,
                vertical: widget.small ? 9 : 13,
              ),
              child: Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: widget.small ? 12 : 13.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  const _OutlineBtn({required this.label, required this.onTap, this.icon});
  @override
  State<_OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<_OutlineBtn> {
  bool _h = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _h = true),
      onExit: (_) => setState(() => _h = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _h ? AppColors.cyan.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _h ? AppColors.cyan : AppColors.border),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 15,
                      color: _h ? AppColors.cyan : AppColors.textSub,
                    ),
                    const SizedBox(width: 7),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: _h ? AppColors.cyan : AppColors.textSub,
                      fontFamily: 'monospace',
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [AppColors.cyan, AppColors.teal],
          ).createShader(b),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMuted,
            fontSize: 10,
            letterSpacing: 1,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

class _PulseBadge extends StatefulWidget {
  final String label;
  final Color color;
  const _PulseBadge({required this.label, required this.color});
  @override
  State<_PulseBadge> createState() => _PulseBadgeState();
}

class _PulseBadgeState extends State<_PulseBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.35 + _c.value * 0.4),
                    blurRadius: 5,
                    spreadRadius: _c.value * 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.color,
                fontSize: 11,
                fontFamily: 'monospace',
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── SCROLL REVEAL ─────────────────────────────────────────────────────────────

class _Reveal extends StatefulWidget {
  final Widget child;
  final int d;
  final bool fromRight;
  const _Reveal({required this.child, this.d = 0, this.fromRight = false});
  @override
  State<_Reveal> createState() => _RevealState();
}

class _RevealState extends State<_Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late final Animation<double> _f = CurvedAnimation(
    parent: _c,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _s = Tween<Offset>(
    begin: widget.fromRight ? const Offset(0.04, 0) : const Offset(0, 0.035),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.d), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _f,
    child: SlideTransition(position: _s, child: widget.child),
  );
}

// ── TYPEWRITER ────────────────────────────────────────────────────────────────

class _Typewriter extends StatefulWidget {
  final List<String> texts;
  final double fontSize;
  const _Typewriter({required this.texts, required this.fontSize});
  @override
  State<_Typewriter> createState() => _TypewriterState();
}

class _TypewriterState extends State<_Typewriter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 75),
  )..addListener(_tick);
  int _idx = 0, _len = 0;
  bool _del = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) _c.repeat();
    });
  }

  void _tick() {
    if (!mounted) return;
    setState(() {
      if (!_del) {
        if (_len < widget.texts[_idx].length) {
          _len++;
        } else {
          _c.stop();
          Future.delayed(const Duration(milliseconds: 1600), () {
            if (mounted) {
              setState(() => _del = true);
              _c.repeat();
            }
          });
        }
      } else {
        if (_len > 0) {
          _len--;
        } else {
          _del = false;
          _idx = (_idx + 1) % widget.texts.length;
        }
      }
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.texts[_idx].substring(0, _len);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [AppColors.cyan, AppColors.teal],
          ).createShader(b),
          child: Text(
            text,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
        _BlinkCursorInline(fontSize: widget.fontSize),
      ],
    );
  }
}

class _BlinkCursorInline extends StatefulWidget {
  final double fontSize;
  const _BlinkCursorInline({required this.fontSize});
  @override
  State<_BlinkCursorInline> createState() => _BlinkCursorInlineState();
}

class _BlinkCursorInlineState extends State<_BlinkCursorInline>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, _) => Opacity(
        opacity: _c.value,
        child: Text(
          '|',
          style: TextStyle(
            color: AppColors.cyan,
            fontSize: widget.fontSize,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}

class _BlinkCursor extends StatefulWidget {
  @override
  State<_BlinkCursor> createState() => _BlinkCursorState();
}

class _BlinkCursorState extends State<_BlinkCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, _) => Opacity(
        opacity: _c.value,
        child: Container(width: 7, height: 14, color: AppColors.teal),
      ),
    );
  }
}
