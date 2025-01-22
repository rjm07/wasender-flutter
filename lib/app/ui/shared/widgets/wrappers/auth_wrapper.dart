import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/ui/pages/feature_login/change_password_screen.dart';

import '../../../../core/services/auth.dart';
import '../../../../core/services/navigation/navigation.dart';
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
      // getStoredPassBySystem();
      getStoredBrandId(scaffoldKey.currentContext!);
      //  getTokenAndPass(scaffoldKey.currentContext!);
    });
  }

  void getStoredBrandId(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    auth.updateBrandIdFuture();
  }

  // void getTokenAndPass(BuildContext context) {
  //   final Auth auth = Provider.of<Auth>(context, listen: false);
  //   auth.getTokenAndPassBySystem();
  // }

  Future<void> getStoredPassBySystem() async {
    final prefs = await LocalPrefs.getPassBySystem();
    if (prefs != null) {
      setState(() {
        passBySystem = prefs;
        debugPrint("Password By System: $passBySystem");
      });
    } else {
      debugPrint("No password from system found");
    }
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
              if (kDebugMode) {
                print('brandId2: $snapshot');
                print('passBySystem: $passBySystem');
              }

              if (brandId == null) {
                return const LoginScreen();
              } else {
                return const MainScreen();
              }
              // if (brandId == null) {
              //   return const LoginScreen();
              // } else {
              //   if (passBySystem == 'TRUE') {
              //     // example when going to Change Password
              //     WidgetsBinding.instance.addPostFrameCallback((_) {
              //       if (kDebugMode) {
              //         print('I went here: $passBySystem');
              //       }
              //       NavService.push(screen: ChangePasswordScreen());
              //     });
              //     return const SizedBox.shrink(); // Placeholder while navigating
              //   } else {
              //     return const MainScreen();
              //   }
              // }
            } else {
              return const LoginScreen();
            }

            // if (brandId == null) {
            //   return const LoginScreen();
            // } else {
            //   return const MainScreen();
            // }
          },
        );
      }),
    );
  }
}
