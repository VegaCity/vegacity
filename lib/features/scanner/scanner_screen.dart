import 'package:base/configs/routes/app_router.dart';
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
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera Scanner
          MobileScanner(
            controller: cameraController,
            allowDuplicates: true,
            onDetect: (barcode, args) {
              if (!isScanCompleted) {
                isScanCompleted = true;
                String code = barcode.rawValue ?? "---";
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRResult(
                      code: code,
                      closeScreen: closeScreen,
                    ),
                  ),
                );
              }
            },
          ),

          // QR Scanner Overlay
          QRScannerOverlay(
            overlayColor: Colors.black.withOpacity(0.6),
            borderColor: const Color.fromARGB(0, 166, 169, 172),
            borderRadius: 10,
            borderStrokeWidth: 5,
            scanAreaHeight: 450,
            scanAreaWidth: 320,
          ),

          // Tiêu đề Scanner
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Scanner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Nút QR Scanner ở góc trên bên trái
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left_outlined,
                size: 30,
                color: Color.fromARGB(255, 30, 144, 255),
              ),
              onPressed: () {
                context.router.push(TabViewScreenRoute());
              },
            ),
          ),

          // Nút Flash và Camera ở góc trên bên phải
          Positioned(
            top: 40,
            right: 10,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.flash_on,
                    color: isFlashOn
                        ? Colors.white
                        : Color.fromARGB(255, 30, 144, 255),
                  ),
                  onPressed: () {
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                    cameraController.toggleTorch();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.flip_camera_android,
                    color: isFrontCamera
                        ? Colors.white
                        : Color.fromARGB(255, 30, 144, 255),
                  ),
                  onPressed: () {
                    setState(() {
                      isFrontCamera = !isFrontCamera;
                    });
                    cameraController.switchCamera();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
