import 'package:flutter/material.dart';

class QuotaCard extends StatelessWidget {
  const QuotaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      width: MediaQuery.of(context).size.width, // Adjust width based on your need
      height: 210, // Adjust height as per design
      decoration: BoxDecoration(
        color: const Color(0xFF2D4189), // Dark blue background color
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kuota Tersedia",
                    style: TextStyle(
                      color: Color(0xFF90A3FF), // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "0 Perangkat",
                    style: TextStyle(
                      color: Colors.white, // White text for the main count
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kuota Tersedia",
                    style: TextStyle(
                      color: Color(0xFF90A3FF), // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "1 ",
                        style: TextStyle(
                          color: Colors.white, // White text for the count
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.smartphone, // Replace with your icon if custom
                        color: Colors.white,
                        size: 22,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Kuota",
                    style: TextStyle(
                      color: Color(0xFF90A3FF), // Lighter blue text color
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "1 Perangkat",
                    style: TextStyle(
                      color: Colors.white, // White text for the main count
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Last activity at 19 Nov, 2019",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7), // Lighter white text
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceInfoCard extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  final int count;
  final IconData deviceTypeIcon;

  const DeviceInfoCard({
    super.key,
    required this.color,
    required this.image,
    required this.title,
    required this.count,
    required this.deviceTypeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 24,
                width: 24,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                count.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              const SizedBox(width: 8),
              Icon(
                deviceTypeIcon,
                size: 24,
                color: Colors.black54,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PerangkatTerhubungCard extends StatelessWidget {
  final Color color;
  final String image;
  final String name;
  final String number;
  final String status;

  const PerangkatTerhubungCard({
    super.key,
    required this.color,
    required this.image,
    required this.name,
    required this.number,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 24,
                width: 24,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
                  ),
                  Text(
                    number,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.green.shade300, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
