import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'scanner_result.dart';

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

  Future<void> _checkQRCode(String code) async {
    try {
      // Gọi API để kiểm tra mã QR
      final response = await Dio().get(
        'https://api.vegacity.id.vn/api/v1/etags',
        queryParameters: {'qrCode': code},
      );

      if (response.statusCode == 200 && response.data != null) {
        // Nếu mã hợp lệ, chuyển sang màn hình QRResult
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRResult(
              data: response.data,
              closeScreen: closeScreen,
            ),
          ),
        );
      } else {
        _showErrorDialog('Mã QR không hợp lệ hoặc không tìm thấy dữ liệu.');
      }
    } catch (e) {
      _showErrorDialog('Lỗi khi gọi API: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lỗi'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);

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
                _checkQRCode(code); // Gọi API sau khi quét mã QR
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
            top: 45,
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
                tabsRouter.setActiveIndex(0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
