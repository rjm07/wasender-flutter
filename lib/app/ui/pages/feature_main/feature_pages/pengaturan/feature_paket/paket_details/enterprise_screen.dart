import 'package:flutter/material.dart';

import '../../../../../../../utils/lang/images.dart';

class PaketEnterpriseScreen extends StatefulWidget {
  const PaketEnterpriseScreen({super.key});

  @override
  State<PaketEnterpriseScreen> createState() => _PaketEnterpriseScreenState();
}

class _PaketEnterpriseScreenState extends State<PaketEnterpriseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with Title and Price
                Container(
                  color: Colors.deepPurple[700],
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Column(
                    children: [
                      Image.asset(
                        CustomImages.imageEnterprisePlanWhite, // Path to your asset
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover, // Adjust image fit as needed
                      ), // Placeholder for the image
                      const SizedBox(height: 8),
                      const Text(
                        'Enterprise',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Jika Anda adalah bisnis korporasi,\n silakan pilih paket ini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rp. 270.000,-',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        '5 Perangkat / Bulan',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Feature List Section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'FITUR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Pengiriman Pesan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '5000',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        featureRow('Pengiriman Media\n(File, Foto, dan Audio)', '', true),
                        featureRow('Pengiriman Lokasi', '', true),
                        featureRow('Impor Kontak', '', true),
                        featureRow('Cek Nomor Whatsapp', '', true),
                        featureRow('Template Pesan', '', true),
                        featureRow('Pesan Robot', '', true),
                        featureRow('Balas Cepat', '', true),
                        featureRow('Pengiriman Massal', '', true),
                        featureRow('Pesan Terjadwal', '', true),
                        featureRow('Chatbox', '', true),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Jumlah Agen',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '10',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        featureRow('Integrasi Aplikasi', '', true),
                        const SizedBox(
                          height: 44,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create feature row
  Widget featureRow(String featureName, String value, bool isAvailable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              featureName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          Row(
            children: [
              if (value.isNotEmpty)
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(width: 8),
              Icon(
                isAvailable ? Icons.check : Icons.close,
                color: isAvailable ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
