import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/core/services/navigation/navigation.dart';
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
    final ProfileServices profileData =
        Provider.of<ProfileServices>(context, listen: false);
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
    return FutureBuilder<ProfileDataResponse?>(
        future: _profileDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 4,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final ProfileDataResponse profileDataResp =
                snapshot.data as ProfileDataResponse;

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
                                ClipOval(
                                  // Ensures the image is clipped to a circular shape
                                  child: Image.network(
                                    profileDataResp.messageData?.avatar ??
                                        CustomIcons.iconProfilePicture,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                    // Adjust image fit as needed
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    (loadingProgress
                                                            .expectedTotalBytes ??
                                                        1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      if (error.toString().contains('404') ||
                                          error.toString().contains(
                                              'HTTP request failed')) {
                                        return Image.asset(
                                          CustomIcons
                                              .iconProfilePicture, // Use the custom icon for the profile
                                          height: 90,
                                          width: 90,
                                        );
                                      } else {
                                        return const Icon(
                                          Icons
                                              .error, // Show a generic error icon for other errors
                                          color: Colors.red,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  profileDataResp.messageData?.email ?? '-',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(profileDataResp.messageData?.role ?? '-',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                Text(
                                    profileDataResp.messageData?.inactive ==
                                            "TRUE"
                                        ? "Not Verified"
                                        : "Verified",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: profileDataResp
                                                    .messageData?.inactive ==
                                                "TRUE"
                                            ? Colors.red
                                            : Colors.green)),
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
                                NavService.push(
                                  screen: ViewProfileScreen(
                                    profileData: profileDataResp.messageData,
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
                                NavService.push(
                                  screen: ViewProfileScreen(
                                    profileData: profileDataResp.messageData,
                                    initialTabIndex: 1,
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
                                NavService.push(
                                  screen: ViewProfileScreen(
                                    profileData: profileDataResp.messageData,
                                    initialTabIndex: 2,
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
                                    _isDarkMode =
                                        value; // Toggle the switch state
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
                    padding: const EdgeInsets.only(
                        left: 48, right: 48, bottom: 44.0),
                    child: SizedBox(
                      width: double
                          .infinity, // Make the button expand to full width
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) =>
                                false, // Remove all previous routes
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 12),
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                5.0), // Change the radius here
                          ),
                        ),
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text('Sign Out',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text("No data available");
          }
        });
  }
}
