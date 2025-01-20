import 'package:flutter/material.dart';

import '../../../utils/lang/images.dart';

class WidgetWorkingInProgress extends StatelessWidget {
  const WidgetWorkingInProgress({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            CustomIcons.iconWorkingInProgress,
            height: MediaQuery.of(context).size.height / 10,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "$title Screen",
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black26),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "This page is still under development. \nPlease come back again later.",
            style: TextStyle(fontSize: 16.0, color: Colors.black26),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
