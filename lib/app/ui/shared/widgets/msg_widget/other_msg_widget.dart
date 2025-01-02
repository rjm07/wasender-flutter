import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OthersMsgWidget extends StatelessWidget {
  const OthersMsgWidget({super.key, required this.status, required this.time, this.ownMessage});

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
