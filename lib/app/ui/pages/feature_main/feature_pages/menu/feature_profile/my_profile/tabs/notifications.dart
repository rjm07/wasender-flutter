import 'package:flutter/material.dart';

import '../../../../../../../shared/widgets/view_profile/info_card.dart';

class ProfileNotificationsScreen extends StatefulWidget {
  const ProfileNotificationsScreen({super.key});

  @override
  State<ProfileNotificationsScreen> createState() => _ProfileNotificationsScreenState();
}

class _ProfileNotificationsScreenState extends State<ProfileNotificationsScreen> {
  bool securityAlert1 = true;
  bool securityAlert2 = false;
  bool newsAlert1 = true;
  bool newsAlert2 = false;
  bool newsAlert3 = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Notification Settings', style: TextStyle(color: Colors.black)),
                Text(
                  "You will get only notification when have enabled.",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,

          iconTheme: const IconThemeData(color: Colors.black), // Change back icon color
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
          child: InfoCard(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Security Alerts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text('You will get only notifications when enabled.'),
                ],
              ),

              const SizedBox(height: 16),
              buildSwitchTile(
                title: 'Email me whenever encounter unusual activity',
                value: securityAlert1,
                onChanged: (val) => setState(() => securityAlert1 = val),
              ),
              buildSwitchTile(
                title: 'Email me if new browser is used to sign in',
                value: securityAlert2,
                onChanged: (val) => setState(() => securityAlert2 = val),
              ),
              const SizedBox(height: 24),
              // News Section
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text('You will get only those email notifications you want.'),
                ],
              ),

              const SizedBox(height: 12),
              buildSwitchTile(
                title: 'Notify me by email about sales and latest news',
                value: newsAlert1,
                onChanged: (val) => setState(() => newsAlert1 = val),
              ),
              buildSwitchTile(
                title: 'Email me about new features and updates',
                value: newsAlert2,
                onChanged: (val) => setState(() => newsAlert2 = val),
              ),
              buildSwitchTile(
                title: 'Email me about tips on using account',
                value: newsAlert3,
                onChanged: (val) => setState(() => newsAlert3 = val),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green, // Green color for active switch
    );
  }
}
