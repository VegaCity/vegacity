import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Màu và độ mờ của bóng
              spreadRadius: 0.5, // Độ lan tỏa của bóng
              blurRadius: 3, // Độ mờ của bóng
              offset: const Offset(0, 0.5), // Độ lệch của bóng (x,y)
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
              icon: Icons.credit_card,
              label: 'E-tag',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const CheckUserCardScreen()),
                // );
              },
            ),
            ActionButton(
              icon: Icons.attach_money,
              label: 'Transfer',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => TransferScreen()),
                // );
              },
            ),
            ActionButton(
              icon: Icons.map_outlined,
              label: 'Map',
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ZoneScreen()),
                // );
              },
            ),
            ActionButton(
              icon: Icons.bar_chart,
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

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onPressed,
  });

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: const Color.fromARGB(255, 30, 144, 255),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
