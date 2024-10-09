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
class TestScreen extends HookConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Init
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final state = ref.watch(testControllerProvider);

    // list

    final fetchReslut = useFetch<HouseEntities>(
      function: (model, context) =>
          ref.read(testControllerProvider.notifier).getHouses(model, context),
      initialPagingModel: PagingModel(
          // ví dụ ở đây và trong widgetshowCustomButtom ở widget test floder luôn

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

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Package',
        iconFirst: Icons.refresh_rounded,
        backgroundColor: AssetsConstants.blue2,
        // iconSecond: Icons.filter_list_alt,
        onCallBackFirst: fetchReslut.refresh,
        // onCallBackSecond: () => {
        //   //show filter bottom or tom
        // },
      ),
      body: Column(
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
                        color: Colors.blue, // Thẻ màu xanh
                        child: ListView.builder(
                          itemCount: fetchReslut.items.length + 1,
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AssetsConstants.defaultPadding - 10.0,
                          ),
                          itemBuilder: (_, index) {
                            if (index == fetchReslut.items.length) {
                              if (fetchReslut.isFetchingData) {
                                return const CustomCircular();
                              }
                              return fetchReslut.isLastPage
                                  ? const NoMoreContent()
                                  : Container();
                            }
                            return TestItem(
                              test: fetchReslut.items[index],
                              onCallback: fetchReslut.refresh,
                            );
                          },
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
