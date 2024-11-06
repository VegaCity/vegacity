import 'package:flutter/material.dart';

Widget buildSourceSection() {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(7.0),
          child: Text(
            'Nguồn chuyển tiền',
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'TÀI KHOẢN THANH TOÁN - 1290197042292',
                    items: const [
                      DropdownMenuItem(
                        value: 'TÀI KHOẢN THANH TOÁN - 1290197042292',
                        child: Text(
                          'TÀI KHOẢN THANH TOÁN - 1290197042292',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
                // Khoảng cách giữa dropdown và text
                const Text(
                  '1 VND',
                  style: TextStyle(color: Color(0xFF007BFF)),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
