import 'package:flutter/material.dart';

import '../../../../../shared/widgets/working_in_progress.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({super.key});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: WidgetWorkingInProgress(
              title: 'Pembayaran',
            ),
          ),
        ],
      ),
    );
  }
}
