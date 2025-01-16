import 'package:flutter/material.dart';
import 'package:wasender/app/utils/lang/colors.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget? child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RoundedSideButton extends StatelessWidget {
  const RoundedSideButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.topLeft,
    required this.bottomLeft,
    this.image, // New parameter for the image
  });

  final String title;
  final void Function() onPressed;
  final double topLeft;
  final double bottomLeft;
  final Image? image; // Nullable image parameter

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          bottomLeft: Radius.circular(bottomLeft),
          topRight: const Radius.circular(0.0),
          bottomRight: const Radius.circular(0.0),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            backgroundColor: Colors.orangeAccent, // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft),
                bottomLeft: Radius.circular(bottomLeft),
                topRight: const Radius.circular(0.0),
                bottomRight: const Radius.circular(0.0),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Size of the Row based on its children
            children: [
              if (image != null) ...[
                image!, // Display the image if provided
                const SizedBox(width: 8.0), // Space between image and text
              ],
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetButtonImage extends StatelessWidget {
  const WidgetButtonImage({
    super.key,
    required this.title,
    required this.onPressed,
    this.image, // Image parameter
    required this.borderColor,
    this.labelColor,
  });

  final String title;
  final void Function() onPressed;
  final Image? image; // Image instead of icon
  final Color borderColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) ...[
            SizedBox(
              width: 18,
              height: 18,
              child: image, // Set image size
            ),
            const SizedBox(width: 10), // Space between the image and text
          ],
          Text(
            title,
            style: TextStyle(color: labelColor),
          ),
        ],
      ),
    );
  }
}
