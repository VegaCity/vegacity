import 'package:base/features/home/presentation/widget/action_button.dart';

import 'dart:async';

import 'package:base/features/package/domain/entities/packages_entities.dart';
import 'package:base/features/package/presentation/screens/package_screen/package_controller.dart';
import 'package:base/features/home/presentation/widget/home_item.dart';
import 'package:base/features/profile/domain/entities/profile_entity.dart';
import 'package:base/features/profile/presentation/screens/profile_screen/profile_controller.dart';
import 'package:base/hooks/use_fetch.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:base/models/request/paging_model.dart';
import 'package:base/utils/commons/widgets/custom_circular.dart';
import 'package:base/utils/commons/widgets/no_more_content.dart';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:base/features/home/presentation/widget/action_button.dart';
import 'package:base/utils/constants/asset_constant.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final scrollController = useScrollController();
    final state = ref.watch(packageControllerProvider);
    final Name = ref.watch(profileControllerProvider);

    // get package
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
    //get user id
    final useFetchResult = useFetchObject<ProfileEntity>(
      function: (context) =>
          ref.read(profileControllerProvider.notifier).getUser(context),
      context: context,
    );
    if (useFetchResult.isFetchingData) {
      return const Center(
          child: CircularProgressIndicator()); // Hiển thị vòng tròn loading
    }

    // Kiểm tra xem dữ liệu có tồn tại hay không
    if (useFetchResult.data == null) {
      return const Center(
          child: Text('No data found')); // Thông báo không có dữ liệu
    }
    final user = useFetchResult.data!.user;

    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
    ];

    // Declare _currentPage state variable
    final _currentPage = useState(0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/Logo.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome Back!",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            '${user.fullName}'.split(' ').last,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              // Carousel Slider
              // Center(
              //   child: Column(
              //     children: [
              //     itemCount: imgList.length,
              //     onPageChanged: (index) {
              //       _currentPage.value = index;
              //     },
              //     itemBuilder: (context, index) {
              //       return Container(
              //         margin: const EdgeInsets.symmetric(horizontal: 10),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Colors.black, // Màu viền đen đậm
              //             width: 3, // Độ dày viền
              //           ),
              //           borderRadius: BorderRadius.circular(10), // Bo tròn viền
              //         ),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(10),
              //           child: Padding(
              //             padding: const EdgeInsets.all(
              //                 12.0), // Khoảng cách giữa ảnh và viền
              //             child: Image.network(
              //               imgList[index],
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(height: 30),
              //       buildCarouselIndicator(imgList.length, _currentPage.value),
              //   ),
              // ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Column(
                      children: [
                        ActionButtons(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
              // Tiêu đề Packages
              Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Packages new",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           EntryPoint(selectedIndex: 1)),
                        // );
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // Grid of Cards
              Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, left: 12, right: 12, bottom: 10),
                  child: GridView.builder(
                    itemCount: fetchReslut.items.length, // Giữ lại dòng này
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AssetsConstants.defaultPadding - 5.0,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Số cột
                      crossAxisSpacing: 8, // Khoảng cách giữa các cột
                      mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                      childAspectRatio: 1, // Tỷ lệ khung hình
                    ),
                    itemBuilder: (context, index) {
                      return HomeItem(
                        package: fetchReslut.items[index],
                        onCallback: fetchReslut.refresh,
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCard(String title, String imageUrl) {
  return Container(
    width: 160,
    height: 160,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
