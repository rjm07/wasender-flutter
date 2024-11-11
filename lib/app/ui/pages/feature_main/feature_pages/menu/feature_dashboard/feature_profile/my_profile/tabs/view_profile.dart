import 'package:flutter/material.dart';
import 'package:wasender/app/ui/shared/widgets/view_profile/info_card.dart';
import 'package:wasender/app/ui/shared/widgets/view_profile/section_header.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({super.key});

  @override
  State<ProfileViewScreen> createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Personal Information', style: TextStyle(color: Colors.black)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                // Handle edit functionality
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text('Edit', style: TextStyle(fontSize: 16, color: Colors.green.shade400)),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black), // Change back icon color
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
              child: ListView(
                children: const [
                  Text(
                    "Basic info, like your name and address, that you use on Nio Platform",
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 20),

                  // Basics Section
                  SectionHeader(
                    title: 'BASICS',
                  ),
                  SizedBox(height: 10),
                  InfoCard(
                    children: [
                      InfoRow(
                        label: 'Full Name',
                        value: 'Abu Bin Ishtiyak',
                      ),
                      InfoRow(
                        label: 'Display Name',
                        value: 'Ishtiyak',
                      ),
                      InfoRow(
                        label: 'Email',
                        value: 'info@softnio.com',
                      ),
                      InfoRow(
                        label: 'Phone Number',
                        value: 'Not Add Yet',
                      ),
                      InfoRow(
                        label: 'Date of Birth',
                        value: '29 Feb 1986',
                      ),
                      InfoRow(
                        label: 'Address',
                        value: '2337 Kildeer Drive, Kentucky Canada.',
                      )
                    ],
                  ),
                  SizedBox(height: 20),

                  // Preferences Section
                  SectionHeader(title: 'PREFERENCES'),
                  SizedBox(height: 10),
                  InfoCard(
                    children: [
                      InfoRow(
                        label: 'Language',
                        value: 'English (United States)',
                      ),
                      InfoRow(
                        label: 'Date Format',
                        value: 'M d, YYYY',
                      ),
                      InfoRow(
                        label: 'Time Zone',
                        value: 'Bangladesh (GMT +6)',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
