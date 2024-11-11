import 'package:flutter/material.dart';

class TimAgenScreen extends StatefulWidget {
  const TimAgenScreen({super.key});

  @override
  State<TimAgenScreen> createState() => _TimAgenScreenState();
}

class _TimAgenScreenState extends State<TimAgenScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Tim Agen Screen')),
        ],
      ),
    );
  }
}
