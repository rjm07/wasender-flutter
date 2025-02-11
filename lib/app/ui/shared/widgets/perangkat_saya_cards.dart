import 'package:flutter/material.dart';

import '../../../utils/lang/colors.dart';
import 'avatar_with_initials.dart';

class PerangkatSayaCard extends StatelessWidget {
  final Color color;
  final String title;
  final bool isActive;
  final String role;
  final String category;
  final String deviceID;
  final String dueDate;
  final String devicePkey;
  final String devicePhoneNumber;

  const PerangkatSayaCard({
    super.key,
    required this.color,
    required this.title,
    required this.role,
    required this.isActive,
    required this.category,
    required this.deviceID,
    required this.dueDate,
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
            color: Colors.black12, // Shadow color
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
            children: [
              Container(
                width: 50.0, // Width of the circle
                height: 50.0, // Height of the circle
                decoration: const BoxDecoration(
                  color: AppColors.primary, // Background color (green)
                  shape: BoxShape.circle, // Circular shape
                ),
                child: Center(
                  child: AvatarWithInitials(
                    fullName: (deviceID.isEmpty || double.tryParse(deviceID) != null) ? 'Anonymous' : deviceID,
                    imageUrl: null,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Device ID",
                    style: TextStyle(
                      color: AppColors.primary, // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  Column(
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
                ],
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
                    "Name",
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
                          role,
                          style: TextStyle(
                            color: Colors.black54, // White text for the main count
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          devicePhoneNumber,
                          style: TextStyle(
                            color: Colors.black54, // White text for the main count
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Inbox / Due at",
                    style: TextStyle(
                      color: AppColors.primary, // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color: Colors.black54, // White text for the main count
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        dueDate,
                        style: TextStyle(
                          color: Colors.black54, // White text for the main count
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Spacer(),
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
                        border: Border.all(color: AppColors.primary, width: 1), borderRadius: BorderRadius.circular(5)),
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
                        color:
                            isActive ? AppColors.primary : Colors.redAccent.shade700, // White text for the main count
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
    );
  }
}
