import 'package:animate_do/animate_do.dart';
import 'package:base/features/history/domain/entities/transaction_entity.dart';
import 'package:base/features/history/presentation/screen/controller/transaction_controller.dart';
import 'package:base/features/history/presentation/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base/hooks/use_fetch.dart';
import 'package:base/models/request/paging_model.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/scroll_controller.dart';
import 'package:intl/intl.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

@RoutePage()
class HistoryScreen extends HookConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final state = ref.watch(transactionControllerProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final fetchReslut = useFetch<TransactionEntity>(
      function: (model, context) => ref
          .read(transactionControllerProvider.notifier)
          .getTransaction(model, context),
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

    // Nhóm các mục theo tháng và năm
    final groupedHistory = _groupHistoryByMonthYear(filteredItems);

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
                          hintText: 'Search for transaction...',
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
                        'Summary of payment history at Vegacity',
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
        padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
        child: Column(
          children: [
            (state.isLoading && fetchReslut.items.isEmpty)
                ? const Center(child: HomeShimmer(amount: 4))
                : filteredItems.isEmpty
                    ? const Align(
                        alignment: Alignment.topCenter,
                        child: EmptyBox(title: 'Không có dữ liệu'),
                      )
                    : Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: groupedHistory.length,
                          itemBuilder: (context, index) {
                            final monthYear =
                                groupedHistory.keys.elementAt(index);
                            final items = groupedHistory[monthYear]!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Tiêu đề tháng năm nổi bật
                                FadeInLeft(
                                  child: Container(
                                    width: double.infinity,
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      monthYear,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                // Danh sách các mục trong tháng năm đó
                                ...items.map((transaction) => OrderItem(
                                      transaction: transaction,
                                      onCallback: fetchReslut.refresh,
                                    )),
                              ],
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Map<String, List<TransactionEntity>> _groupHistoryByMonthYear(
      List<TransactionEntity> historyList) {
    final Map<String, List<TransactionEntity>> groupedHistory = {};

    for (var history in historyList) {
      final monthYear = DateFormat('MMMM yyyy').format(history.crDate);
      if (!groupedHistory.containsKey(monthYear)) {
        groupedHistory[monthYear] = [];
      }
      groupedHistory[monthYear]!.add(history);
    }

    return groupedHistory;
  }
}

class DateTimeUtils {
  static String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
