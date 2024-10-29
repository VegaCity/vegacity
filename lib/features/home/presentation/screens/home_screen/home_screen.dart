import 'package:animate_do/animate_do.dart';
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// import 'package:carousel_slider/carousel_slider.dart';

import 'package:base/features/home/presentation/widget/action_button.dart';
import 'package:base/utils/constants/asset_constant.dart';

import 'package:base/features/home/presentation/widget/action_button.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

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

    final _animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true); // Lặp lại hiệu ứng nhấp nháy

    final _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    final List<String> imgList = [
      'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/LandZone.png?alt=media&token=3af3be23-314f-4b67-8c62-625b223b66b9',
      'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/SeaSidePackage.jpeg?alt=media&token=e867cade-ebb1-4a2f-b1f6-05fa2994ce02',
      'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/adventurePackage.jpeg?alt=media&token=f9612f33-cf76-4ac2-bdb9-459d9e87061e',
      'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/seaShorePackage.jpeg?alt=media&token=cd560f6e-1cf4-4107-86e0-562b43e5d624',
      'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/landPackage.jpeg?alt=media&token=5419b0d2-1fbc-4903-b2cc-967b7dc35acf',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
      // 'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/LandZone.png?alt=media&token=3af3be23-314f-4b67-8c62-625b223b66b9',
      // 'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/SeaSidePackage.jpeg?alt=media&token=e867cade-ebb1-4a2f-b1f6-05fa2994ce02',
      // 'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/adventurePackage.jpeg?alt=media&token=f9612f33-cf76-4ac2-bdb9-459d9e87061e',
      // 'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/seaShorePackage.jpeg?alt=media&token=cd560f6e-1cf4-4107-86e0-562b43e5d624',
      // 'https://firebasestorage.googleapis.com/v0/b/vegacity-utility-card.appspot.com/o/landPackage.jpeg?alt=media&token=5419b0d2-1fbc-4903-b2cc-967b7dc35acf'
    ];

    final _currentPage = useState(0);
    final _pageController = usePageController();

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (_currentPage.value < imgList.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      });

      return () => timer.cancel();
    }, []);

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
                    FadeInLeft(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('${user.imageUrl}'),
                        radius: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInUp(
                            child: const Text(
                              "Welcome Back!",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          FadeInUp(
                            child: Text(
                              '${user.fullName}'.split(' ').last,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
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

              // PageView
              FadeInDown(
                child: SizedBox(
                    height: 200,
                    child: Swiper(
                      layout: SwiperLayout.STACK,
                      itemWidth: 320,
                      itemHeight: 500,
                      duration: 500,
                      loop: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: NetworkImage(imgList[index]),
                                  fit: BoxFit.cover)),
                        );
                      },
                    )),
              ),
              // Center(
              //   child: buildPageIndicator(imgList.length, _currentPage.value),
              // ),
              const SizedBox(height: 20),
              // Action Buttons
              Stack(
                children: [
                  FadeInUp(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Column(
                        children: [
                          ActionButtons(),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Packages Title
              Container(
                margin: const EdgeInsets.only(left: 25.5, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FadeInLeft(
                      child: const Text(
                        "Packages",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    FadeTransition(
                      opacity: _animation,
                      child: FadeInLeft(
                        child: Text(
                          "new",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red, // Thêm màu đỏ cho nổi bật
                          ),
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
                  child: FadeInUp(
                    child: GridView.builder(
                      itemCount: fetchReslut.items.length, // Giữ lại dòng này
                      // physics: const AlwaysScrollableScrollPhysics(),
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
                        childAspectRatio: 0.6, // Tỷ lệ khung hình
                      ),
                      itemBuilder: (context, index) {
                        return HomeItem(
                          package: fetchReslut.items[index],
                          onCallback: fetchReslut.refresh,
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildPageIndicator(int length, int currentIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      length,
      (index) => Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentIndex == index ? Colors.blue : Colors.grey,
        ),
      ),
    ),
  );
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
