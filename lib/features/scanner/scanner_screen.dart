import 'package:flutter/material.dart';
import 'scanner_result.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Scanner',
          style: TextStyle(
            color: Colors.white,
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
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner)),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              cameraController.toggleTorch();
            },
            icon: Icon(Icons.flash_on,
                color: isFlashOn ? Colors.white : Colors.black),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              cameraController.switchCamera();
            },
            icon: Icon(Icons.flip_camera_android,
                color: isFrontCamera ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please Scanner",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Stack(children: [
                MobileScanner(
                    controller: cameraController,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScanCompleted) {
                        isScanCompleted = true;
                        String code = barcode.rawValue ?? "---";
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return QRResult(
                            code: code,
                            closeScreen: closeScreen,
                          );
                        }));
                      }
                    }),
                QRScannerOverlay(
                  overlayColor: Colors.black26,
                  borderColor: const Color.fromARGB(255, 30, 144, 255),
                  borderRadius: 20,
                  borderStrokeWidth: 10,
                  scanAreaHeight: 250,
                  scanAreaWidth: 250,
                )
              ]),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "!Scan properly to see results!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 30, 144, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
