import 'package:flutter/material.dart';

class PaymentMethodBottomSheet extends StatefulWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  _PaymentMethodBottomSheetState createState() =>
      _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  String? _selectedMethod; // Biến để lưu phương thức thanh toán đã chọn

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      height: 400, // Chiều cao của BottomSheet
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phương thức thanh toán',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text('Momo'),
              value: 'Momo',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value; // Cập nhật phương thức đã chọn
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('VNPay'),
              value: 'VNPay',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value; // Cập nhật phương thức đã chọn
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('PayOs'),
              value: 'PayOs',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value; // Cập nhật phương thức đã chọn
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Cash'),
              value: 'Cash',
              groupValue: _selectedMethod,
              onChanged: (value) {
                setState(() {
                  _selectedMethod = value; // Cập nhật phương thức đã chọn
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Xử lý xác nhận phương thức thanh toán
                  Navigator.pop(context, _selectedMethod); // Trả về phương thức đã chọn
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
