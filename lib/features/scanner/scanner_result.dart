import 'package:animate_do/animate_do.dart';
import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/scanner/detail_info_screen.dart';
import 'package:base/features/vcard/domain/entities/vcard_entity.dart';
import 'package:base/features/vcard/presentation/controllers/vcard_controller/vcard_controller.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  Future<void> _saveToSharedPreferences(String id, String cccdPassport) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('cccdPassport', cccdPassport);
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
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              context.router.pop();
            },
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
    final wallet = useFetchResult.data?.wallet ?? 0;
    final balance = useFetchResult.data?.wallet.balance ?? 0;
    final BalanceHistory = useFetchResult.data?.wallet.balanceHistory ?? 0;
    final name = useFetchResult.data?.name ?? "No Vcard code";
    final vcard = useFetchResult.data?.id ?? "No Vcard code";
    final phonenumber = useFetchResult.data?.phoneNumber;
    final cccdpassport = useFetchResult.data?.cccdpassport;

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
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 5, right: 5, bottom: 5),
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
                  height: 196,
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
                  padding:
                      const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInLeft(
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                            // Row chứa Phone và Wallet, sử dụng spaceBetween
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                FadeInRight(
                                  child: Text(
                                    'wallet: ${useFetchResult.data?.wallet.walletType.name ?? "No wallet"}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
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
                                  borderRadius:
                                      BorderRadius.circular(20), // Bo góc 20
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.2), // Màu của shadow
                                      spreadRadius: 2, // Phạm vi của shadow
                                      blurRadius: 6, // Độ mờ của shadow
                                      offset: Offset(
                                          0, 4), // Vị trí của shadow (x, y)
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical:
                                        5), // Thêm padding để có không gian xung quanh số tiền
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
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
                                          isVisible.value = !isVisible
                                              .value; // Toggle visibility
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
                          context.router.push(const TransferScreenRoute());
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
          ],
        ),
      ),
    );
  }
}
