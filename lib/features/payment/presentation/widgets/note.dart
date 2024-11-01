import 'package:flutter/material.dart';

Widget buildNoteSection() {
  // Controller để quản lý nội dung nhập
  final TextEditingController noteController = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.all(7.0),
        child: Text(
          'Nội dung chuyển tiền',
          style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: noteController, // Kết nối controller với TextField
            decoration: const InputDecoration(
              hintText: 'Nhập nội dung', // Thay đổi label thành nội dung nhập
              border: InputBorder.none, // Ẩn đường viền
              hintStyle:
                  TextStyle(color: Colors.grey), // Màu cho nội dung nhập
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
          ),
        ),
      ),
    ],
  );
}
