import 'package:animate_do/animate_do.dart';
import 'package:base/features/payment/presentation/screen/controller/orderV2_controller.dart';
import 'package:base/features/payment/presentation/screen/controller/order_controller.dart';
import 'package:base/features/payment/presentation/widgets/cccd.dart';
import 'package:base/features/payment/presentation/widgets/destination.dart';
import 'package:base/features/payment/presentation/widgets/inputAmount.dart';
import 'package:base/features/payment/presentation/widgets/payment.dart';
import 'package:base/utils/commons/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class TransferScreen extends HookConsumerWidget {
  const TransferScreen({super.key});

  void submit({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String packageOrderId,
    required int chargeAmount,
    required String cccdpassport,
    required String paymentType,
    required String promoCode,
  }) async {
    await ref.read(orderControllerProvider.notifier).order(
          packageOrderId: packageOrderId,
          chargeAmount: chargeAmount,
          cccdpassport: cccdpassport,
          paymentType: paymentType,
          promoCode: promoCode,
          context: context,
        );
  }

  void submitWithoutPromotion({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String packageOrderId,
    required int chargeAmount,
    required String cccdPassport,
    required String paymentType,
  }) async {
    await ref.read(orderv2ControllerProvider.notifier).orderv2(
          packageOrderId: packageOrderId,
          chargeAmount: chargeAmount,
          cccdPassport: cccdPassport,
          paymentType: paymentType,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider);
    final cccdController = useTextEditingController();
    final etagCodeController = useTextEditingController();
    final chargeAmountController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final paymentType = useState<String>("");
    final promoCodeController = useTextEditingController();

    useEffect(() {
      _loadSavedValues(cccdController, etagCodeController, promoCodeController);
      return null;
    }, []);

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4FF),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
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
                      'Transfer',
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              DestinationSection(etagCodeController: etagCodeController),
              const SizedBox(height: 20),
              CccdSection(cccdController: cccdController),
              const SizedBox(height: 20),
              AmountInputSection(
                  chargeAmountController: chargeAmountController),
              const SizedBox(height: 20),
              PaymentOptionButton(context: context, paymentType: paymentType),
              const SizedBox(height: 20),
              _buildActionButtons(
                context,
                ref,
                formKey,
                etagCodeController,
                chargeAmountController,
                cccdController,
                promoCodeController,
                paymentType,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadSavedValues(
      TextEditingController cccdController,
      TextEditingController etagCodeController,
      TextEditingController promoCodeController) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEtagCode = prefs.getString('id') ?? '';
    final savedCccd = prefs.getString('cccdpassport') ?? '';
    final savedPromoCode = prefs.getString('promotionCode') ?? '';

    etagCodeController.text = savedEtagCode;
    cccdController.text = savedCccd;
    promoCodeController.text = savedPromoCode;
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
    TextEditingController packageOrderController,
    TextEditingController chargeAmountController,
    TextEditingController cccdController,
    TextEditingController promoCodeController,
    ValueNotifier<String> paymentType,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeInUp(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0052CC), // Blue
                      Color(0xFF00AAFF), // Light Blue
                      Color.fromARGB(255, 111, 194, 208),
                      Color.fromARGB(255, 116, 240, 231), // Pastel Light Purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    final rawAmount = chargeAmountController.text
                        .replaceAll(RegExp(r'\D'), '');
                    final chargeAmount = int.tryParse(rawAmount) ?? 0;

                    if (paymentType.value.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select a payment method.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (chargeAmount < 50000 ||
                        chargeAmount % 10000 != 0 ||
                        chargeAmount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter a valid amount greater than 50.000.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors
                              .white, // Đặt màu nền của AlertDialog thành trắng
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Vòng tròn đếm ngược (3s)
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.orange),
                                    value: 0.8, // Tỉ lệ của vòng tròn đếm ngược
                                  ),
                                  Text(
                                    '3s',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Tiêu đề
                              const Text(
                                'Xác nhận đặt đơn',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Bạn ơi, hãy kiểm tra thông tin lần nữa nhé!',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Địa chỉ và thông tin người nhận
                              Text(packageOrderController.text),
                              Text(cccdController.text),
                              Text('Giá trị: ${chargeAmountController.text}'),
                              Text('Thanh toán: ${paymentType.value}'),
                              if (promoCodeController.text.isNotEmpty)
                                Text(
                                    'Mã khuyến mãi: ${promoCodeController.text}'),
                            ],
                          ),
                          actions: [
                            // Các nút hành động
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Chỉnh sửa'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Proceed with payment
                                    if (promoCodeController.text.isNotEmpty) {
                                      submit(
                                        context: context,
                                        formKey: formKey,
                                        ref: ref,
                                        packageOrderId:
                                            packageOrderController.text,
                                        chargeAmount: chargeAmount,
                                        cccdpassport: cccdController.text,
                                        paymentType: paymentType.value,
                                        promoCode: promoCodeController.text,
                                      );
                                    } else {
                                      submitWithoutPromotion(
                                        context: context,
                                        formKey: formKey,
                                        ref: ref,
                                        packageOrderId:
                                            packageOrderController.text,
                                        chargeAmount: chargeAmount,
                                        cccdPassport: cccdController.text,
                                        paymentType: paymentType.value,
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue, // Màu nền nút
                                  ),
                                  child: const Text('Đặt đơn ngay'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                  child: const Text('Proceed to Payment'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
