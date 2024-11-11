import 'package:flutter/material.dart';
import 'package:wasender/app/utils/lang/images.dart';

import '../../shared/widgets/custom_button.dart';
import '../feature_login/login_screen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _isAuthenticating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomImages.imageWaSenderBG),
            fit: BoxFit.cover, // Ensures the image fills the screen
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      RoundedSideButton(
                        title: 'Lihat Video',
                        onPressed: () {},
                        topLeft: 25.0,
                        bottomLeft: 25.0,
                        image: Image.asset(CustomImages.imagePlayVideo),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'WhatsApp Sender',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 32.0),
                    child: Image.asset(
                      CustomImages.imageWaSenderIntro,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      text: 'Boost your marketing\n with ',
                      style: TextStyle(fontSize: 28.0, color: Colors.white, fontWeight: FontWeight.w200),
                      children: [
                        TextSpan(
                          text: 'WASender',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                    child: Text(
                      'Dalam era digital saat ini, respons cepat dan efisien dalam komunikasi bisnis adalah kunci kesuksesan. Lalu, bagaimana Anda bisa unggul?',
                      style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 44.0),
                    child: Column(
                      children: [
                        WidgetButton(
                          onPressed: () {},
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
                                  "Daftar",
                                  style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w400),
                                ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 54,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              ); // Add your onPressed functionality here
                            },
                            child: const Text(
                              'Continue to Login >',
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w200, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
