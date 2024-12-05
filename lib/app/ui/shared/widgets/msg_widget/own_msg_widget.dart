import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnMsgWidget extends StatelessWidget {
  const OwnMsgWidget({super.key, required this.status, required this.time, this.ownMessage});

  final int status;
  final String time;
  final String? ownMessage;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width - 120;
    DateTime dateTime = DateTime.parse(time);
    String formattedDate = DateFormat('MMM d').format(dateTime);
    String formattedTime = DateFormat('H:mm a').format(dateTime);

    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ownMessage ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
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
                      // Dynamically determine the icon based on the `status`
                      status == 2
                          ? Icons.access_time_outlined
                          : status == 3
                              ? Icons.check
                              : status == 4
                                  ? Icons.home
                                  : Icons.close, // Default icon for other cases
                      color: Colors.black38,
                      size: 14,
                    ),
                  ],
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
