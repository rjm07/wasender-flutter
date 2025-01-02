import 'package:flutter/material.dart';

import '../../../utils/lang/colors.dart';

class PerangkatSayaCard extends StatelessWidget {
  final Color color;
  final String title;
  final bool isActive;
  final String deviceID;
  final String devicePkey;
  final String devicePhoneNumber;

  const PerangkatSayaCard({
    super.key,
    required this.color,
    required this.title,
    required this.isActive,
    required this.deviceID,
    required this.devicePkey,
    required this.devicePhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 6, // Blur radius
            offset: const Offset(0, 3), // Offset for the shadow (x, y)
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50.0, // Width of the circle
                height: 50.0, // Height of the circle
                decoration: const BoxDecoration(
                  color: AppColors.primary, // Background color (green)
                  shape: BoxShape.circle, // Circular shape
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 18.0, // Font size
                      fontWeight: FontWeight.bold, // Font weight
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Paket & Kuota",
                        style: TextStyle(
                          color: Colors.black54, // Lighter blue text color
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                'FREE / 200',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          color: Colors.black54, // Lighter blue text color
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          isActive ? "CONNECTED" : "DISCONNECTED",
                          style: TextStyle(
                            color: isActive
                                ? AppColors.primary
                                : Colors.redAccent.shade700, // White text for the main count
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status",
                style: TextStyle(
                  color: AppColors.primary, // Lighter blue text color
                  fontSize: 12,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deviceID,
                      style: TextStyle(
                        color: Colors.black54, // White text for the main count
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      devicePkey,
                      style: TextStyle(
                        color: Colors.black54, // White text for the main count
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(
                      color: AppColors.primary, // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          devicePhoneNumber,
                          style: TextStyle(
                            color: Colors.black54, // White text for the main count
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Text(
                        //   "6281377239880",
                        //   style: TextStyle(
                        //     color: Colors.black54, // White text for the main count
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jatuh Tempo",
                    style: TextStyle(
                      color: AppColors.primary, // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "26 Sep 2024",
                          style: TextStyle(
                            color: Colors.black54, // White text for the main count
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
