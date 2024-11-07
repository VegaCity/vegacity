import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/vcard/domain/entities/etag_entity.dart';
import 'package:base/features/scanner/controllers/etag_scanner_controller.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'scanner_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:intl/intl.dart';

@RoutePage()
class QRResult extends HookConsumerWidget {
  final String code;
  final Function() closeScreen;

  const QRResult({
    super.key,
    required this.code,
    required this.closeScreen,
  });

  Future<void> _saveToSharedPreferences(
      String etagCode, String cccdPassport) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('etagCode', etagCode);
    await prefs.setString('cccdPassport', cccdPassport);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final state = ref.watch(etagScannerControllerProvider);

    final useFetchResult = useFetchObject<EtagParentEntity>(
      function: (context) => ref
          .read(etagScannerControllerProvider.notifier)
          .getEtagCardData(context, code),
      context: context,
    );

    if (useFetchResult.isFetchingData) {
      return const Center(child: CircularProgressIndicator());
    }
    if (useFetchResult.data == null) {
      return const Center(child: Text('No data found'));
    }

    // example take information from etag entity
    // field nó sẽ case là rỗng hoặc null => check null trước khi lấy
    final etagDetail = useFetchResult.data?.etag.etagDetail;

    final name = etagDetail?.fullName;
    final etag = useFetchResult.data?.etag.etagCode ?? "No etag code";
    final dob = etagDetail?.birthday;
    final cccdPassport = etagDetail?.cccdPassport;

    // Save etagCode and cccd to SharedPreferences
    _saveToSharedPreferences(etag, cccdPassport!);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 144, 255),
        title: const Text(
          'Scanner Result',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          iconSize: 30,
          color: const Color.fromARGB(255, 30, 144, 255),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ScannerScreen();
            }));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 380,
                height: 210,
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // QrImageView(
                    //   data: code,
                    //   size: 100,
                    //   version: QrVersions.auto,
                    // ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            etag,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            name!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(dob!), // Convert DateTime to String
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Text(
                          //   cccdPassport,
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 16,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Replace the existing SizedBox code with the following
            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Row(
                children: [
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width - 220,
                  //   height: 60,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // context.router.push(const TransferScreenRoute());
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor:
                  //           Colors.green, // Set background color to blue
                  //       foregroundColor:
                  //           Colors.white, // Set text color to white
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(
                  //             5), // Set border radius to 5
                  //       ),
                  //     ),
                  //     child: const Text(
                  //         "Chi tiết"), // Button text for "Transfer Money"
                  //   ),
                  // ),
                  const SizedBox(width: 65), // Add space between buttons
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        //  Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => TransferScreen(card: card),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.blue, // Set background color to blue
                        foregroundColor:
                            Colors.white, // Set text color to white
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5), // Set border radius to 5
                        ),
                      ),
                      child: const Text(
                          "Nạp tiền"), // Button text for "Transfer Money"
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
