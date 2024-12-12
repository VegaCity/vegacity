import 'package:base/configs/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
      ),
      child: Container(
        width: 308,
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
              imagePath: 'assets/images/id-card.png',
              label: 'Vcard',
              onPressed: () {
                context.router.push(const CardScreenRoute());
              },
            ),
            IconButtonWithLabel(
              imagePath: 'assets/images/cash-back.png',
              label: 'Transfer',
              onPressed: () {
                // showAboutDialog(context: context);
                context.router.push(const TransferScreenRoute());
              },
            ),
            IconButtonWithLabel(
              imagePath: 'assets/images/map.png',
              label: 'Map',
              onPressed: () {
                _showUnderDevelopmentDialog(context);
              },
            ),
            IconButtonWithLabel(
              imagePath: 'assets/images/voucher.png',
              label: 'Promotion',
              onPressed: () {
                _showUnderDevelopmentDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUnderDevelopmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Đặt nền trắng cho AlertDialog
          title: const Text(
            'Notification',
            style: TextStyle(color: Colors.black), // Màu chữ tiêu đề
          ),
          content: const Text(
            'feature in development',
            style: TextStyle(color: Colors.black87), // Màu chữ nội dung
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.blue), // Màu chữ nút Đóng
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class IconButtonWithLabel extends StatefulWidget {
  const IconButtonWithLabel({
    super.key,
    required this.imagePath,
    required this.label,
    this.onPressed,
  });

  final String imagePath;
  final String label;
  final void Function()? onPressed;

  @override
  State<IconButtonWithLabel> createState() => _IconButtonWithLabelState();
}

class _IconButtonWithLabelState extends State<IconButtonWithLabel> {
  bool _isPressed = false;

  void _handleTap() async {
    setState(() {
      _isPressed = true; // Đổi sang màu xanh khi nhấn.
    });

    // Thực thi hành động (ví dụ: điều hướng hoặc thông báo).
    if (widget.onPressed != null) {
      widget.onPressed!();
    }

    // Đặt lại màu sau khi điều hướng hoặc quay lại trang.
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() {
        _isPressed = false; // Quay lại màu đen mặc định.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _handleTap,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  _isPressed ? Colors.blue : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
