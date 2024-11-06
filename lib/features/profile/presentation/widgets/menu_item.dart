import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final TextStyle? titleStyle;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          // Thêm border ở đây
          color: Colors.black, // Màu viền
          width: 2, // Độ dày của viền
        ),
      ),
      child: Row(
        children: [
          FaIcon(
            icon,
            color: const Color(0xFFFF6B6B),
            size: 24,
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          const FaIcon(
            FontAwesomeIcons.chevronRight,
            color: Colors.black,
            size: 12,
          ),
        ],
      ),
    );
  }
}