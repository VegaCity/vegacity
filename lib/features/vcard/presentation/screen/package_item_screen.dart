import 'package:base/features/vcard/domain/entities/packageItem_entity.dart';
import 'package:base/features/vcard/presentation/screen/package_item_controller.dart';
import 'package:base/features/vcard/presentation/widget/package_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:auto_route/auto_route.dart';

import 'package:base/hooks/use_fetch.dart';
import 'package:base/models/request/paging_model.dart';

import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/constants/asset_constant.dart';

final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');

@RoutePage()
class CardScreen extends HookConsumerWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final state = ref.watch(packageItemControllerProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    final fetchResult = useFetch<PackageItemEntities>(
      function: (model, context) => ref
          .read(packageItemControllerProvider.notifier)
          .getCard(model, context),
      initialPagingModel: PagingModel(),
      context: context,
    );

    // Lọc danh sách gói dịch vụ dựa trên từ khóa tìm kiếm
    final filteredItems = fetchResult.items.where((item) {
      // final birthdayStr =
      //     item.birthday.toString();

      return (item.cccdpassport.toString() ==
              searchQuery) || // Kiểm tra nếu cccd bằng searchQuery
          (item.phoneNumber.toString() == searchQuery) ||
          (item.packageId.toString() ==
              searchQuery); // Kiểm tra nếu etagCode bằng searchQuery
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
                title: const Text(
                  'VCARD',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    // Thanh tìm kiếm
                    TextField(
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
                    const SizedBox(height: 8),
                    const Text(
                      'Tổng hợp các gói dịch vụ trong Vegacity',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          children: [
            // Chỉ hiển thị khi có từ khóa tìm kiếm
            if (searchQuery.isNotEmpty)
              Expanded(
                child: (state.isLoading && fetchResult.items.isEmpty)
                    ? const Center(child: HomeShimmer(amount: 4))
                    : filteredItems.isEmpty
                        ? const Align(
                            alignment: Alignment.topCenter,
                            child: EmptyBox(title: 'Không có dữ liệu'),
                          )
                        : GridView.builder(
                            itemCount: filteredItems
                                .length, // Sử dụng số lượng gói đã lọc
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: scrollController,
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    AssetsConstants.defaultPadding - 5.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 3,
                            ),
                            itemBuilder: (_, index) {
                              return PackageItem(
                                card: filteredItems[index], // Gói đã lọc
                                onCallback: fetchResult.refresh,
                              );
                            },
                          ),
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child:
                    Center(child: Text('Nhập từ khóa để tìm kiếm gói dịch vụ')),
              ),
          ],
        ),
      ),
    );
  }
}
