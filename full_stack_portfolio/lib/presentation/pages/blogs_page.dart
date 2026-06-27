import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../layouts/responsive_layout.dart';
import '../widgets/animated_section.dart';

// ──────────────────────────────────────────────────────────
// Data
// ──────────────────────────────────────────────────────────
class _BlogPost {
  final String title;
  final String excerpt;
  final String date;
  final String author;
  final String readTime;
  final List<String> tags;
  final String imageUrl;
  final Color accentColor;
  final String url;

  const _BlogPost({
    required this.title,
    required this.excerpt,
    required this.date,
    required this.author,
    required this.readTime,
    required this.tags,
    required this.imageUrl,
    required this.url,
    this.accentColor = AppTheme.lavender,
  });
}

const _posts = [
  _BlogPost(
    title: 'Kairo — An Intelligent Break Reminder That Knows When You Actually Need One',
    excerpt: 'Kairo is a macOS menu bar app that intelligently forces you to take breaks. It watches your work patterns, respects your meetings, credits natural idle time, and steps in when you\'ve been at the screen too long.',
    date: 'May 22, 2026',
    author: 'Aalok Kumar',
    readTime: '5 min read',
    tags: ['MACOS', 'SWIFTUI', 'HEALTH', 'PRODUCTIVITY'],
    imageUrl: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=800&auto=format&fit=crop',
    url: 'https://ulupi.com',
    accentColor: AppTheme.lavender,
  ),
  _BlogPost(
    title: 'Daily Flow — A Minimalist, Day-First Task Management System',
    excerpt: 'Daily Flow helps you focus on what matters today. Unfinished tasks carry forward automatically, only one task can be "In Progress" at a time, and your complete history stays visible.',
    date: 'April 21, 2026',
    author: 'Aalok Kumar',
    readTime: '4 min read',
    tags: ['WEB-APP', 'PRODUCTIVITY', 'MINIMALIST'],
    imageUrl: 'https://images.unsplash.com/photo-1484417894907-623942c8ee29?q=80&w=800&auto=format&fit=crop',
    url: 'https://ulupi.com',
    accentColor: AppTheme.mintCyan,
  ),
  _BlogPost(
    title: 'TailorFlow — A Privacy-First, Offline-Capable Digital Ledger for Tailors',
    excerpt: 'TailorFlow is a privacy-first, offline-capable digital ledger for tailors and clothing businesses. Replaces physical order registers — you own 100% of your data.',
    date: 'April 21, 2026',
    author: 'Aalok Kumar',
    readTime: '6 min read',
    tags: ['PWA', 'OFFLINE-FIRST', 'SQLITE', 'PRIVACY'],
    imageUrl: 'https://images.unsplash.com/photo-1558655146-d09347e92766?q=80&w=800&auto=format&fit=crop',
    url: 'https://ulupi.com',
    accentColor: AppTheme.blushPink,
  ),
  _BlogPost(
    title: 'Building Modular Mobile Apps with Flutter',
    excerpt: 'Modular architecture is key to scaling large applications. Feature-first organization and clear boundaries help maintain velocity in large teams.',
    date: 'January 23, 2026',
    author: 'Aalok Kumar',
    readTime: '7 min read',
    tags: ['FLUTTER', 'ARCHITECTURE', 'MOBILE'],
    imageUrl: 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?q=80&w=800&auto=format&fit=crop',
    url: 'https://ulupi.com',
    accentColor: AppTheme.lavender,
  ),
];

// ──────────────────────────────────────────────────────────
// Page
// ──────────────────────────────────────────────────────────
class BlogsPage extends StatelessWidget {
  const BlogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──────────────────────────────────────
          SliverToBoxAdapter(
            child: _UlupiAppBar(isDesktop: isDesktop),
          ),

          // ── Hero / Featured post ─────────────────────────
          SliverToBoxAdapter(
            child: AnimatedSection(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  isDesktop ? 80 : 20,
                  0,
                  isDesktop ? 80 : 20,
                  isDesktop ? 60 : 36,
                ),
                child: _FeaturedCard(post: _posts.first, isDesktop: isDesktop),
              ),
            ),
          ),

          // ── Section label ─────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                isDesktop ? 80 : 20,
                0,
                isDesktop ? 80 : 20,
                24,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        colors: [AppTheme.lavender, AppTheme.blushPink],
                      ),
                    ),
                    child: const Text(
                      'ALL POSTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    '${_posts.length} articles',
                    style: const TextStyle(
                      color: AppTheme.textMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Post grid / list ──────────────────────────────
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 20),
            sliver: isDesktop
                ? _DesktopPostGrid(posts: _posts, screenW: screenW)
                : _MobilePostList(posts: _posts),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 80)),

          // ── Footer ───────────────────────────────────────
          SliverToBoxAdapter(child: _Footer(isDesktop: isDesktop)),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// App Bar
