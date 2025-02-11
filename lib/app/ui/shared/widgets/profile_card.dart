import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onTap;
  final bool isDarkMode;
  final Switch? trailing;

  const ProfileCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDarkMode = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          iconColor: Colors.green.shade300,
          textColor: Colors.black54,
          leading: icon,
          title: Text(title),
          onTap: onTap,
          trailing: isDarkMode == true ? Switch(value: true, onChanged: (bool? value) {}) : trailing),
    );
  }
}
