import 'dart:ffi';
import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/payment/presentation/screen/order_controller.dart';
import 'package:base/features/payment/presentation/screen/wallet_controller.dart';
import 'package:base/features/profile/domain/entities/wallet_entity.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:base/utils/commons/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class TransferScreen extends HookConsumerWidget {
  const TransferScreen({super.key});

  void submit({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String etagCode,
    required int chargeAmount,
    required String cccd,
    required String paymentType,
  }) async {
    await ref.read(orderControllerProvider.notifier).order(
          etagCode: etagCode,
          chargeAmount: chargeAmount,
          cccd: cccd,
          paymentType: paymentType,
          context: context,
        );
    print("Submit thành công");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderControllerProvider);
    final cccdController = useTextEditingController();
    final etagCodeController = useTextEditingController();
    final chargeAmountController = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final paymentType = useState<String>("");

    // final useFetchResult = useFetchObject<WalletEntity>(
    //   function: (context) =>
    //       ref.read(walletControllerProvider.notifier).getWallet(context),
    //   context: context,
    // );

    // final wallet = useFetchResult.data?.balance;
    // final wallet2 = useFetchResult.data?.crDate;
    // print("Wallet: $wallet");
    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4FF),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Chuyển tiền tới số tài khoản',
                  style: TextStyle(fontSize: 18, color: Color(0xFF007BFF)),
                ),
              ),
              const SizedBox(height: 20),
              _buildSourceAccountSection(),
              const SizedBox(height: 20),
              _buildDestinationSection(etagCodeController),
              const SizedBox(height: 20),
              _buildCccdSection(cccdController),
              const SizedBox(height: 20),
              _buildAmountInputSection(chargeAmountController),
              const SizedBox(height: 20),
              _buildPaymentOptionButton(
                  context, paymentType), // Nút mở bottom sheet

              const SizedBox(height: 20),
              _buildActionButtons(context, ref, formKey, etagCodeController,
                  chargeAmountController, cccdController, paymentType),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSourceAccountSection() {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F4FF),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TÀI KHOẢN THANH TOÁN - 1290197042292',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '20000 VND',
              style: TextStyle(color: Color(0xFF007BFF)),
            ),
          ],
        ),
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
          decoration: InputDecoration(
            hintText: 'Mã eTag',
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            suffixIcon:
                const Icon(FontAwesomeIcons.idCard, color: Color(0xFF007BFF)),
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
        child: TextField(
          controller: chargeAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NumberWithCurrencyFormatter(),
          ],
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
            hintText: 'Nhập CCCD',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintStyle: TextStyle(color: Colors.grey),
          ),
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
          border: Border.all(
              color: Colors.grey.withOpacity(0.3)), // Sử dụng độ trong suốt
          // Đường viền
          borderRadius: BorderRadius.circular(8.0), // Bo tròn góc
        ),
        child: GestureDetector(
          onTap: () => _showPaymentOptions(context, paymentType),
          child: ValueListenableBuilder<String>(
            valueListenable: paymentType,
            builder: (context, value, child) {
              return Text(
                value.isEmpty
                    ? 'Vui lòng chọn phương thức thanh toán'
                    : value, // Hiện phương thức đã chọn hoặc thông báo
                style: TextStyle(
                  color: value.isEmpty ? Colors.grey : Colors.black,
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
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              ListTile(
                title: const Text('Momo'),
                onTap: () {
                  paymentType.value = 'Momo';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('VnPay'),
                onTap: () {
                  paymentType.value = 'VnPay';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('PayOS'),
                onTap: () {
                  paymentType.value = 'PayOS';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('ZaloPay'),
                onTap: () {
                  paymentType.value = 'ZaloPay';
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cash'),
                onTap: () {
                  paymentType.value = 'Cash';
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
    TextEditingController etagCodeController,
    TextEditingController chargeAmountController,
    TextEditingController cccdController,
    ValueNotifier<String> paymentType,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Quay lại'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            final rawAmount =
                chargeAmountController.text.replaceAll(RegExp(r'\D'), '');
            final chargeAmount = int.tryParse(rawAmount) ?? 0;
            submit(
              context: context,
              formKey: formKey,
              ref: ref,
              etagCode: etagCodeController.text,
              chargeAmount: chargeAmount ?? 0,
              cccd: cccdController.text,
              paymentType: paymentType.value,
            );
            // context.router.push(const TransferSuccessRoute());
          },
          child: const Text('Tiếp tục'),
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
