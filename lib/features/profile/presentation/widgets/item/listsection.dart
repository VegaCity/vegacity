import 'package:flutter/material.dart';

Widget buildListItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  String? subtitle,
  bool showArrow = false,
  required VoidCallback onTap, // Thêm onTap để xử lý sự kiện nhấn
}) {
  return InkWell(
    onTap: onTap, // Gọi hàm onTap khi nhấn
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.black, // Đặt màu icon thành đen
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black, // Đặt màu chữ tiêu đề thành đen
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          : null,
      trailing: showArrow
          ? const Icon(
              Icons.chevron_right_outlined,
              color: Colors.black, // Đặt màu của biểu tượng mũi tên thành đen
            )
          : null,
    ),
  );
}
