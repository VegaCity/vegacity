
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../constants/asset_constant.dart';

class CustomBottomBar extends HookWidget {
  const CustomBottomBar({
    super.key,
    required this.tabsRouter,
  });
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        Container(
          height: size.height * 0.09,
          decoration: BoxDecoration(
            color: AssetsConstants.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Left side items
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      icon: Icons.home_outlined,
                      label: 'Home',
                      index: 0,
                      size: size,
                    ),
                    _buildNavItem(
                      icon: Icons.star_border,
                      label: 'Package',
                      index: 1,
                      size: size,
                    ),
                  ],
                ),
              ),
              // Space for center button
              SizedBox(width: size.width * 0.2),
              // Right side items
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(
                      icon: Icons.timer_outlined,
                      label: 'History',
                      index: 3,
                      size: size,
                    ),
                    _buildNavItem(
                      icon: Icons.person_outline,
                      label: 'Profile',
                      index: 4,
                      size: size,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Center QR Scan Button
        Positioned(
          top: 10,
          left: (size.width - 55) / 2, // Căn giữa bằng cách tính toán thủ công
          child: GestureDetector(
            onTap: () => tabsRouter.setActiveIndex(2),
            child: SizedBox(
              width: 55, // Chiều rộng nhỏ hơn
              height: 55, // Chiều cao nhỏ hơn
              child: CustomPaint(
                painter: DashedBorderPainter(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8), // Bo góc nhẹ
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code_outlined,
                      color: AssetsConstants.blue2,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Size size,
  }) {
    final isActive = tabsRouter.activeIndex == index;

    return GestureDetector(
      onTap: () => tabsRouter.setActiveIndex(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated indicator bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 2),
              height: 4,
              width: isActive ? 20 : 0,
              decoration: BoxDecoration(
                color: isActive ? AssetsConstants.blue2 : Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
            const SizedBox(height: 2),
            // Icon
            Icon(
              icon,
              color: isActive ? AssetsConstants.blue2 : Colors.grey,
              size: AssetsConstants.defaultFontSize - 2.0,
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? AssetsConstants.blue2 : Colors.grey,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AssetsConstants.blue2
      ..strokeWidth = 4 // Độ dày viền tăng lên
      ..style = PaintingStyle.stroke;

    const double dashLength = 10;

    final Path path = Path();

    // Cạnh trên
    path.moveTo(0, 0);
    path.lineTo(size.width / 2 - dashLength / 2, 0);
    path.moveTo(size.width / 2 + dashLength / 2, 0);
    path.lineTo(size.width, 0);

    // Cạnh phải
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height / 2 - dashLength / 2);
    path.moveTo(size.width, size.height / 2 + dashLength / 2);
    path.lineTo(size.width, size.height);

    // Cạnh dưới
    path.moveTo(size.width, size.height);
    path.lineTo(size.width / 2 + dashLength / 2, size.height);
    path.moveTo(size.width / 2 - dashLength / 2, size.height);
    path.lineTo(0, size.height);

    // Cạnh trái
    path.moveTo(0, size.height);
    path.lineTo(0, size.height / 2 + dashLength / 2);
    path.moveTo(0, size.height / 2 - dashLength / 2);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
