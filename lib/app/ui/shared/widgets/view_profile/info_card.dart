import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDisabled;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.green.shade700)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isDisabled ? Colors.grey : Colors.black54,
              fontWeight: isDisabled ? FontWeight.w400 : FontWeight.w500,
            ),
            maxLines: 3,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
