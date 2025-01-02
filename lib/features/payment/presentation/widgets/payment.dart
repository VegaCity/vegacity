import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PaymentOptionButton extends StatelessWidget {
  final BuildContext context;
  final ValueNotifier<String> paymentType;

  const PaymentOptionButton({
    super.key,
    required this.context,
    required this.paymentType,
  });

  @override
  Widget build(BuildContext context) {
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
                  onTap: () => _showPaymentOptions(context),
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

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                _buildPaymentOption(
                  context,
                  'Momo',
                  'assets/images/momo.png', // Path to Momo icon
                ),
                _buildPaymentOption(
                  context,
                  'VnPay',
                  'assets/images/vnpay.png', // Path to VnPay icon
                ),
                _buildPaymentOption(
                  context,
                  'PayOS',
                  'assets/images/payos.png', // Path to PayOS icon
                ),
                _buildPaymentOption(
                  context,
                  'ZaloPay',
                  'assets/images/zalopay.png', // Path to ZaloPay icon
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentOption(
      BuildContext context, String name, String iconPath) {
    return ListTile(
      leading: Image.asset(
        iconPath,
        width: 40,
        height: 40,
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.black),
      ),
      onTap: () {
        paymentType.value = name;
        Navigator.pop(context);
      },
    );
  }
}
