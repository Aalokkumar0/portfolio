import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/layouts/desktop_scaffold.dart';
import '../../presentation/layouts/mobile_scaffold.dart';
import '../../presentation/layouts/responsive_layout.dart';
import '../../presentation/pages/main_scroll_page.dart';
import '../../presentation/pages/blogs_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        void handleSectionTap(String section) {
          if (section == 'blogs') {
            context.go('/blogs');
          } else {
            context.go('/', extra: section);
          }
        }

        return ResponsiveLayout(
          mobileLayout: MobileScaffold(
            onSectionTap: handleSectionTap,
            child: child,
          ),
          desktopLayout: DesktopScaffold(
            onSectionTap: handleSectionTap,
            child: child,
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            final String? section = state.extra as String?;
            return MainScrollPage(
              key: section != null ? ValueKey(section) : null,
              initialSection: section,
            );
          },
        ),
      ],
    ),
    // Move /blogs outside the ShellRoute to remove the scaffold navigation bar
    GoRoute(
      path: '/blogs',
      builder: (context, state) => const BlogsPage(),
    ),
  ],
);
