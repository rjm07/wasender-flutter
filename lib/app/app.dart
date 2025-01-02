import 'package:flutter/material.dart';
import 'package:wasender/app/ui/shared/widgets/wrappers/auth_wrapper.dart';
import 'package:wasender/app/utils/lang/theme.dart';

class WaSenderApp extends StatelessWidget {
  const WaSenderApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, //or ThemeMode.dark
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      home: const AuthWrapper(),
    );
  }
}
