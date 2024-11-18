import 'package:animate_do/animate_do.dart';
import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/vcard/domain/entities/vcard_entity.dart';
import 'package:base/features/vcard/presentation/controllers/vcard_controller/vcard_controller.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'scanner_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class QRResult extends HookConsumerWidget {
  final String code;
  final Function() closeScreen;

  const QRResult({
    super.key,
    required this.code,
    required this.closeScreen,
  });

  Future<void> _saveToSharedPreferences(String id, String cccdpassport) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('cccdpassport', cccdpassport);
  }

  void _navigateToHome(BuildContext context) {
    final tabsRouter =
        context.router.root.innerRouterOf<TabsRouter>(TabViewScreenRoute.name);
    if (tabsRouter != null) {
      tabsRouter.setActiveIndex(0);
      context.router.popUntilRouteWithName(TabViewScreenRoute.name);
    } else {
      context.router.pushAndPopUntil(
        const TabViewScreenRoute(children: [HomeScreenRoute()]),
        predicate: (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final state = ref.watch(vcardControllerProvider);
    // final fetchReslut = useFetch<PromotionEntities>(
    //   function: (model, context) => ref
    //       .read(promotionControllerProvider.notifier)
    //       .getPromotions(model, context),
    //   initialPagingModel: PagingModel(
    //       // ví dụ ở đây và trong widgetshowCustomButtom ở widget test floder luôn

    //       // filterContent: ref.read(filterSystemStatus).type
    //       // filterSystemContent: ref.read(filterSystemStatus).type,
    //       // filterContent: ref.read(filterPartnerStatus).type,
    //       // searchDateFrom: dateFrom,
    //       // searchDateTo: dateTo,
    //       ),
    //   context: context,
    // );

    final useFetchResult = useFetchObject<VcardEntities>(
      function: (context) async {
        final result = await ref
            .read(vcardControllerProvider.notifier)
            .getVCardData(context, code);

        if (result == null) {
          // Delay một chút trước khi chuyển trang để snackbar có thời gian hiển thị
          await Future.delayed(const Duration(milliseconds: 1000));
          if (context.mounted) {
            _navigateToHome(context);
          }
        }
        return result;
      },
      context: context,
    );

    if (useFetchResult.isFetchingData && useFetchResult.data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (useFetchResult.data == null) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0052CC), // Blue
                  Color(0xFF00AAFF), // Light Blue
                  Color.fromARGB(255, 111, 194, 208),
                  Color.fromARGB(255, 116, 240, 231), // Pastel Light Purple
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent, // AppBar trong suốt
                  elevation: 0,
                  centerTitle: true,
                  title: FadeInDown(
                    child: const Text(
                      'Scanner Result',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red.shade400,
              ),
              const SizedBox(height: 16),
              const Text(
                'Cannot found VCard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please check the QR code again and try again',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToHome(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 144, 255),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Return to home page',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Rest of your existing code for successful data fetch
    final wallet = useFetchResult.data?.wallets ?? 0;
    final balance = useFetchResult.data?.wallets[0].balance ?? 0;
    final BalanceHistory = useFetchResult.data?.wallets[0].balanceHistory ?? 0;
    final name = useFetchResult.data?.cusName ?? "No name";
    final vcard = useFetchResult.data?.id ?? "No Vcard code";
    final phonenumber = useFetchResult.data?.phoneNumber;
    final cccdpassport = useFetchResult.data?.cusCccdpassport;
    final scrollController = useScrollController();
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true); // Lặp lại hiệu ứng nhấp nháy

    final animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    _saveToSharedPreferences(vcard, cccdpassport!);

    final isVisible = useState<bool>(true); // Default to true (balance visible)

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
          color: Colors.white,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const ScannerScreen();
            }));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 5, right: 5, bottom: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeInDown(
                child: Card(
                  color: Colors.transparent,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 380,
                    height: 240,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0052CC),
                          Color(0xFF00AAFF),
                          Color.fromARGB(255, 111, 194, 208),
                          Color.fromARGB(255, 116, 240, 231),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 35.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FadeInLeft(
                                              child: Text(
                                                name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            FadeInLeft(
                                              child: Text(
                                                'wallet: ${useFetchResult.data?.wallets[0].walletType.name ?? "no wallet"}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FadeInRight(
                                        child: QrImageView(
                                          data: "data",
                                          size: 90,
                                          version: QrVersions.auto,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  FadeInLeft(
                                    child: Text(
                                      vcard,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FadeInLeft(
                                        child: Text(
                                          'Phone: $phonenumber',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  FadeInUp(
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 116, 240, 231),
                                            Color.fromARGB(255, 111, 194, 208),
                                            Color(0xFF00AAFF),
                                            Color(0xFF0052CC),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 6,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: FadeInLeft(
                                              child: Text(
                                                isVisible.value
                                                    ? '**** VNĐ'
                                                    : '$balance VNĐ',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          FadeInRight(
                                            child: IconButton(
                                              icon: Icon(
                                                isVisible.value
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              onPressed: () {
                                                isVisible.value =
                                                    !isVisible.value;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Thêm logo ở góc trên bên trái
                        Positioned(
                          top: 0,
                          left: 10,
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/images%2Fvega-icon.png?alt=media&token=186ce318-bea6-4c1d-b5bd-862f7f03b6ac', // URL của ảnh logo
                            width: 40, // Kích thước của logo
                            height: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons
                                    .error, // Hiển thị icon lỗi nếu tải ảnh không thành công
                                color: Colors.red,
                                size: 40,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                  strokeWidth: 2,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    const SizedBox(width: 65),
                    FadeInUp(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (useFetchResult
                                    .data?.wallets[0].walletType.name ==
                                "SpecificWallet") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'You cannot deposit money into this wallet.',
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              context.router.push(const TransferScreenRoute());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text("Deposit money"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Container(
              //   margin: const EdgeInsets.only(left: 25.5, right: 35),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       FadeInLeft(
              //         child: const Text(
              //           "Promotion",
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 5),
              //       FadeTransition(
              //         opacity: animation,
              //         child: FadeInLeft(
              //           child: const Text(
              //             "new",
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.red, // Thêm màu đỏ cho nổi bật
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 15),
              // Padding(
              //     padding: const EdgeInsets.only(
              //         top: 16.0, left: 12, right: 12, bottom: 10),
              //     child: FadeInUp(
              //       child: GridView.builder(
              //         itemCount: fetchReslut.items.length, // Giữ lại dòng này
              //         // physics: const AlwaysScrollableScrollPhysics(),
              //         shrinkWrap: true,
              //         controller: scrollController,
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: AssetsConstants.defaultPadding - 5.0,
              //         ),
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 2, // Số cột
              //           crossAxisSpacing: 8, // Khoảng cách giữa các cột
              //           mainAxisSpacing: 10, // Khoảng cách giữa các hàng
              //           childAspectRatio: 0.6, // Tỷ lệ khung hình
              //         ),
              //         itemBuilder: (context, index) {
              //           return PromotionItem(
              //             promotion: fetchReslut.items[index],
              //             onCallback: fetchReslut.refresh,
              //           );
              //         },
              //       ),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
