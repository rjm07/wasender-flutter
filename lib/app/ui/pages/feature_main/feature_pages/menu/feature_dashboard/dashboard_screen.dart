import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/feature_profile/profile_screen.dart';
import 'package:wasender/app/ui/shared/widgets/dashboard_cards.dart';

import '../../../../../../core/services/perangkat_saya/perangkat_saya.dart';
import '../../../../../../core/services/preferences.dart';
import '../../../../../../utils/lang/images.dart';
import '../../../../../../utils/snackbar/snackbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name = "Blipcom Indonesia";
  String description = "Informasi Perangkat whatsapp yang terhubung!";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDeviceList();
    });
  }

  Future<void> getDeviceList() async {
    final PerangkatSayaServices devices = Provider.of<PerangkatSayaServices>(context, listen: false);
    final String? tokenBearer = await LocalPrefs.getBearerToken();
    debugPrint("tokenBearer: $tokenBearer");
    if (tokenBearer != null) {
      devices.updateDeviceListFuture(
        tokenBearer,
        showErrorSnackbar: (String errorMessage) {
          SnackbarUtil.showErrorSnackbar(context, errorMessage);
        },
      );
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
                padding: const EdgeInsets.only(left: 24.0, right: 18.0),
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
                          name,
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black87),
                        ),
                        Text(
                          description,
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
                          shape: BoxShape.circle, color: Colors.white, // White background for the border
                        ),
                        child: Image.asset(
                          CustomIcons.iconProfilePicture, // Path to your asset
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover, // Adjust image fit as needed
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
}
