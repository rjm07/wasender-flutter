import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/ui/pages/feature_login/change_password_screen.dart';

import '../../../../core/services/auth.dart';
import '../../../../core/services/preferences.dart';
import '../../../pages/feature_login/login_screen.dart';
import '../../../pages/feature_main/main_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String passBySystem = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getStoredPassBySystem();
      getStoredBrandId(scaffoldKey.currentContext!);
    });
  }

  void getStoredBrandId(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.updateBrandIdFuture();
  }

  Future<void> getStoredPassBySystem() async {
    final prefs = await LocalPrefs.getPassBySystem();
    setState(() {
      passBySystem = prefs!;
      debugPrint("Password By System: $passBySystem");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Consumer<Auth>(builder: (context, auth, _) {
        return FutureBuilder<String?>(
          future: auth.tokenFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final String? brandId = snapshot.data;

              if (brandId == null) {
                return const LoginScreen();
              } else {
                if (passBySystem == "TRUE") {
                  return ChangePasswordScreen(); // Go to login if no brandId or passBySystem is TRUE
                } else if (passBySystem == "FALSE") {
                  if (kDebugMode) {
                    print('DEBUG MODE: $passBySystem passbysystem is authenticated');
                  }
                  return const MainScreen();
                } else {
                  if (kDebugMode) {
                    print('DEBUG MODE: $passBySystem Default is authenticated');
                  }
                  return const LoginScreen();
                }
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }),
    );
  }
}
