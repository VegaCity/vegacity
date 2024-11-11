import 'package:base/configs/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

Widget buildButtons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF007BFF),
              side: const BorderSide(color: Color(0xFF007BFF)),
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Quay lại'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (BuildContext context) {
                  return const PaymentMethodBottomSheet(); // Gọi widget BottomSheet
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007BFF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Tiếp tục'),
          ),
        ),
      ],
    ),
  );
}

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
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 400,
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
            ..._buildPaymentOptions(), // Gọi hàm sinh danh sách phương thức
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pop(
                  //     context, _selectedMethod); // Trả về phương thức đã chọn
                  context.router.push(const TransferSuccessRoute());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
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

  // Hàm tạo danh sách các phương thức thanh toán với kiểu chữ tùy theo lựa chọn
  List<Widget> _buildPaymentOptions() {
    final methods = ['Momo', 'VNPay', 'PayOs', 'Cash'];
    return methods.map((method) {
      return RadioListTile<String>(
        title: Text(
          method,
          style: TextStyle(
            fontWeight: _selectedMethod == method
                ? FontWeight.bold // Đậm nếu được chọn
                : FontWeight.normal, // Mờ nếu không được chọn
            color: _selectedMethod == method
                ? Colors.black // Màu đen nếu được chọn
                : Colors.grey
                    .withOpacity(0.7), // Màu xám mờ nếu không được chọn
          ),
        ),
        value: method,
        groupValue: _selectedMethod,
        onChanged: (value) {
          setState(() {
            _selectedMethod = value;
          });
        },
      );
    }).toList();
  }
}
