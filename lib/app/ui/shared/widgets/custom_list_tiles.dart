import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'avatar_with_initials.dart';

class SMListTiles extends StatelessWidget {
  const SMListTiles({super.key, required this.image, required this.title, required this.onTap});

  final String image;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
      child: ListTile(
        leading: SizedBox(
            height: 24.0,
            width: 24.0,
            child: Image.asset(
              image,
              color: Colors.black38,
            )),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black38, fontSize: 13.0),
        ),
        onTap: onTap,
      ),
    );
  }
}

class ChatUserListTile extends StatelessWidget {
  const ChatUserListTile(
      {super.key,
      required this.title,
      required this.onTap,
      required this.fullName,
      required this.description,
      required this.time});

  final String fullName;
  final String title;
  final String description;
  final String time;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDate = DateFormat('MMM d').format(dateTime);
    String formattedTime = DateFormat('H:mm a').format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 0.0),
      child: ListTile(
        leading: AvatarWithInitials(
          fullName: fullName, // Provide image URL if available, else null
        ),
        title: Text(fullName),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.black54),
        ),
        trailing: Column(
          children: [
            Text(formattedDate, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text(formattedTime, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
