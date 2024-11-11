import 'package:flutter/material.dart';

class AvatarWithInitials extends StatelessWidget {
  final String fullName;
  final String? imageUrl;

  const AvatarWithInitials({super.key, required this.fullName, this.imageUrl});

  String getInitials(String name) {
    List<String> nameParts = name.split(" ");
    String initials = "";
    if (nameParts.isNotEmpty) initials += nameParts[0][0];
    if (nameParts.length > 1) initials += nameParts[0][1];
    return initials.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30, // Adjust the size of the avatar
      backgroundColor: Colors.orangeAccent, // Background color for initials
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null, // Load image if available
      child: imageUrl == null
          ? Text(
              getInitials(fullName),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : null, // Display initials if no image is available
    );
  }
}
