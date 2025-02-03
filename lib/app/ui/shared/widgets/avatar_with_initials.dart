import 'package:flutter/material.dart';

import '../../../utils/lang/colors.dart';

class AvatarWithInitials extends StatelessWidget {
  final String fullName;
  final String? imageUrl;

  const AvatarWithInitials({super.key, required this.fullName, this.imageUrl});

  String getInitials(String name) {
    if (name.trim().isEmpty) {
      return "?"; // Fallback in case fullName is empty
    }

    List<String> nameParts = name.trim().split(" ");
    String initials = "";
    if (nameParts.isNotEmpty) initials += nameParts[0][0];
    if (nameParts.length > 1) initials += nameParts[1][0];
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30, // Adjust the size of the avatar
      backgroundColor: AppColors.primary, // Background color for initials
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null, // Load image if available
      child: imageUrl == null
          ? Text(
              getInitials(fullName),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          : null, // Display initials if no image is available
    );
  }
}
