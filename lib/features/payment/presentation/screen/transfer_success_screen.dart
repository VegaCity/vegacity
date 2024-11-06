import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TransferSuccess extends StatefulWidget {
  const TransferSuccess({super.key});

  @override
  State<TransferSuccess> createState() => _TransferSuccessState();
}

class _TransferSuccessState extends State<TransferSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Lottie Animation
            Lottie.asset(
              'assets/images/1.json',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),

            Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blue.withOpacity(0.5)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Chuyển tiền', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10),
                    Text('-200.000 VND',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Container with transaction details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.blue.withOpacity(0.5)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trạng thái:',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('Thành công',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thời gian',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('12:30 PM, 03/10/2024',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tài khoản thẻ',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('1234-5678-9012', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nội dung',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('Thanh toán hoá đơn',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mã đơn hàng',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('#00123456789', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Người nhận',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('Nguyễn Văn A', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Số điện thoại',
                          style:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                      Text('0912345678', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Container(
            //   width: 400,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     border: Border.all(color: Colors.blue.withOpacity(0.5)),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text('Lịch sử giao dịch',
            //           style: TextStyle(fontSize: 14)),
            //       GestureDetector(
            //         onTap: () {
            //           // Navigator.push(
            //           //   context,
            //           //   MaterialPageRoute(
            //           //       builder: (context) => EntryPoint(selectedIndex: 3)),
            //           // );
            //         },
            //         child: const Icon(Icons.arrow_forward_ios,
            //             size: 16, color: Colors.blue),
            //       ),
            //     ],
            //   ),
            // ),

            const Spacer(),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to previous page
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    padding: const EdgeInsets.only(left: 8),
                    minimumSize: const Size(
                        120, 50), // Set the button's minimum width and height
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(2), // Set the corner radius
                    ),
                  ),
                  child: const Text('Quay về',
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () {
                    // Action to transfer more
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 144, 255),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    minimumSize: const Size(
                        200, 50), // Set the button's minimum width and height
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(2), // Set the corner radius
                    ),
                  ),
                  child: const Text('Chuyển thêm',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
