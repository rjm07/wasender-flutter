import 'package:flutter/material.dart';

import '../../../../../shared/widgets/working_in_progress.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: WidgetWorkingInProgress(
              title: 'Bantuan',
            ),
          ),
        ],
      ),
    );
  }
}
