import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/feature_profile/profile_screen.dart';
import 'package:wasender/app/ui/shared/widgets/dashboard_cards.dart';

import '../../../../../../core/services/auth.dart';
import '../../../../../../core/services/perangkat_saya/perangkat_saya.dart';
import '../../../../../../core/services/preferences.dart';
import '../../../../../../core/services/socket_io/socket.dart';
import '../../../../../../utils/lang/images.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  String name = "Blipcom Indonesia";
  String description = "Informasi Perangkat whatsapp yang terhubung!";
  final SocketService socketService = SocketService();
  late String fullName = "";
  late String image = "";
  late String role = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDeviceList();
    });
    WidgetsBinding.instance.addObserver(this);
    socketService.initializeSocket();
  }

  Future<void> getDeviceList() async {
    final PerangkatSayaServices devices = Provider.of<PerangkatSayaServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    debugPrint("tokenBearer: $tokenBearer");
    if (tokenBearer != null) {
      devices.updateDeviceListFuture(tokenBearer, showErrorSnackbar: (String errorMessage) {
        if (errorMessage.contains("Error: 401 - UNAUTHORIZED")) {
          // Handle unauthorized error by showing logout confirmation
          final auth = Provider.of<Auth>(context, listen: false);
          _confirmLogout(context, auth);
        } else {
          // Show the error as a snackbar
          debugPrint("Error: $errorMessage");
        }
      });
    }
  }

  Future<void> getUserInfo() async {
    fullName = (await LocalPrefs.getFullName()) ?? "Guest";
    image = (await LocalPrefs.getImage()) ?? "https://via.placeholder.com/90"; // Default placeholder image
    role = (await LocalPrefs.getUserRole()) ?? "User";

    setState(() {}); // Trigger rebuild to update UI with fetched data
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    socketService.dispose(); // Clean up socket resources if needed
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is back in the foreground
      socketService.initializeSocket();
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
      socketService.dispose(); // Optionally close the socket when the app is backgrounded
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 24.0, right: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Hai!",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black54),
                        ),
                        Text(
                          fullName,
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Text(
                          role,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black54),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // Add your tap handling logic here
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(50), // Matches the Container's borderRadius for ripple effect
                      child: Container(
                        height: 90, // Match the height of the image
                        width: 90, // Match the width of the image
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // Circular shape
                          color: Colors.white, // White background for the border
                        ),
                        child: ClipOval(
                          // Ensures the image is clipped to a circular shape
                          child: Image.network(
                            image.isNotEmpty ? image : "https://via.placeholder.com/90",
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover, // Adjust image fit as needed
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error, // Show an error icon if the image fails to load
                                color: Colors.red,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ringkasan",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    const QuotaCard(),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Informasi Perangkat",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'See All',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        DeviceInfoCard(
                          color: Colors.lightBlue.shade100,
                          image: CustomIcons.iconWhatsAppGeneric,
                          title: 'Total Perangkat',
                          count: 1,
                          deviceTypeIcon: Icons.phone_iphone,
                        ),
                        const SizedBox(height: 16),
                        DeviceInfoCard(
                          color: Colors.lightGreen.shade100,
                          image: CustomIcons.iconWhatsAppGeneric,
                          title: 'Perangkat Aktif',
                          count: 1,
                          deviceTypeIcon: Icons.phone_iphone,
                        ),
                        const SizedBox(height: 16),
                        DeviceInfoCard(
                          color: Colors.amber.shade100,
                          image: CustomIcons.iconWhatsAppGeneric,
                          title: 'Perangkat Non Aktif',
                          count: 0,
                          deviceTypeIcon: Icons.phone_iphone,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Perangkat Terhubung",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            '+ Tumbah',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    PerangkatTerhubungCard(
                        color: Colors.lightBlue.shade100,
                        image: CustomIcons.iconWhatsAppGeneric2,
                        name: 'ANDRYTEL',
                        number: '628137*******',
                        status: 'Active'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, Auth auth) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Disable the back button
          child: AlertDialog(
            title: const Text("Session expired"),
            content: const Text("Please log in again."),
            actions: <Widget>[
              TextButton(
                child: const Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  auth.logout(); // Call the logout method
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
