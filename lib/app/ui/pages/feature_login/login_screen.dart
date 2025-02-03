import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/utils/lang/images.dart';

import '../../../core/services/auth.dart';
import '../../../core/services/navigation/navigation.dart';
import '../../../utils/lang/colors.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_textfield.dart';
import 'change_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  final emailVisibilityNotifier = ValueNotifier<bool>(true);
  final passwordVisibilityNotifier = ValueNotifier<bool>(true);

  var _isAuthenticating = false;
  final _isEmailObscure = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);

    void onLoginPressed() {
      setState(() {
        _isAuthenticating = true;
      });

      final messenger = ScaffoldMessenger.of(context); // Store reference to avoid using context in async gap

      if (formKey.currentState!.validate()) {
        auth.login(emailController.text, passwordController.text).then((result) {
          setState(() {
            _isAuthenticating = false;
          });

          if (result?.messageDesc == 'LOGIN SUCCESS' || result?.messageDesc == 'LOGIN SUCCES') {
            if (result?.messageData['password_by_system'] == "FALSE") {
              if (kDebugMode) {
                print('I went here: ${result?.messageData['password_by_system']}');
              }
              setState(() {
                Firebase.initializeApp();
                auth.updateBrandIdFuture();
                emailController.clear();
                passwordController.clear();
              });
            } else {
              NavService.push(screen: ChangePasswordScreen());
            }
          }
        }).onError((error, stackTrace) {
          // Handle unexpected errors (e.g., network issues)
          setState(() {
            _isAuthenticating = false;
          });
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "An unexpected error occurred: ${error.toString()}",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
          messenger.showSnackBar(snackBar);
        });
      } else {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(''),
          actions: const [
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: 40.0),
              child: Text(
                'v1.0.0.0',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.black87),
              ),
            ),
          ],
          backgroundColor: AppColors.navBarColor),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 44,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 60.0),
                    child: Image.asset(
                      CustomImages.imageWaSenderLogo,
                      height: MediaQuery.of(context).size.height / 12,
                    ),
                  ),
                  const Column(children: [
                    Text(
                      'Please sign in with WhatUp',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black87),
                    ),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoginTextField(
                          onTap: () {
                            emailController.clear();
                          },
                          label: "Username / Email Address",
                          hintText: "Username / Email Address",
                          isObscure: _isEmailObscure,
                          controller: emailController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                _isAuthenticating = false;
                              });
                              return "This field is required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (String value) {},
                          suffixIcon: null,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: passwordVisibilityNotifier,
                          builder: (context, isObscure, child) {
                            return LoginTextField(
                              label: "Password",
                              hintText: "Password",
                              isObscure: isObscure,
                              controller: passwordController,
                              suffixIcon: IconButton(
                                color: isObscure ? Colors.black54 : AppColors.primary,
                                icon: Icon(
                                  isObscure ? Icons.visibility_off : Icons.visibility,
                                ),
                                onPressed: () {
                                  passwordVisibilityNotifier.value = !isObscure;
                                },
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _isAuthenticating = false;
                                  });
                                  return "This field is required";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (String value) {},
                            );
                          },
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        WidgetButton(
                          onPressed: onLoginPressed, //onLoginPressed,
                          child: _isAuthenticating
                              ? const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 18.0,
                                        width: 18.0,
                                        child: CircularProgressIndicator(color: Colors.white)),
                                    SizedBox(
                                      width: 24.0,
                                    ),
                                    Text(
                                      "Please wait...",
                                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              child: Divider(
                                color: Colors.black26, // Line color
                                thickness: 1,
                                // Line thickness
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
                              child: Text(
                                'Atau',
                                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100, color: Colors.black87),
                              ),
                            ),
                            SizedBox(
                              width: 24,
                              child: Divider(
                                color: Colors.black26, // Line color
                                thickness: 1,
                                // Line thickness
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: WidgetButtonImage(
                                  title: "Google",
                                  onPressed: () {},
                                  image: Image.asset(CustomImages.imageGoogleLogo), // Use the correct icon for Google
                                  borderColor: Colors.greenAccent.shade700,
                                  labelColor: Colors.greenAccent.shade700,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: WidgetButtonImage(
                                  title: "Facebook",
                                  onPressed: () {},
                                  image: Image.asset(CustomImages.imageFBLogo), // Use the correct icon for Facebook
                                  borderColor: Colors.blueAccent.shade200,
                                  labelColor: Colors.blueAccent.shade700,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
