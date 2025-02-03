import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnMsgWidget extends StatelessWidget {
  const OwnMsgWidget({super.key, this.status, this.time, this.ownMessage, this.filePath});

  final int? status;
  final String? time;
  final String? ownMessage;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width - 120;
    DateTime dateTime = DateTime.parse(time!);
    String formattedDate = DateFormat('MMM d').format(dateTime);
    String formattedTime = DateFormat('H:mm a').format(dateTime);

    Widget fileWidget = Container();

    if (filePath != null) {
      if (filePath!.endsWith('.png') || filePath!.endsWith('.jpg') || filePath!.endsWith('.jpeg')) {
        // Render the image
        fileWidget = ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(filePath!),
            width: maxWidth,
            height: 200,
            fit: BoxFit.cover,
          ),
        );
      } else {
        // Render a placeholder for non-image files
        fileWidget = Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(Icons.insert_drive_file, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  filePath!.split('/').last, // Display the file name
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      }
    }

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              color: Colors.teal,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filePath != null) ...[
                      fileWidget,
                      const SizedBox(height: 10),
                    ],
                    if (ownMessage != null && ownMessage!.isNotEmpty)
                      Text(
                        ownMessage!,
                        style: TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    '$formattedDate $formattedTime',
                    style: TextStyle(color: Colors.black38, fontSize: 11),
                  ),
                  const SizedBox(width: 5),
                  Icon(Icons.circle, color: Colors.black38, size: 4),
                  const SizedBox(width: 5),
                  Icon(
                    // Dynamically determine the icon based on the status
                    status == 2
                        ? Icons.access_time_outlined
                        : status == 3
                            ? Icons.check
                            : status == 4
                                ? Icons.home
                                : Icons.timer_outlined, // Default icon for other cases
                    color: Colors.black38,
                    size: 14,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