// ──────────────────────────────────────────────────────────
class _UlupiAppBar extends StatelessWidget {
  final bool isDesktop;
  const _UlupiAppBar({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        isDesktop ? 80 : 20,
        MediaQuery.of(context).padding.top + 16,
        isDesktop ? 80 : 20,
        16,
      ),
      child: Row(
        children: [
          // Logo — Ulupi.com
          GestureDetector(
            onTap: () => context.go('/'),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppTheme.lavender, AppTheme.blushPink],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.lavender.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'U',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ShaderMask(
                    shaderCallback: (b) => const LinearGradient(
                      colors: [AppTheme.lavender, AppTheme.blushPink],
                    ).createShader(b),
                    child: const Text(
                      'Ulupi.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Nav links (desktop) / Close button (mobile)
          if (isDesktop) ...[
            _NavLink('Blog'),
            _NavLink('Tags'),
            _NavLink('About'),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  colors: [AppTheme.lavender, AppTheme.blushPink],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.lavender.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'SUBSCRIBE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
          ] else
            GestureDetector(
              onTap: () => context.go('/'),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.lavender.withValues(alpha: 0.08),
                  border: Border.all(
                    color: AppTheme.lavender.withValues(alpha: 0.2),
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppTheme.lavender,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  const _NavLink(this.label);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: TextStyle(
            color: _hovered ? AppTheme.lavender : AppTheme.textSecondary,
            fontSize: 14,
            fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Featured hero card (first post, full-width)
// ──────────────────────────────────────────────────────────
class _FeaturedCard extends StatefulWidget {
  final _BlogPost post;
  final bool isDesktop;
  const _FeaturedCard({required this.post, required this.isDesktop});

  @override
  State<_FeaturedCard> createState() => _FeaturedCardState();
}

// ──────────────────────────────────────────────────────────
// URL helper
// ──────────────────────────────────────────────────────────
Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _FeaturedCardState extends State<_FeaturedCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  AnimationController? _pressCtrl;
  Animation<double>? _scaleAnim;

  void _ensureInit() {
    if (_pressCtrl != null) return;
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 280),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(
        parent: _pressCtrl!,
        curve: Curves.easeOut,
        reverseCurve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _pressCtrl?.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    HapticFeedback.lightImpact();
    await _pressCtrl?.forward();
    await _pressCtrl?.reverse();
    await _launchUrl(widget.post.url);
  }

  @override
  Widget build(BuildContext context) {
    _ensureInit();
    final p = widget.post;
    final isDesktop = widget.isDesktop;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: _scaleAnim ?? const AlwaysStoppedAnimation(1.0),
          builder: (_, child) => Transform.scale(
            scale: _scaleAnim?.value ?? 1.0,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: p.accentColor.withValues(alpha: _hovered ? 0.18 : 0.08),
                  blurRadius: _hovered ? 40 : 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image
                  AspectRatio(
                    aspectRatio: isDesktop ? 21 / 9 : 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          p.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, e, s) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  p.accentColor.withValues(alpha: 0.3),
                                  AppTheme.blushPink.withValues(alpha: 0.2),
                                ],
                              ),
                            ),
                            child: Icon(Icons.article_rounded, color: p.accentColor, size: 48),
                          ),
                        ),
                        // Bottom gradient
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withValues(alpha: 0.95),
                                ],
                                stops: const [0.5, 1.0],
                              ),
                            ),
                          ),
                        ),
                        // Featured badge
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: const LinearGradient(
                                colors: [AppTheme.lavender, AppTheme.blushPink],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.lavender.withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star_rounded, color: Colors.white, size: 12),
                                SizedBox(width: 5),
                                Text(
                                  'FEATURED',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(isDesktop ? 32 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          children: p.tags.take(3).map((t) => _TagChip(tag: t, color: p.accentColor)).toList(),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          p.title,
                          style: TextStyle(
                            fontSize: isDesktop ? 26 : 18,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.textPrimary,
                            height: 1.25,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          p.excerpt,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            height: 1.7,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _AuthorAvatar(name: p.author, color: p.accentColor),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.author,
                                    style: const TextStyle(
                                      color: AppTheme.textPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '${p.date} · ${p.readTime}',
                                    style: const TextStyle(
                                      color: AppTheme.textMuted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    p.accentColor.withValues(alpha: 0.15),
                                    p.accentColor.withValues(alpha: 0.05),
                                  ],
                                ),
                                border: Border.all(
                                  color: p.accentColor.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Icon(Icons.arrow_outward_rounded,
                                  color: p.accentColor, size: 18),
                            ),
                          ],
                        ),
                      ],
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

// ──────────────────────────────────────────────────────────
// Desktop: 2-column masonry-style grid
// ──────────────────────────────────────────────────────────
class _DesktopPostGrid extends StatelessWidget {
  final List<_BlogPost> posts;
  final double screenW;
  const _DesktopPostGrid({required this.posts, required this.screenW});

