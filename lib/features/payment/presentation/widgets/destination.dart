import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Thư viện để định dạng số

class NumberWithCurrencyFormatter extends TextInputFormatter {
  
  final NumberFormat _formatter =
      NumberFormat('#,###'); // Định dạng số có dấu chấm

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Loại bỏ " VND" khỏi chuỗi để không gây lỗi khi định dạng lại
    final String cleanedText =
        newValue.text.replaceAll(' VND', '').replaceAll('.', '');

    // Nếu giá trị mới trống, trả về giá trị rỗng
    if (cleanedText.isEmpty) return newValue.copyWith(text: '');

    // Chuyển chuỗi thành số nguyên
    final int? value = int.tryParse(cleanedText);
    if (value == null) return oldValue; // Nếu không hợp lệ, giữ giá trị cũ

    // Định dạng lại số và thêm " VND"
    final newText = '${_formatter.format(value)} VND';
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
          offset: newText.length - 4), // Đặt con trỏ trước " VND"
    );
  }
}

Widget buildDestinationSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(7.0),
        child: const Text(
          'Chuyển đến',
          style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
        ),
      ),
      const SizedBox(height: 10),
      Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Số tài khoản',
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              suffixIcon:
                  const Icon(FontAwesomeIcons.idCard, color: Color(0xFF007BFF)),
            ),
          ),
        ),
      ),
      const SizedBox(height: 10),
      // TextField cho số tiền với dấu chấm phân cách và VND
      Center(
        child: Container(
          width: 350,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4FF),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: TextField(
            keyboardType: TextInputType.number, // Bàn phím số
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Chỉ cho phép nhập số
              NumberWithCurrencyFormatter(), // Định dạng số với VND
            ],
            decoration: InputDecoration(
              hintText: '0 VND',
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintStyle: const TextStyle(color: Color(0xFF007BFF)),
            ),
            style: const TextStyle(fontSize: 24, color: Color(0xFF007BFF)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}
