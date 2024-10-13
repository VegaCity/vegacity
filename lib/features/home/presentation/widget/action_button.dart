import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_application_1/View/dasboard/statistics_screen.dart';
// import 'package:flutter_application_1/View/map/map_screen.dart';
// import 'package:flutter_application_1/View/transfer/transfer_screen.dart';
// import 'package:flutter_application_1/View/e_tag/checking_e_tag.dart';
// import 'package:flutter_application_1/View/zone/zone_map.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  void _showUnderDevelopmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Tính năng đang phát triển'),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.2,
              blurRadius: 2,
              offset: const Offset(0, 0.2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButtonWithLabel(
              icon: Icon(Icons.credit_card),
              label: 'E-tag',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const CheckUserCardScreen()),
                // );
              },
            ),
            IconButtonWithLabel(
              icon:
                  FaIcon(FontAwesomeIcons.moneyBillTransfer), // Sử dụng FaIcon
              label: 'Transfer',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TransferScreen()),
                // );
              },
            ),
            IconButtonWithLabel(
              icon: Icon(Icons.map_outlined),
              label: 'Map',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ZoneScreen()),
                // );
              },
            ),
            IconButtonWithLabel(
              icon: Icon(Icons.bar_chart),
              label: 'Dashboard',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => StatisticsScreen()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class IconButtonWithLabel extends StatelessWidget {
  const IconButtonWithLabel({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final Widget icon; // Duy trì kiểu Widget để hỗ trợ FaIcon và Icon
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 50, // Kích thước vòng tròn
            height: 50, // Kích thước vòng tròn
            alignment: Alignment.center,
            child: icon, // Hiển thị biểu tượng (có thể là Icon hoặc FaIcon)
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
