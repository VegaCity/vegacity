import 'package:animate_do/animate_do.dart';
import 'package:base/features/payment/presentation/screen/controller/orderV2_controller.dart';
import 'package:base/features/payment/presentation/screen/controller/order_controller.dart';
import 'package:base/features/promotion/presentation/screen/promotion_screen.dart';
import 'package:base/utils/commons/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    // final state1 = ref.watch(promotionControllerProvider);
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
              _buildDestinationSection(etagCodeController),
              const SizedBox(height: 20),
              _buildCccdSection(cccdController),
              const SizedBox(height: 20),
              _buildAmountInputSection(chargeAmountController),
              const SizedBox(height: 20),
              _buildPaymentOptionButton(context, paymentType),
              const SizedBox(height: 20),
              _buildPromoCodeInputSection(context, promoCodeController),
              const SizedBox(height: 20),
              _buildActionButtons(
                  context,
                  ref,
                  formKey,
                  etagCodeController,
                  chargeAmountController,
                  cccdController,
                  promoCodeController,
                  paymentType),
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

  Widget _buildDestinationSection(TextEditingController etagCodeController) {
    return Center(
      child: FadeInUp(
        child: SizedBox(
          width: 350,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: TextField(
                  controller: etagCodeController,
                  readOnly: true,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Nhập code vcard của bạn',
                    hintStyle: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    suffixIcon: Icon(
                      FontAwesomeIcons.idCard,
                      color: Color(0xFF007BFF),
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 2,
                child: FadeInDown(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: const Color(0xFFF0F4FF),
                    child: Text(
                      'Code Vcard',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodeInputSection(
      BuildContext context, TextEditingController promoCodeController) {
    return Center(
      child: FadeInUp(
        child: SizedBox(
          width: 350,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: TextField(
                      controller: promoCodeController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter your promo code',
                        hintStyle: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        suffixIcon: Icon(
                          FontAwesomeIcons.tag,
                          color: Color(0xFF007BFF),
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: const Color(0xFFF0F4FF),
                      child: FadeInDown(
                        child: Text(
                          'Promotion',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8), // Khoảng cách giữa ô input và dòng chữ
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Căn chữ sang bên trái
                children: [
                  GestureDetector(
                    onTap: () {
                      // Điều hướng sang trang khác khi nhấn vào dòng chữ
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const PromotionScreen()),
                      );
                    },
                    child: FadeInUp(
                      child: const Text(
                        'Promotion is currently in the system',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF007BFF),
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Color(0xFF007BFF), // Đặt màu cho gạch chân
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCccdSection(TextEditingController cccdController) {
    return Center(
      child: FadeInUp(
        child: SizedBox(
          width: 350,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: TextField(
                  controller: cccdController,
                  autofocus: true,
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Nhập số CCCD hoặc Passport',
                    hintStyle: TextStyle(
                      color: Color(0xFF999999),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    suffixIcon: Icon(
                      Icons.credit_card,
                      color: Color(0xFF007BFF),
                      size: 20,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: const Color(0xFFF0F4FF),
                  child: FadeInDown(
                    child: Text(
                      'CCCD/Passport',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInputSection(
      TextEditingController chargeAmountController) {
    return Center(
      child: FadeInUp(
        child: SizedBox(
          width: 350,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                ),
                child: TextFormField(
                  controller: chargeAmountController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    NumberWithCurrencyFormatter(),
                  ],
                  validator: (value) {
                    final rawAmount =
                        value?.replaceAll(RegExp(r'\D'), '') ?? '';
                    final chargeAmount = int.tryParse(rawAmount) ?? 0;
                    if (chargeAmount < 50000 || chargeAmount % 10000 != 0) {
                      return 'Please enter an amount of 50,000 VND or more in increments of 10,000 VND.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: '0 VND',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF007BFF),
                      fontSize: 24,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xFF007BFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                left: 10,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: const Color(0xFFF0F4FF),
                  child: FadeInDown(
                    child: Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptionButton(
      BuildContext context, ValueNotifier<String> paymentType) {
    return Center(
      child: FadeInUp(
        child: SizedBox(
          width: 350,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () => _showPaymentOptions(context, paymentType),
                  child: ValueListenableBuilder<String>(
                    valueListenable: paymentType,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value.isEmpty ? 'Select payment method' : value,
                            style: TextStyle(
                              color: value.isEmpty
                                  ? const Color(0xFF999999)
                                  : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          const Icon(
                            Icons.payment,
                            color: Color(0xFF007BFF),
                            size: 20,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: const Color(0xFFF0F4FF),
                  child: FadeInDown(
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentOptions(
      BuildContext context, ValueNotifier<String> paymentType) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              ListTile(
                title:
                    const Text('Momo', style: TextStyle(color: Colors.black)),
                onTap: () {
                  paymentType.value = 'Momo';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:
                    const Text('VnPay', style: TextStyle(color: Colors.black)),
                onTap: () {
                  paymentType.value = 'VnPay';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title:
                    const Text('PayOS', style: TextStyle(color: Colors.black)),
                onTap: () {
                  paymentType.value = 'PayOS';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('ZaloPay',
                    style: TextStyle(color: Colors.black)),
                onTap: () {
                  paymentType.value = 'ZaloPay';
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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

                    if (promoCodeController.text.isNotEmpty) {
                      submit(
                        context: context,
                        formKey: formKey,
                        ref: ref,
                        packageOrderId: packageOrderController.text,
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
                        packageOrderId: packageOrderController.text,
                        chargeAmount: chargeAmount,
                        cccdPassport: cccdController.text,
                        paymentType: paymentType.value,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent, // Xóa bỏ bóng mờ
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NumberWithCurrencyFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (cleanedText.isEmpty) return newValue.copyWith(text: '');

    final int? value = int.tryParse(cleanedText);
    if (value == null) return oldValue;

    final newText = _formatter.format(value);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
