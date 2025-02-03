import 'package:flutter/material.dart';
import 'package:wasender/app/core/models/profile/profile_data.dart';

class ProfileLoginActivityScreen extends StatefulWidget {
  final List<LoginLogData>? loginLogData;

  const ProfileLoginActivityScreen({super.key, required this.loginLogData});

  @override
  State<ProfileLoginActivityScreen> createState() => _ProfileLoginActivityScreenState();
}

class _ProfileLoginActivityScreenState extends State<ProfileLoginActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginActivityHistory(
        loginLogData: widget.loginLogData,
      ),
    );
  }
}

class LoginActivityHistory extends StatelessWidget {
  final List<LoginLogData>? loginLogData;

  const LoginActivityHistory({super.key, required this.loginLogData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: loginLogData?.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 8.0, bottom: 16.0),
              child: Row(
                children: [
                  // Text content in expanded section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loginLogData?[index].browser ?? "-",
                          style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              loginLogData?[index].ipAddress == ""
                                  ? "Not Add Yet"
                                  : loginLogData?[index].ipAddress ?? "-",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              loginLogData?[index].timestampStr ?? "-",
                              style: const TextStyle(fontSize: 12, color: Colors.black87),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Close Button at the right
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () {
                      // Implement delete functionality here
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
