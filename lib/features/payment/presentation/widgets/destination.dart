import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DestinationSection extends StatelessWidget {
  final TextEditingController etagCodeController;

  const DestinationSection({
    super.key,
    required this.etagCodeController,
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
}
