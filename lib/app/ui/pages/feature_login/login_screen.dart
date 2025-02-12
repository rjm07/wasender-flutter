import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/utils/lang/images.dart';

import '../../../core/services/auth.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  var _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
        auth.login(emailController.text, passwordController.text).onError((error, stackTrace) {
          setState(() {
            _isAuthenticating = false;
          });
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              error.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
          messenger.showSnackBar(snackBar); // Use messenger instead of ScaffoldMessenger.of(context)
        });
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text(''), actions: const [
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 40.0),
          child: Text(
            'v1.0.0.0',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w200, color: Colors.black87),
          ),
        ),
      ]),
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
                  Image.asset(
                    CustomImages.imageWaSenderLogo,
                    height: 180,
                  ),
                  const Column(children: [
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Text(
                      'WhatsApp Sender',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.black87),
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
                          label: "Username / Email Address",
                          hintText: "Username / Email Address",
                          isObscure: false,
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
                          onChanged: (text) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginTextField(
                          label: "Password",
                          hintText: "Password",
                          isObscure: true,
                          controller: passwordController,
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
                          onChanged: (text) {},
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
