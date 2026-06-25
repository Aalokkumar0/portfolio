import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/main_scroll_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScrollPage(),
    ),
  ],
);
