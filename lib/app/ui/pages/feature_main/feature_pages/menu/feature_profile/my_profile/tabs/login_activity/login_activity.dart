import 'package:flutter/material.dart';

class ProfileLoginActivityScreen extends StatefulWidget {
  const ProfileLoginActivityScreen({super.key});

  @override
  State<ProfileLoginActivityScreen> createState() => _ProfileLoginActivityScreenState();
}

class _ProfileLoginActivityScreenState extends State<ProfileLoginActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginActivityHistory(),
    );
  }
}

class LoginActivityHistory extends StatelessWidget {
  final List<Map<String, String>> historyData = [
    {
      'browser': 'Chrome on Window',
      'ip': '192.149.122.128',
      'date': '13:58 PM',
    },
    {
      'browser': 'Mozilla on Window',
      'ip': '86.188.154.225',
      'date': 'Nov 20, 2019 10:34 PM',
    },
    {
      'browser': 'Chrome in Mac',
      'ip': '192.149.122.128',
      'date': 'Nov 12, 2019 08:56 PM',
    },
    {
      'browser': 'Chrome in Window',
      'ip': '192.149.122.128',
      'date': 'Nov 03, 2019 04:29 PM',
    },
    {
      'browser': 'Mozilla on Window',
      'ip': '86.188.154.225',
      'date': 'Oct 29, 2019 9:38 PM',
    },
    {
      'browser': 'Chrome in iMac',
      'ip': '192.149.122.128',
      'date': 'Oct 23, 2019 04:16 PM',
    },
    {
      'browser': 'Chrome in Window',
      'ip': '192.149.122.128',
      'date': 'Oct 15, 2019 11:41 PM',
    },
    {
      'browser': 'Mozilla on Window',
      'ip': '86.188.154.225',
      'date': 'Oct 13, 2019 5:43 PM',
    },
    {
      'browser': 'Chrome in iMac',
      'ip': '192.149.122.128',
      'date': 'Oct 03, 2019 04:12 PM',
    },
  ];

  LoginActivityHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: ListTile(
            title: Text(
              historyData[index]['browser']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(historyData[index]['ip']!, style: const TextStyle(fontSize: 12)),
                    Text(historyData[index]['date']!, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.close,
                size: 18,
              ),
              onPressed: () {
                // Implement delete functionality here
              },
            ),
          ),
        );
      },
    );
  }
}
