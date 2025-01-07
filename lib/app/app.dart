import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/dashboard_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/pesan_screen.dart';
import 'package:wasender/app/ui/shared/widgets/wrappers/auth_wrapper.dart';
import 'package:wasender/app/utils/lang/theme.dart';

class WhatUpApp extends StatelessWidget {
  const WhatUpApp({
    super.key,
  });

  // GoRouter configuration

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "",
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, //or ThemeMode.dark
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/lib/app/ui/shared/widgets/wrappers/auth_wrapper.dart',
  routes: [
    GoRoute(
      name: 'auth', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/lib/app/ui/shared/widgets/wrappers/auth_wrapper.dart',
      builder: (context, state) => AuthWrapper(),
    ),
    GoRoute(
      name: 'dashboard', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/lib/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/dashboard_screen.dart',
      builder: (context, state) => DashboardScreen(),
    ),
    GoRoute(
      name: 'chat',
      path: '/lib/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/pesan_screen',
      builder: (context, state) => PesanScreen(),
    ),
  ],
);
