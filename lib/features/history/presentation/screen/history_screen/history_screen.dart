import 'package:animate_do/animate_do.dart';
import 'package:base/features/history/domain/entities/history_entity.dart';
import 'package:base/features/history/presentation/screen/history_screen/history_controller.dart';
import 'package:base/features/history/presentation/widgets/order_item.dart';
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

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

@RoutePage()
class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final state = ref.watch(historyControllerProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final fetchReslut = useFetch<HistoryEntity>(
      function: (model, context) => ref
          .read(historyControllerProvider.notifier)
          .getHistory(model, context),
      initialPagingModel: PagingModel(),
      context: context,
    );

    useEffect(() {
      scrollController.onScrollEndsListener(fetchReslut.loadMore);
      return scrollController.dispose;
    }, const []);

    // Lọc danh sách gói dịch vụ dựa trên từ khóa tìm kiếm
    final filteredItems = fetchReslut.items.where((item) {
      final formattedDate = DateTimeUtils.formatDate(item.crDate);
      return formattedDate.contains(searchQuery);
    }).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(200), // Chiều cao tùy chỉnh cho AppBar
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0052CC), // Blue
                Color(0xFF00AAFF), // Light Blue
                Color.fromARGB(255, 111, 194, 208),
                Color.fromARGB(255, 116, 240, 231), // Pastel Light Purple
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent, // AppBar trong suốt
                elevation: 0,
                centerTitle: true,
                title: FadeInDown(
                  child: const Text(
                    'History',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    // Thanh tìm kiếm
                    FadeInLeft(
                      child: TextField(
                        onChanged: (value) {
                          ref.read(searchQueryProvider.notifier).state =
                              value; // Cập nhật từ khóa tìm kiếm
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Tìm kiếm gói dịch vụ...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeInUp(
                      child: const Text(
                        'Tổng hợp các gói dịch vụ trong Vegacity',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 8.0),
        child: Column(
          children: [
            // SizedBox(height: size.height * 0.02),
            (state.isLoading && fetchReslut.items.isEmpty)
                ? const Center(child: HomeShimmer(amount: 4))
                : filteredItems.isEmpty
                    ? const Align(
                        alignment: Alignment.topCenter,
                        child: EmptyBox(title: 'Không có dữ liệu'),
                      )
                    : Expanded(
                        child: GridView.builder(
                          itemCount: filteredItems
                              .length, // Sử dụng số lượng gói đã lọc
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AssetsConstants.defaultPadding - 5.0,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 5,
                          ),
                          itemBuilder: (_, index) {
                            return OrderItem(
                              history: filteredItems[index], // Gói đã lọc
                              onCallback: fetchReslut.refresh,
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class DateTimeUtils {
  static String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
