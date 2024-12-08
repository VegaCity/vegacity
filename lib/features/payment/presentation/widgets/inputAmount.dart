// lib/widgets/amount_input_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base/utils/commons/widgets/loading_overlay.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class AmountInputSection extends StatelessWidget {
  final TextEditingController chargeAmountController;

  const AmountInputSection({super.key, required this.chargeAmountController});

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
