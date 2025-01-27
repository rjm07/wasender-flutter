import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/core/services/profile/profile_services.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_profile/my_profile/my_profile.dart';

import '../../../../../../core/models/profile/profile_data.dart';
import '../../../../../../core/services/preferences.dart';
import '../../../../../../utils/lang/colors.dart';
import '../../../../../../utils/lang/images.dart';
import '../../../../feature_login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = true;

  late Future<ProfileDataResponse?> _profileDataFuture;

  @override
  void initState() {
    super.initState();

    _profileDataFuture = getProfileData();
  }

  Future<ProfileDataResponse?> getProfileData() async {
    final ProfileServices profileData = Provider.of<ProfileServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    debugPrint("tokenBearer: $tokenBearer");
    if (tokenBearer != null) {
      try {
        final data = await profileData.getProfileData(tokenBearer);
        return data; // Return the data
      } catch (error) {
        debugPrint("Error fetching dashboard data: $error");
        return null; // Handle errors
      }
    }
    return null; // Return null if tokenBearer is null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navBarColor,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  // Profile section
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          CustomIcons.iconProfilePicture, // Path to your asset
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover, // Adjust image fit as needed
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'admin@blipcom.id',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text('Customer', style: TextStyle(fontSize: 14, color: Colors.grey)),
                        const Text('Verified',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.green)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 0.5, color: Colors.black26),
                  const SizedBox(height: 24),
                  // Options list
                  Card(
                    child: ListTile(
                      iconColor: Colors.green.shade300,
                      textColor: Colors.black54,
                      leading: const Icon(Icons.person),
                      title: const Text('View Profile'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ViewProfileScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      iconColor: Colors.green.shade300,
                      textColor: Colors.black54,
                      leading: const Icon(Icons.settings),
                      title: const Text('Account Settings'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ViewProfileScreen(initialTabIndex: 2), // Security Tab
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      iconColor: Colors.green.shade300,
                      textColor: Colors.black54,
                      leading: const Icon(Icons.timeline),
                      title: const Text('Login Activity'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ViewProfileScreen(initialTabIndex: 3), // Activity Tab
                          ),
                        );
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Dark Mode'),
                      iconColor: Colors.green.shade300,
                      textColor: Colors.black54,
                      trailing: Switch(
                        value: _isDarkMode,
                        onChanged: (bool value) {
                          setState(() {
                            _isDarkMode = value; // Toggle the switch state
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      onTap: () {
                        // Optional: You can also toggle the switch when tapping the ListTile
                        setState(() {
                          _isDarkMode = !_isDarkMode;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Spacer to push the button to the bottom
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, bottom: 44.0),
            child: SizedBox(
              width: double.infinity, // Make the button expand to full width
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false, // Remove all previous routes
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0), // Change the radius here
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Sign Out', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
