import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/profile/domain/entities/profile_entity.dart';
import 'package:base/features/profile/presentation/screens/profile_screen/profile_controller.dart';
import 'package:base/features/profile/presentation/widgets/item/listsection.dart';
import 'package:base/features/profile/presentation/widgets/item/section.dart';
import 'package:base/features/profile/presentation/widgets/menu_item.dart';
import 'package:base/features/scanner/scanner_screen.dart';
import 'package:base/features/scanner1/manage_scanner_screen.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    if (useFetchResult.isFetchingData) {
      return const Center(child: CircularProgressIndicator());
    }

    if (useFetchResult.data == null) {
      return const Center(child: Text('No data found'));
    }

    final user = useFetchResult.data!.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0052CC),
                  Color(0xFF00AAFF),
                  Color.fromARGB(255, 111, 194, 208),
                  Color.fromARGB(255, 116, 240, 231),
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
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 7),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                          Text(
                            '${user.phoneNumber}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
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
                  context, // Thêm context để sử dụng Navigator
                  icon: Icons.qr_code,
                  title: 'Quản lý mã',
                  subtitle: 'Quản lý các mã QR quan trọng của bạn',
                  onTap: () {
                    context.router.push(ScannerScreenRoute());
                  },
                ),
                buildListItem(
                  context,
                  icon: Icons.lock_outline,
                  title: 'Đổi Mật Khẩu',
                  subtitle: 'thay đổi mật khẩu của bạn',
                  onTap: () {
                    context.router.push(const ChangePasswordScreenRoute());
                  },
                ),
              ],
            ),
            buildSection(
              title: 'chính sách',
              children: [
                buildListItem(
                  context,
                  icon: Icons.security,
                  title: 'chính sách và điều khoản',
                  showArrow: true,
                  onTap: () {
                    // // Chuyển đến trang Zalopay Priority mới hoàn toàn
                    context.router.push(const PolicyPrivacyScreenRoute());
                  },
                ),
              ],
            ),
            buildSection(
              title: 'Quản lý tài chính',
              children: [
                buildListItem(
                  context,
                  icon: Icons.account_balance_wallet,
                  title: 'Nguồn tiền',
                  showArrow: true,
                  onTap: () {
                    // // Chuyển đến trang Zalopay Priority mới hoàn toàn
                    // context.router.push(const ZalopayPriorityScreenRoute());
                  },
                ),
                buildListItem(
                  context,
                  icon: Icons.wallet_giftcard,
                  title: 'Ví của tôi',
                  subtitle: '********',
                  showArrow: true,
                  onTap: () {
                    // // Chuyển đến trang Zalopay Priority mới hoàn toàn
                    // context.router.push(const ZalopayPriorityScreenRoute());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
