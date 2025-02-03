import 'package:flutter/material.dart';

import '../../../../../../../../utils/lang/colors.dart';

class ProfileSecurityScreen extends StatefulWidget {
  const ProfileSecurityScreen({super.key});

  @override
  State<ProfileSecurityScreen> createState() => _ProfileSecurityScreenState();
}

class _ProfileSecurityScreenState extends State<ProfileSecurityScreen> {
  bool securityAlert1 = true;
  bool securityAlert2 = false;
  bool isActivityLogEnabled = true;
  bool isTwoFactorEnabled = true;

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
                SizedBox(height: 20),
                Text('Security Settings', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87)),
                SizedBox(height: 4),
                Text(
                  "These settings helps you keep your account secure",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          backgroundColor: AppColors.navBarColor,
          elevation: 0,
          automaticallyImplyLeading: false,

          iconTheme: const IconThemeData(color: Colors.black), // Change back icon color
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0, bottom: 120),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      buildActivityLogsSection(),
                      const SizedBox(height: 24),
                      buildPasswordSection(),
                      const SizedBox(height: 24),
                      buildTwoFactorAuthSection(),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
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

  Widget buildActivityLogsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Save my Activity Logs',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'You can save all your activity logs including\n unusual activity detected.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        Switch(
          value: isActivityLogEnabled,
          onChanged: (bool value) {
            // Toggle the switch and update the UI
            setState(() {
              isActivityLogEnabled = value;
            });
          },
          activeColor: Colors.green,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget buildPasswordSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Change Password',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Set a unique password to protect\n your account',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 4),
            Text(
              ' Last changed: Oct 2, 2019',
              style: TextStyle(fontSize: 12, color: Colors.black45),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // Handle password change
          },
          child: const Text(
            'Change',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  Widget buildTwoFactorAuthSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    '2 Factor Auth',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Container for status (Enabled/Disabled)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isTwoFactorEnabled ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isTwoFactorEnabled ? 'Enabled' : 'Disabled',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Secure your account with 2FA security. When it is activated, you '
                'will need to\n enter not only your password, but also\n a special code '
                'using the app. You can receive this code in your mobile app.',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            // Toggle the 2FA status when the button is pressed
            setState(() {
              isTwoFactorEnabled = !isTwoFactorEnabled;
            });
          },
          child: Text(
            isTwoFactorEnabled ? 'Disable' : 'Enable',
            style: const TextStyle(fontSize: 14, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
