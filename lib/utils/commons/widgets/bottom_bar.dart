import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../configs/routes/app_router.dart';
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

    return CupertinoTabBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      height: size.height * 0.1,
      backgroundColor: AssetsConstants.whiteColor,
      items: [
        buildBottomNavigationBarItem(
          icon: Icons.home_outlined,
          label: 'Home',
          index: 0,
          activeIndex: tabsRouter.activeIndex,
          size: size,
        ),
        buildBottomNavigationBarItem(
          icon: Icons.star_border,
          label: 'Package',
          index: 1,
          activeIndex: tabsRouter.activeIndex,
          size: size,
        ),
        buildBottomNavigationBarItem(
          icon: Icons.qr_code_outlined,
          label: 'QR Code',
          index: 2,
          activeIndex: tabsRouter.activeIndex,
          size: size,
        ),
        buildBottomNavigationBarItem(
          icon: Icons.timer_outlined,
          label: 'History',
          index: 3,
          activeIndex: tabsRouter.activeIndex,
          size: size,
        ),
        buildBottomNavigationBarItem(
          icon: Icons.person_outline,
          label: 'Profile',
          index: 4,
          activeIndex: tabsRouter.activeIndex,
          size: size,
        ),
      ],
    );
  }

  // Helper method to build a navigation bar item with animation
  BottomNavigationBarItem buildBottomNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
    required int activeIndex,
    required Size size,
  }) {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTap: () => tabsRouter.setActiveIndex(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBar(isActive: activeIndex == index),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: size.width * 0.08,
              width: size.width * 0.09,
              child: Icon(
                icon,
                size: AssetsConstants.defaultFontSize - 2.0,
                color:
                    activeIndex == index ? AssetsConstants.blue2 : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: activeIndex == index
                    ? const Color.fromARGB(255, 30, 144, 255)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
      label: '', // Don't need label in CupertinoTabBar, added manually above
    );
  }
}

// AnimatedBar used for the bottom indicator bar
class AnimatedBar extends StatelessWidget {
  const AnimatedBar({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: isActive ? const Color.fromARGB(255, 30, 144, 255) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
