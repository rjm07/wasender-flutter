import 'package:flutter/material.dart';
import 'package:wasender/app/ui/shared/widgets/view_profile/info_card.dart';
import 'package:wasender/app/ui/shared/widgets/view_profile/section_header.dart';

import '../../../../../../../../core/models/profile/profile_data.dart';
import '../../../../../../../../utils/lang/colors.dart';

class ProfileViewScreen extends StatefulWidget {
  final ProfileData? profileData;

  const ProfileViewScreen({super.key,required this.profileData});

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
          backgroundColor: AppColors.navBarColor,
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Personal Information', style: TextStyle(color: Colors.black)),
          ),
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
                children: [
                  const Text(
                    "Basic info, like your name and address, that you use on Nio Platform",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),

                  // Basics Section
                  const SectionHeader(
                    title: 'BASICS',
                  ),
                  const SizedBox(height: 10),
                  InfoCard(
                    children: [
                      InfoRow(
                        label: 'Full Name',
                        value: widget.profileData?.fullName ?? 'Not Add Yet',
                      ),
                      InfoRow(
                        label: 'Display Name',
                        value: widget.profileData?.fullName ?? 'Not Add Yet',
                      ),
                      InfoRow(
                        label: 'Email',
                        value: widget.profileData?.email ?? 'Not Add Yet',
                      ),
                      const InfoRow(
                        label: 'Phone Number',
                        value: 'Not Add Yet',
                      ),
                      const InfoRow(
                        label: 'Date of Birth',
                        value: 'Not Add Yet',
                      ),
                      const InfoRow(
                        label: 'Address',
                        value: 'Not Add Yet',
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Preferences Section
                  const SectionHeader(title: 'PREFERENCES'),
                  const SizedBox(height: 10),
                  const InfoCard(
                    children: [
                      InfoRow(
                        label: 'Language',
                        value: 'Not Add Yet',
                      ),
                      InfoRow(
                        label: 'Date Format',
                        value: 'Not Add Yet',
                      ),
                      InfoRow(
                        label: 'Time Zone',
                        value: 'Not Add Yet',
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
