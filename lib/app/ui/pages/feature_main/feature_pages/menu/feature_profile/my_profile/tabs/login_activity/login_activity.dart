import 'package:flutter/material.dart';
import 'package:wasender/app/core/models/profile/profile_data.dart';

class ProfileLoginActivityScreen extends StatefulWidget {
  final List<LoginLogData>? loginLogData;

  const ProfileLoginActivityScreen({super.key, required this.loginLogData});

  @override
  State<ProfileLoginActivityScreen> createState() =>
      _ProfileLoginActivityScreenState();
}

class _ProfileLoginActivityScreenState
    extends State<ProfileLoginActivityScreen> {
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
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: ListTile(
            title: Text(
              loginLogData?[index].browser ?? "-",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(loginLogData?[index].ipAddress == "" ? "Not Add Yet" : loginLogData?[index].ipAddress ?? "-",
                        style: const TextStyle(fontSize: 12)),
                    Text(loginLogData?[index].timestampStr ?? "-",
                        style: const TextStyle(fontSize: 12)),
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
