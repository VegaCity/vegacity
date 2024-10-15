import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/profile/domain/entities/profile_entity.dart';
import 'package:base/features/profile/presentation/screens/profile_screen/profile_controller.dart';
import 'package:base/features/profile/presentation/widgets/item/listsection.dart';
import 'package:base/features/profile/presentation/widgets/item/section.dart';
import 'package:base/features/profile/presentation/widgets/menu_item.dart';
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
      backgroundColor: Color(0xFFF0F4F8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0), // Adjust height if needed
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Center(
                  child: Text(
                    'Tài khoản',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const NetworkImage(
                        'https://storage.googleapis.com/a1aa/image/ZlZz8xYKewVVZSKLqQmruw0BPEyzE4h4PjjXuHhRcotfekMnA.jpg',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${user.fullName}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 7),
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            '${user.phoneNumber}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        // Navigate to edit profile page
                        context.router.push(const ProfileDetailsScreenRoute());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSection(
              title: '',
              children: [
                buildListItem(
                  icon: Icons.qr_code,
                  title: 'Quản lý mã',
                  subtitle: 'Quản lý các mã QR quan trọng của bạn',
                ),
                buildListItem(
                  icon: Icons.star,
                  title: 'Zalopay Priority',
                  subtitle: 'Thành viên',
                ),
              ],
            ),
            buildSection(
              title: 'Ưu đãi',
              children: [
                buildListItem(
                  icon: Icons.card_giftcard,
                  title: 'Quà của tôi',
                  subtitle: '4 ưu đãi',
                  showArrow: true,
                ),
                buildListItem(
                  icon: Icons.monetization_on,
                  title: 'Xu tích lũy',
                  subtitle: '10 xu',
                  showArrow: true,
                ),
              ],
            ),
            buildSection(
              title: 'Quản lý tài chính',
              children: [
                buildListItem(
                  icon: Icons.account_balance_wallet,
                  title: 'Nguồn tiền',
                  showArrow: true,
                ),
                buildListItem(
                  icon: Icons.visibility_off,
                  title: 'Số dư hiện có',
                  showArrow: true,
                ),
                buildListItem(
                  icon: Icons.wallet_giftcard,
                  title: 'Ví Zalopay',
                  subtitle: '********',
                  showArrow: true,
                ),
                 ],
            ),
          ],
        ),
      ),
    );
  }
}
