import 'package:animate_do/animate_do.dart';
import 'package:base/features/profile/domain/entities/wallet_entity.dart';
import 'package:base/features/profile/presentation/controller/wallet_controller.dart';
import 'package:base/features/profile/presentation/widgets/wallet_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:base/hooks/use_fetch.dart';
import 'package:base/models/request/paging_model.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/extensions/scroll_controller.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

@RoutePage()
class WalletScreen extends HookConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final state = ref.watch(walletControllerProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final fetchResult = useFetch<WalletEntity>(
      function: (model, context) =>
          ref.read(walletControllerProvider.notifier).getWallet(model, context),
      initialPagingModel: PagingModel(),
      context: context,
    );

    useEffect(() {
      scrollController.onScrollEndsListener(fetchResult.loadMore);
      return scrollController.dispose;
    }, const []);

    final filteredItems = fetchResult.items.where((item) {
      final formattedDate = DateTimeUtils.formatDate(item.dateCheck);
      return formattedDate.contains(searchQuery);
    }).toList();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 50,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0052CC),
                      Color(0xFF00AAFF),
                      Color.fromARGB(255, 111, 194, 208),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: FadeInDown(
                child: const Text(
                  'Wallet end day check',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              centerTitle: true,
            ),
          ),
          // Wallet List
          SliverPadding(
            padding: const EdgeInsets.only(top: 16),
            sliver: SliverToBoxAdapter(
              child: (state.isLoading && fetchResult.items.isEmpty)
                  ? const Center(child: HomeShimmer(amount: 4))
                  : filteredItems.isEmpty
                      ? const Align(
                          alignment: Alignment.topCenter,
                          child: EmptyBox(title: 'No data available'),
                        )
                      : Column(
                          children: filteredItems
                              .map((wallet) => WalletItem(
                                    wallet: wallet,
                                    onCallback: fetchResult.refresh,
                                  ))
                              .toList(),
                        ),
            ),
          ),
        ],
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
