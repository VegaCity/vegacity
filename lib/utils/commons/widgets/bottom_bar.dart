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
          height: size.height * 0.1,
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
          left: 0,
          right: 0,
          top: -size.height * 0,
          child: GestureDetector(
            onTap: () => tabsRouter.setActiveIndex(2),
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AssetsConstants.blue2,
                ),
                child: const Icon(
                  Icons.qr_code_outlined,
                  color: Colors.white,
                  size: 30,
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
