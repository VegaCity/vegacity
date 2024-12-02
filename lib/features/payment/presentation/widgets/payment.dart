import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PaymentOptionButton extends StatelessWidget {
  final BuildContext context;
  final ValueNotifier<String> paymentType;

  const PaymentOptionButton({
    Key? key,
    required this.context,
    required this.paymentType,
  }) : super(key: key);

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
}
