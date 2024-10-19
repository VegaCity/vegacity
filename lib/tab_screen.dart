import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'configs/routes/app_router.dart';
import 'utils/commons/widgets/bottom_bar.dart';
import 'utils/commons/widgets/loading_overlay.dart';
import 'utils/providers/common_provider.dart';

final GlobalKey<ScaffoldState> autoTabsScaffoldKey = GlobalKey<ScaffoldState>();

@RoutePage()
class TabViewScreen extends ConsumerWidget {
  const TabViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(modifyProfiver);

    return LoadingOverlay(
      isLoading: state,
      child: AutoTabsScaffold(
        scaffoldKey: autoTabsScaffoldKey,
        routes: const [
          HomeScreenRoute(),
          PackageScreenRoute(),
          ScannerScreenRoute(),
          HistoryScreenRoute(),
          ProfileScreenRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          // Kiểm tra xem trang hiện tại có phải là ScannerScreen không
          final isScannerScreen = tabsRouter.activeIndex == 2;

          // Ẩn BottomBar nếu là ScannerScreen
          return isScannerScreen
              ? const SizedBox.shrink() // Trả về widget trống
              : CustomBottomBar(tabsRouter: tabsRouter);
        },
      ),
    );
  }
}
