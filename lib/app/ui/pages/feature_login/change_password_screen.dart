import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/ui/shared/widgets/custom_textfield.dart';

import '../../../core/services/auth.dart';
import '../../../utils/lang/colors.dart';
import '../../shared/widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _State();
}

class _State extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordVisibilityNotifier = ValueNotifier<bool>(true);
  final confirmPasswordVisibilityNotifier = ValueNotifier<bool>(true);
  var _isAuthenticating = false;

  void onSimpanDanLanjutPressed() async {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    setState(() {
      _isAuthenticating = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    if (formKey.currentState!.validate()) {
      auth.changePassword(passwordController.text, confirmPasswordController.text).then((result) {
        setState(() {
          _isAuthenticating = false;
        });

        if (result?.messageData['success'] == true) {
          debugPrint('I went here');
          setState(() {
            Navigator.pop(context);
            auth.updateBrandIdFuture();
          });
        } else {
          // Handle error message returned from auth.login
          final snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              result?.messageDesc ?? "",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
          messenger.showSnackBar(snackBar);
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
    }
  }

  void clearAllData() async {
    Navigator.pop(context);
    await Auth().logout();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            clearAllData();
          },
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 64, 20, 20),
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  spacing: 20,
                  children: [
                    Column(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keamanan Akun',
                          style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Text(
                          'Untuk menjara keamanan akun, silahkan masukkan kata sandi baru.',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Column(
                          spacing: 20,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: passwordVisibilityNotifier,
                              builder: (context, isObscure, child) {
                                return LoginTextField(
                                  label: "Kata Sandi",
                                  hintText: "Kata Sandi",
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
                                      return "This field is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (String text) {},
                                );
                              },
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: confirmPasswordVisibilityNotifier,
                              builder: (context, isObscure, child) {
                                return LoginTextField(
                                  label: "Konfirmasi Kata Sandi",
                                  hintText: "Konfirmasi Kata Sandi",
                                  isObscure: isObscure,
                                  controller: confirmPasswordController,
                                  suffixIcon: IconButton(
                                    color: isObscure ? Colors.black54 : AppColors.primary,
                                    icon: Icon(
                                      isObscure ? Icons.visibility_off : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      confirmPasswordVisibilityNotifier.value = !isObscure;
                                    },
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field is required";
                                    } else if (value != passwordController.text) {
                                      return "Password and confirm password must be the same";
                                    }
                                    return null;
                                  },
                                  onChanged: (String text) {},
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                WidgetButton(
                  onPressed: onSimpanDanLanjutPressed,
                  child: _isAuthenticating
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 18.0, width: 18.0, child: CircularProgressIndicator(color: Colors.white)),
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
                          "Simpan dan Lanjut",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
