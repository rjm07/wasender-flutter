import 'package:flutter/material.dart';
import 'package:wasender/app/core/services/navigation/navigation.dart';
import 'package:wasender/app/ui/pages/feature_login/change_password_screen.dart';
import 'package:wasender/app/ui/pages/feature_login/login_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/dashboard_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_screen.dart';
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
    return MaterialApp(
      navigatorKey: NavService.navigatorKey,
      title: "",
      //routerConfig: _router,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, //or ThemeMode.dark
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      home: const AuthWrapper(), // Define the initial screen here
      routes: {
        '/auth': (context) => AuthWrapper(),
        '/login': (context) => LoginScreen(),
        '/change_password': (context) => ChangePasswordScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/pesan': (context) => PesanScreen(),
        ChatScreen.routeName: (context) => ChatScreen(
              fullName: '',
              timestamp: '',
              roomChat: '',
              senderNumber: '',
              statusIsOpen: '',
              onHandleTicket: () {},
            ),
        // Add additional routes as needed
      },
    );
  }
}

// final _router = GoRouter(
//   initialLocation: '/lib/app/ui/shared/widgets/wrappers/auth_wrapper.dart',
//   routes: [
//     GoRoute(
//       name: 'auth', // Optional, add name to your routes. Allows you navigate by name instead of path
//       path: '/lib/app/ui/shared/widgets/wrappers/auth_wrapper.dart',
//       builder: (context, state) => AuthWrapper(),
//     ),
//     GoRoute(
//       name: 'dashboard', // Optional, add name to your routes. Allows you navigate by name instead of path
//       path: '/lib/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/dashboard_screen.dart',
//       builder: (context, state) => DashboardScreen(),
//     ),
//     GoRoute(name: 'pesan', path: '/pesan', builder: (context, state) => PesanScreen()
//         // {
//         //   return Scaffold(
//         //     appBar: AppBar(title: Text('')),
//         //     body: PesanScreen(),
//         //   );
//         // },
//         ),
//   ],
// );
