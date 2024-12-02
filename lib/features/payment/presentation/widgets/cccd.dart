import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CccdSection extends StatelessWidget {
  final TextEditingController cccdController;

  const CccdSection({
    Key? key,
    required this.cccdController,
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
}
