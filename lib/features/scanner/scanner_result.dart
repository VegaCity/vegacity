import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QRResult extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function() closeScreen;

  const QRResult({
    super.key,
    required this.data,
    required this.closeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Kết Quả Quét',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120),
              CircleAvatar(
                radius: 50,
                backgroundImage: data['imageUrl'] != null
                    ? NetworkImage(data['imageUrl'])
                    : null,
                child: data['imageUrl'] == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 20),
              Text(
                data['fullName'] ?? 'N/A',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Số điện thoại: ${data['phoneNumber'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                'CCCD: ${data['cccd'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: data['qrCode']));
                },
                child: const Text('Sao chép mã QR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
