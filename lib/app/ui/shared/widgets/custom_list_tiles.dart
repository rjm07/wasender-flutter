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
      required this.category,
      required this.time});

  final String fullName;
  final String title;
  final String description;
  final String time;
  final String category;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDate = DateFormat('MMM d').format(dateTime);
    String formattedTime = DateFormat('H:mm a').format(dateTime);

    return ListTile(
      leading: SizedBox(
        width: 60, // Set a fixed width
        height: 60, // Set a fixed height
        child: AvatarWithInitials(
          fullName: (fullName.isEmpty || double.tryParse(fullName) != null) ? 'Anonymous' : fullName,
          imageUrl: null,
        ),
      ),
      title: Text(fullName),
      subtitle: Text(
        category == 'text'
            ? description
            : description.isEmpty
                ? 'sent an attachment'
                : '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13, color: Colors.black54),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(formattedDate, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          Text(formattedTime, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
      onTap: onTap,
    );
  }
}
