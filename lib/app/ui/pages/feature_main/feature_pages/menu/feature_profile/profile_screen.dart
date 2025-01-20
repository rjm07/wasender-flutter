import 'package:flutter/material.dart';

import '../../../../../shared/widgets/working_in_progress.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: WidgetWorkingInProgress(
              title: 'Profile',
            ),
          ),
        ],
      ),
    );
  }
}
