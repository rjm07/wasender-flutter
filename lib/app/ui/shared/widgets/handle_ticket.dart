import 'package:flutter/material.dart';

class HandleTicketScreen extends StatelessWidget {
  const HandleTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "INFORMATION",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),
            // Status Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Text(
                  "Status",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Spacer(),
                Text(
                  "Conversation status is OPEN",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Incoming Message Row
            Row(
              children: [
                Icon(Icons.email, color: Colors.grey, size: 20),
                SizedBox(width: 8),
                Text(
                  "Incoming Message at",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Spacer(),
                Text(
                  "09/12/2024 13:58:48",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Conversation Chat Row
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey, size: 20),
                SizedBox(width: 8),
                Text(
                  "Conversation Chat at",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Spacer(),
                Text(
                  "09/12/2024 13:58:48",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 32),
            // Attention Box
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.black, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Attention, this conversation needs your support, click handle this customer.",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            // Handle Ticket Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle ticket functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.confirmation_number, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "Handle Ticket",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HandleStatusLabelWidget extends StatelessWidget {
  const HandleStatusLabelWidget({super.key, required this.icon, required this.title, required this.status});

  final String icon;
  final String title;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(icon, color: Colors.blue, height: 20, width: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Spacer(),
        Text(
          "Conversation status is $status",
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}

class HandleGenericLabelWidget extends StatelessWidget {
  const HandleGenericLabelWidget({super.key, required this.icon, required this.title, required this.value});

  final String icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(icon, color: Colors.blue, height: 20, width: 20),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
