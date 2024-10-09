import 'package:base/features/profile/domain/entities/profile_entity.dart';
import 'package:base/features/profile/presentation/screens/profile_screen/profile_controller.dart';
import 'package:base/features/profile/presentation/widgets/menu.item.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final state = ref.watch(profileControllerProvider);

    final useFetchResult = useFetchObject<ProfileEntity>(
      function: (context) =>
          ref.read(profileControllerProvider.notifier).getUser(context),
      context: context,
    );

    // Kiểm tra xem dữ liệu đã được lấy về hay chưa
    if (useFetchResult.isFetchingData) {
      return const Center(
          child: CircularProgressIndicator()); // Hiển thị vòng tròn loading
    }

    // Kiểm tra xem dữ liệu có tồn tại hay không
    if (useFetchResult.data == null) {
      return const Center(
          child: Text('No data found')); // Thông báo không có dữ liệu
    }

    // Lấy thông tin từ dữ liệu trả về
    final user = useFetchResult.data!.user;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Căn nội dung lên trên
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Color(0xFF00aaff),
                    size: 24,
                  ),
                  Spacer(),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00aaff),
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://storage.googleapis.com/a1aa/image/cAfqWbLEB03HAC0iASxIRqzRRR5NCbjqFcZzuqyBAmDaxYyJA.jpg',
                      ),
                      radius: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Full Name
                  Text(
                    '${user.fullName}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  // Role
                  Text(
                    '${user.email}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Edit Profile Button
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFFFFCC00), // Màu nền
                      side: BorderSide(
                        color: Colors.black, // Màu viền
                        width: 2, // Độ dày của viền
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // Menu Section
            Expanded(
              // Dùng Expanded để ngăn khoảng trống ở phía dưới
              child: Container(
                padding: const EdgeInsets.only(
                    top: 40, right: 30, left: 30, bottom: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF00aaff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                  ),
                  border: Border.all(
                    // Thêm border ở đây
                    color: Colors.black, // Màu viền
                    width: 2, // Độ dày của viền
                  ),
                ),
                child: Column(
                  children: [
                    // Privacy Menu Item
                    MenuItem(
                      icon: FontAwesomeIcons.lock,
                      title: 'Privacy',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Đặt chữ in đậm
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Information App Menu Item
                    MenuItem(
                      icon: FontAwesomeIcons.infoCircle,
                      title: 'Information App',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Đặt chữ in đậm
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Change Password Menu Item
                    MenuItem(
                      icon: FontAwesomeIcons.key,
                      title: 'Change Password',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Đặt chữ in đậm
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Address Menu Item
                    MenuItem(
                      icon: FontAwesomeIcons.mapMarkerAlt,
                      title: ' Address',
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold, // Đặt chữ in đậm
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Logout Menu Item
                    MenuItem(
                      icon: FontAwesomeIcons.signOutAlt,
                      title: ' Logout',
                    ),
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
