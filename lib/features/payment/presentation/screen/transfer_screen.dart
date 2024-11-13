import 'package:animate_do/animate_do.dart';
import 'package:base/features/payment/presentation/screen/controller/orderV2_controller.dart';
import 'package:base/features/payment/presentation/screen/controller/order_controller.dart';
import 'package:base/features/promotion/presentation/controller/promotion_controller.dart';
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
    required String packageItemId,
    required int chargeAmount,
    required String cccdPassport,
    required String paymentType,
    required String promoCode,
  }) async {
    await ref.read(orderControllerProvider.notifier).order(
          packageItemId: packageItemId,
          chargeAmount: chargeAmount,
          cccdPassport: cccdPassport,
          paymentType: paymentType,
          promoCode: promoCode,
          context: context,
        );
    print("Submit thành công");
  }

  void submitWithoutPromotion({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String packageItemId,
    required int chargeAmount,
    required String cccdPassport,
    required String paymentType,
  }) async {
    await ref.read(orderv2ControllerProvider.notifier).orderv2(
          packageItemId: packageItemId,
          chargeAmount: chargeAmount,
          cccdPassport: cccdPassport,
          paymentType: paymentType,
          context: context,
        );
    print("Submit thành công");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider);
    final state1 = ref.watch(promotionControllerProvider);
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
          padding: const EdgeInsets.only(top: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
              ),
              _buildTitleSection(),
              const SizedBox(height: 20),
              _buildDestinationSection(etagCodeController),
              const SizedBox(height: 20),
              _buildCccdSection(cccdController),
              const SizedBox(height: 20),
              _buildAmountInputSection(chargeAmountController),
              const SizedBox(height: 20),
              _buildPromoCodeInputSection(promoCodeController),
              const SizedBox(height: 20),
              _buildPaymentOptionButton(context, paymentType),
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
    final savedCccd = prefs.getString('cccdPassport') ?? '';
    final savedPromoCode = prefs.getString('promotionCode') ?? '';

    etagCodeController.text = savedEtagCode;
    cccdController.text = savedCccd;
    promoCodeController.text = savedPromoCode;
  }

  Widget _buildTitleSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.idCard, color: Color(0xFF007BFF)),
          SizedBox(width: 8),
          Text(
            'Card ID',
            style: TextStyle(fontSize: 16, color: Color(0xFF007BFF)),
          ),
          Spacer(),
          Icon(FontAwesomeIcons.passport, color: Color(0xFF007BFF)),
          SizedBox(width: 8),
          Text(
            'CCCD/Passport',
            style: TextStyle(fontSize: 16, color: Color(0xFF007BFF)),
          ),
          Spacer(),
          Icon(FontAwesomeIcons.moneyBillAlt, color: Color(0xFF007BFF)),
          SizedBox(width: 8),
          Text(
            'Charge Money',
            style: TextStyle(fontSize: 16, color: Color(0xFF007BFF)),
          ),
          Spacer(),
          Icon(FontAwesomeIcons.tag, color: Color(0xFF007BFF)),
          SizedBox(width: 8),
          Text(
            'Promotion',
            style: TextStyle(fontSize: 16, color: Color(0xFF007BFF)),
          ),
          Spacer(),
          Icon(FontAwesomeIcons.moneyBillAlt, color: Color(0xFF007BFF)),
          SizedBox(width: 8),
          Text(
            'Payment Method',
            style: TextStyle(fontSize: 16, color: Color(0xFF007BFF)),
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationSection(TextEditingController etagCodeController) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: TextField(
          controller: etagCodeController,
          decoration: const InputDecoration(
            hintText: 'Code Vcard',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            suffixIcon: Icon(FontAwesomeIcons.idCard, color: Color(0xFF007BFF)),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodeInputSection(
      TextEditingController promoCodeController) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: TextField(
          controller: promoCodeController,
          decoration: const InputDecoration(
            hintText: 'Enter promo code',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            suffixIcon: Icon(FontAwesomeIcons.tag, color: Color(0xFF007BFF)),
          ),
        ),
      ),
    );
  }

  Widget _buildCccdSection(TextEditingController cccdController) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: TextField(
          controller: cccdController,
          decoration: const InputDecoration(
            hintText: 'Input CCCD/Passporrt',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountInputSection(
      TextEditingController chargeAmountController) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: TextFormField(
          controller: chargeAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumberWithCurrencyFormatter(),
          ],
          validator: (value) {
            final rawAmount = value?.replaceAll(RegExp(r'\D'), '') ?? '';
            final chargeAmount = int.tryParse(rawAmount) ?? 0;
            if (chargeAmount < 50000 || chargeAmount % 10000 != 0) {
              return 'Please enter an amount of 50,000 VND or more in increments of 10,000 VND.';
            }
            return null;
          },
          decoration: const InputDecoration(
            hintText: '0 VND',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            hintStyle: TextStyle(color: Color(0xFF007BFF)),
          ),
          style: const TextStyle(fontSize: 24, color: Color(0xFF007BFF)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPaymentOptionButton(
      BuildContext context, ValueNotifier<String> paymentType) {
    return Center(
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: GestureDetector(
          onTap: () => _showPaymentOptions(context, paymentType),
          child: ValueListenableBuilder<String>(
            valueListenable: paymentType,
            builder: (context, value, child) {
              return Text(
                value.isEmpty ? 'Please select payment method' : value,
                style: const TextStyle(
                  // color: value.isEmpty ? Colors.grey : Colors.black,
                  color: Colors.black,
                  fontSize: 16,
                ),
              );
            },
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
    TextEditingController packageItemController,
    TextEditingController chargeAmountController,
    TextEditingController cccdController,
    TextEditingController promoCodeController,
    ValueNotifier<String> paymentType,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            final rawAmount =
                chargeAmountController.text.replaceAll(RegExp(r'\D'), '');
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
                packageItemId: packageItemController.text,
                chargeAmount: chargeAmount,
                cccdPassport: cccdController.text,
                paymentType: paymentType.value,
                promoCode: promoCodeController.text,
              );
            } else {
              submitWithoutPromotion(
                context: context,
                formKey: formKey,
                ref: ref,
                packageItemId: packageItemController.text,
                chargeAmount: chargeAmount,
                cccdPassport: cccdController.text,
                paymentType: paymentType.value,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Màu nền nút "Tiếp tục"
            foregroundColor: Colors.white, // Màu chữ
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Bo tròn
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10), // Padding tùy chỉnh
          ),
          child: const Text('Continue'),
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