  @override
  Widget build(BuildContext context) {
    // Skip the first (featured) post
    final rest = posts.skip(1).toList();
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) => AnimatedSection(
          delay: Duration(milliseconds: 100 * i),
          child: _PostCard(post: rest[i]),
        ),
        childCount: rest.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.72,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Mobile: full-width auto-height list
// ──────────────────────────────────────────────────────────
class _MobilePostList extends StatelessWidget {
  final List<_BlogPost> posts;
  const _MobilePostList({required this.posts});

  @override
  Widget build(BuildContext context) {
    // Skip the first (featured) post — shown as hero above
    final rest = posts.skip(1).toList();
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) => Padding(
          padding: EdgeInsets.only(bottom: i < rest.length - 1 ? 20 : 0),
          child: AnimatedSection(
            delay: Duration(milliseconds: 80 * i),
            child: _PostCard(post: rest[i]),
          ),
        ),
        childCount: rest.length,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Regular post card — content-driven height (no overflow)
// ──────────────────────────────────────────────────────────
class _PostCard extends StatefulWidget {
  final _BlogPost post;
  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  AnimationController? _pressCtrl;
  Animation<double>? _scaleAnim;

  void _ensureInit() {
    if (_pressCtrl != null) return;
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 110),
      reverseDuration: const Duration(milliseconds: 260),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _pressCtrl!, curve: Curves.easeOut, reverseCurve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _pressCtrl?.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    _ensureInit();
    HapticFeedback.lightImpact();
    await _pressCtrl!.forward();
    await _pressCtrl!.reverse();
    await _launchUrl(widget.post.url);
  }

  @override
  Widget build(BuildContext context) {
    _ensureInit();
    final p = widget.post;
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: _scaleAnim!,
          builder: (_, child) => Transform.scale(
            scale: _scaleAnim!.value,
            child: child,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(
                color: _hovered
                    ? p.accentColor.withValues(alpha: 0.3)
                    : p.accentColor.withValues(alpha: 0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: p.accentColor.withValues(alpha: _hovered ? 0.14 : 0.06),
                  blurRadius: _hovered ? 28 : 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          p.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, e, s) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  p.accentColor.withValues(alpha: 0.2),
                                  AppTheme.blushPink.withValues(alpha: 0.1),
                                ],
                              ),
                            ),
                            child: Icon(Icons.article_rounded, color: p.accentColor, size: 36),
                          ),
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withValues(alpha: 0.6),
                                ],
                                stops: const [0.6, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: EdgeInsets.all(isDesktop ? 22 : 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: p.tags.take(3).map((t) => _TagChip(tag: t, color: p.accentColor, small: true)).toList(),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          p.title,
                          style: TextStyle(
                            fontSize: isDesktop ? 16 : 15,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimary,
                            height: 1.3,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.excerpt,
                          style: const TextStyle(
                            color: AppTheme.textSecondary,
                            height: 1.6,
                            fontSize: 12.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _AuthorAvatar(name: p.author, color: p.accentColor, radius: 11),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${p.date} · ${p.readTime}',
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 11.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.arrow_outward_rounded,
                                color: p.accentColor.withValues(alpha: 0.7), size: 16),
                          ],
                        ),
                      ],
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

// ──────────────────────────────────────────────────────────
// Shared small widgets
// ──────────────────────────────────────────────────────────
class _TagChip extends StatelessWidget {
  final String tag;
  final Color color;
  final bool small;
  const _TagChip({required this.tag, required this.color, this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8 : 10,
        vertical: small ? 3 : 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: color,
          fontSize: small ? 9.5 : 10.5,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AuthorAvatar extends StatelessWidget {
  final String name;
  final Color color;
  final double radius;
  const _AuthorAvatar({required this.name, required this.color, this.radius = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.15)],
        ),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: TextStyle(
            color: color,
            fontSize: radius * 0.85,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Footer
// ──────────────────────────────────────────────────────────
class _Footer extends StatelessWidget {
  final bool isDesktop;
  const _Footer({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 20),
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.lavender.withValues(alpha: 0.15)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: [AppTheme.lavender, AppTheme.blushPink],
            ).createShader(b),
            child: const Text(
              'Ulupi.com',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
          ),
          const Text(
            '© 2026 Aalok Kumar',
            style: TextStyle(
              color: AppTheme.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
