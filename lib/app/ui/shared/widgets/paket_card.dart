import 'package:flutter/material.dart';

class PaketCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String price;
  final String devices;
  final VoidCallback onTap;

  const PaketCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.devices,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Stack(
        clipBehavior: Clip.none, // Allows the button to overflow outside the card
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                children: [
                  Container(
                    height: 90, // Match the height of the image
                    width: 90, // Match the width of the image
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // White background for the border
                    ),
                    child: Image.asset(
                      image, // Path to your asset
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover, // Adjust image fit as needed
                    ),
                  ),
                  const SizedBox(width: 12), // Add some spacing between image and text
                  Expanded(
                    // Ensure text can use available space
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[700],
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis, // Wrap text, add ellipsis if longer than 4 lines
                          ),
                          Text(
                            description, style: const TextStyle(fontSize: 14, color: Colors.black54),
                            maxLines: 4, // Limit description text to 4 lines
                            overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                          ),
                          const SizedBox(height: 8),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(devices, style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Overlay forward button partially
          Positioned(
            right: -16, // Moves the button halfway outside the card
            top: 75, // Adjust the vertical positioning if needed
            child: InkWell(
              onTap: onTap,
              child: Container(
                width: 50, // Fixed width for the circle
                height: 50, // Fixed height for the circle
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30, // Smaller icon size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
