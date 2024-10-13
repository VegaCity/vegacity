import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:base/features/package/presentation/screens/package_screen/package_controller.dart';
import 'package:base/features/package/presentation/widgets/package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';
import 'package:base/features/test/domain/entities/house_entities.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base/features/test/presentation/screens/test_screen/test_controller.dart';
import 'package:base/features/test/presentation/widgets/show_bottom_ui_filter_example/custom_bottom_sheet.dart';
import 'package:base/features/test/presentation/widgets/test_item.dart';
import 'package:base/hooks/use_fetch.dart';
import 'package:base/models/request/paging_model.dart';
import 'package:base/utils/commons/functions/datetime_utils.dart';
import 'package:base/utils/commons/widgets/app_bar.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:base/utils/enums/enums_export.dart';
import 'package:base/utils/extensions/scroll_controller.dart';

final testDateFrom = StateProvider.autoDispose<String>(
  (ref) => getDateTimeNow(),
);

final testDateTo = StateProvider.autoDispose<String>(
  (ref) => getDateTimeNow(),
);

@RoutePage()
class PackageScreen extends HookConsumerWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Init
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final state = ref.watch(packageControllerProvider);

    // list
    print(ref.read(filterSystemStatus).type);
    final fetchReslut = useFetch<PackageEntities>(
      function: (model, context) => ref
          .read(packageControllerProvider.notifier)
          .getPackages(model, context),
      initialPagingModel: PagingModel(
          // ví dụ ở đây và trong widgetshowCustomButtom ở widget test floder luôn

          // filterContent: ref.read(filterSystemStatus).type
          // filterSystemContent: ref.read(filterSystemStatus).type,
          // filterContent: ref.read(filterPartnerStatus).type,
          // searchDateFrom: dateFrom,
          // searchDateTo: dateTo,
          ),
      context: context,
    );

    useEffect(() {
      scrollController.onScrollEndsListener(fetchReslut.loadMore);

      //  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   if (message.data['screen'] == OrderDetailScreenRoute.name) {
      //     fetchResult.refresh();
      //   }

      return scrollController.dispose;
    }, const []);

    // Hàm ở ref listen ở đây vinh tính đường binh khi thay đổi trong trang detail thì sẽ sử dụng  (TODO)

    // ref.listen<bool>(
    //   refreshTestList,
    //   (_, __) => fetchReslut.refresh(),
    // );
    // onCallBackSecond: () => {
    //   //show filter bottom or tom
    // },
    // onCallBackSecond: () => showCustomBottomSheet(
    //   context: context,
    //   size: size,
    //   onCallback: fetchReslut.refresh,
    // ),

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Package',
        iconFirst: Icons.refresh_rounded,
        backgroundColor: AssetsConstants.blue2,
        iconSecond: Icons.filter_list_alt,
        onCallBackFirst: fetchReslut.refresh,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            (state.isLoading && fetchReslut.items.isEmpty)
                ? const Center(
                    child: HomeShimmer(amount: 4),
                  )
                : fetchReslut.items.isEmpty
                    ? const Align(
                        alignment: Alignment.topCenter,
                        child: EmptyBox(title: 'list ko có dữ liệu'),
                      )
                    : Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: GridView.builder(
                                  itemCount: fetchReslut.items.length,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  controller: scrollController,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        AssetsConstants.defaultPadding - 5.0,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemBuilder: (_, index) {
                                    return PackageItem(
                                      package: fetchReslut.items[index],
                                      onCallback: fetchReslut.refresh,
                                    );
                                  },
                                ),
                              ),
                              if (fetchReslut.isLastPage) ...[
                                const NoMoreContent(),
                                const SizedBox(
                                    height:
                                        20.0), // khoảng cách dưới cùng nếu cần
                              ] else if (fetchReslut.isFetchingData) ...[
                                const CustomCircular(),
                              ],
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
