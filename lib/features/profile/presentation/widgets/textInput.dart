// lib/widgets/detail_column.dart

import 'package:flutter/material.dart';

final TextEditingController _nameController = TextEditingController(text: '');
final TextEditingController _dobController = TextEditingController(text: '');
final TextEditingController _emailController = TextEditingController(text: '');
final TextEditingController _phoneController = TextEditingController(text: '');

String name = _nameController.text;
String dob = _dobController.text;
String email = _emailController.text;
String phone = _phoneController.text;

Widget buildTextField(String labelText, String placeholder, IconData iconData,
    {int maxLines = 1,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: (labelText == 'Tên')
            ? _nameController
            : (labelText == 'Ngày sinh (dd/mm/yyyy)')
                ? _dobController
                : (labelText == 'Email')
                    ? _emailController
                    : (labelText == 'Số điện thoại')
                        ? _phoneController
                        : null,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator, // Thêm bộ kiểm tra đầu vào
        onTap: onTap, // Cho phép onTap nếu cần thiết
        decoration: InputDecoration(
          hintText: placeholder,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    ],
  );
}
