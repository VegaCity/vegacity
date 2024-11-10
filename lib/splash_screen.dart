import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:base/utils/constants/asset_constant.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Timer(
      const Duration(seconds: 4),
      () {},
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
               AssetsConstants.spashImage,
            width: 500,
            height: 500,
          ),
        ),
      ),
    );
  }
}






// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:movemate/utils/constants/asset_constant.dart';
// import 'package:movemate/configs/routes/app_router.dart'; // Đảm bảo import này đúng

// @RoutePage()
// class SplashScreen extends HookConsumerWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final animationController = useAnimationController(
//       duration: const Duration(milliseconds: 2000),
//     );

//     final opacityAnimation = useAnimation(
//       Tween<double>(begin: 1.0, end: 0.0).animate(animationController),
//     );

//     useEffect(() {
//       Future.delayed(const Duration(seconds: 2), () {
//         animationController.forward().then((_) {
//           ref.watch(appRouterProvider).config();
//         });
//       });
//       return animationController.dispose;
//     }, []);

//     return Scaffold(
//       body: Opacity(
//         opacity: opacityAnimation,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Image.asset(
//               AssetsConstants.spashImage,
//               fit: BoxFit.cover,
//             ),
//             Center(
//               child: Container(
//                 width: 350,
//                 height: 600,
//                 decoration: BoxDecoration(
//                   color: AssetsConstants.primaryMain,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       AssetsConstants.spashLogo,
//                       width: 60,
//                       height: 60,
//                     ),
//                     const SizedBox(width: 10),
//                     const Text(
//                       AssetsConstants.appTitle,
//                       style: AssetsConstants.appFont,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
