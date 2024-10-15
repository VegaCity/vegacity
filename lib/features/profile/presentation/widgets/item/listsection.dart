import 'package:flutter/material.dart';

Widget buildListItem({
  required IconData icon,
  required String title,
  String? subtitle,
  bool showArrow = false,
  bool isLastItem = false, // Tham số mới để xác định mục cuối cùng
}) {
  return Column(
    children: [
      ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: TextStyle(color: Colors.black), // Đặt màu chữ thành đen
        ),
        subtitle: subtitle != null
            ? Text(subtitle, style: TextStyle(color: Colors.black))
            : null,
        trailing: showArrow ? Icon(Icons.arrow_forward_ios) : null,
        onTap: () {
          // Xử lý sự kiện nhấn
        },
      ),
    ],
  );
}
