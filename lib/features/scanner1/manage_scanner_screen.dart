import 'package:base/configs/routes/app_router.dart';
import 'package:base/tab_screen.dart';
import 'package:flutter/material.dart';
import 'manage_scanner_result.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<QrScreen> {
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
    final tabsRouter = AutoTabsRouter.of(context); // Lấy tabsRouter

    return Scaffold(
      body: Stack(
        children: [
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
                    builder: (context) => ScannerResult(
                      code: code,
                      closeScreen: closeScreen,
                    ),
                  ),
                );
              }
            },
          ),
          QRScannerOverlay(
            overlayColor: Colors.black.withOpacity(0.6),
            borderColor: const Color.fromARGB(0, 166, 169, 172),
            borderRadius: 10,
            borderStrokeWidth: 5,
            scanAreaHeight: 450,
            scanAreaWidth: 320,
          ),
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
                tabsRouter.setActiveIndex(0); // Quay về tab Home (index 0)
              },
            ),
          ),
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
                        : const Color.fromARGB(255, 30, 144, 255),
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
                        : const Color.fromARGB(255, 30, 144, 255),
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
