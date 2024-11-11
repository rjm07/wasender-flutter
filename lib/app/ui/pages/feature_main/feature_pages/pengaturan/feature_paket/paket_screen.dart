import 'package:flutter/material.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/pengaturan/feature_paket/paket_details/enterprise_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/pengaturan/feature_paket/paket_details/pro_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/pengaturan/feature_paket/paket_details/starter_screen.dart';
import 'package:wasender/app/utils/lang/images.dart';

import '../../../../../shared/widgets/paket_card.dart';

class PaketScreen extends StatefulWidget {
  const PaketScreen({super.key});

  @override
  State<PaketScreen> createState() => _PaketScreenState();
}

class _PaketScreenState extends State<PaketScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Paket'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.of(context).pop(); // Navigates back to the previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Starter Plan
              PaketCard(
                image: CustomImages.imageStarterPlan,
                title: "Starter",
                description: "Jika Anda adalah bisnis kecil, silakan pilih paket ini.",
                price: "Rp. 100.000,-",
                devices: "1 Perangkat / Bulan",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaketStarterScreen(),
                    ),
                  );
                },
              ),
              // Pro Plan
              PaketCard(
                image: CustomImages.imageProPlan,
                title: "Pro",
                description: "Jika Anda adalah bisnis menengah, silakan pilih paket ini.",
                price: "Rp. 200.000,-",
                devices: "2 Perangkat / Bulan",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaketProScreen(),
                    ),
                  );
                },
              ),
              // Enterprise Plan
              PaketCard(
                image: CustomImages.imageEnterprisePlan,
                title: "Enterprise",
                description: "Jika Anda adalah bisnis korporasi, silakan pilih paket ini.",
                price: "Rp. 270.000,-",
                devices: "5 Perangkat / Bulan",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaketEnterpriseScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
