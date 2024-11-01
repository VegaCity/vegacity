import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'manage_scanner_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScannerResult extends StatelessWidget {
  final String code;
  final Function() closeScreen;
  const ScannerResult({
    super.key,
    required this.code,
    required this.closeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Scanner Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          style: const ButtonStyle(
            iconSize: WidgetStatePropertyAll(30),
            iconColor:
                WidgetStatePropertyAll(Color.fromARGB(255, 30, 144, 255)),
            backgroundColor: WidgetStatePropertyAll(Colors.white70),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const QrScreen();
            }));
          },
          icon: const Icon(Icons.qr_code_scanner),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            QrImageView(
              data: "data",
              size: 300,
              version: QrVersions.auto,
            ),
            const Text(
              "Scanned QR",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              code,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 150,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                  },
                  child: const Text("Copy")),
            )
          ],
        ),
      ),
    );
  }
}
