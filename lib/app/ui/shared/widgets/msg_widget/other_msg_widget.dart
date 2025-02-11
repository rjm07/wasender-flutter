import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OthersMsgWidget extends StatelessWidget {
  const OthersMsgWidget({super.key, this.status, this.time, this.ownMessage, this.filePath});

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

    if (filePath != null) {
      if (filePath!.endsWith('.png') || filePath!.endsWith('.jpg') || filePath!.endsWith('.jpeg')) {
        // Render the image
      } else {
        // Render a placeholder for non-image files
      }
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ownMessage ?? '',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ]),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$formattedDate   $formattedTime',
                        style: TextStyle(color: Colors.black38, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
