import 'package:animate_do/animate_do.dart';
import 'package:base/configs/routes/app_router.dart';

import 'package:base/features/profile/domain/entities/user_entity.dart';
import 'package:base/features/profile/presentation/controller/profile_controller.dart';
import 'package:base/features/profile/presentation/widgets/dasboard.dart';
import 'package:base/features/profile/presentation/widgets/item/listsection.dart';
import 'package:base/features/profile/presentation/widgets/item/section.dart';

import 'package:base/hooks/use_fetch_obj.dart';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final state = ref.watch(profileControllerProvider);

    final useFetchResult = useFetchObject<UserEntity>(
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

    final user = useFetchResult.data;
    print('1a: $user');

    return Scaffold(
      backgroundColor: const Color(0x00ffffff),
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
                Center(
                  child: FadeInDown(
                    child: const Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    FadeInLeft(
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'https://storage.googleapis.com/a1aa/image/ZlZz8xYKewVVZSKLqQmruw0BPEyzE4h4PjjXuHhRcotfekMnA.jpg',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              FadeInUp(
                                child: Text(
                                  user!.fullName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              FadeInUp(
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                          FadeInUp(
                            child: Text(
                              user.phoneNumber,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    FadeInRight(
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          context.router
                              .push(const ProfileDetailsScreenRoute());
                        },
                      ),
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
              title: 'About',
              children: [
                FadeInDown(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Màu nền của Container
                        borderRadius: BorderRadius.circular(4), // Độ cong góc
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.1), // Màu của bóng mờ
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          buildListItem(
                            context,
                            icon: Icons.dashboard_outlined,
                            title: 'Statistical',
                            subtitle: 'Statistics on deposits for customers',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StatisticsPage(), // Thay `StatisticsPage` bằng trang bạn muốn điều hướng đến
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Divider(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                          buildListItem(
                            context,
                            icon: Icons.lock_outline,
                            title: 'Change Password',
                            subtitle: 'Change your password',
                            onTap: () {
                              context.router
                                  .push(const ChangePasswordScreenRoute());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FadeInLeft(
              child: buildSection(
                title: 'policy',
                children: [
                  FadeInDown(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Màu nền của Container
                          borderRadius: BorderRadius.circular(4), // Độ cong góc
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Màu của bóng mờ
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            buildListItem(
                              context,
                              icon: Icons.security,
                              title: 'policies and terms',
                              showArrow: true,
                              onTap: () {
                                // // Chuyển đến trang Zalopay Priority mới hoàn toàn
                                context.router
                                    .push(const PolicyPrivacyScreenRoute());
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInLeft(
              child: buildSection(
                title: 'Financial management',
                children: [
                  FadeInDown(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Màu nền của Container
                          borderRadius: BorderRadius.circular(4), // Độ cong góc
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.1), // Màu của bóng mờ
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            buildListItem(
                              context,
                              icon: Icons.account_balance_wallet,
                              title: 'Balance Check',
                              showArrow: true,
                              onTap: () {
                                context.router.push(const WalletScreenRoute());
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Divider(
                                height: 1,
                                color: Colors.grey[300],
                              ),
                            ),
                            // buildListItem(
                            //   context,
                            //   icon: Icons.wallet_giftcard,
                            //   title: 'My wallet',
                            //   subtitle: '********',
                            //   showArrow: true,
                            //   onTap: () {
                            //     // context.router.push(const ZalopayPriorityScreenRoute());
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            buildSection(
              title: '',
              children: [
                FadeInDown(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Màu nền của Container
                      borderRadius: BorderRadius.circular(4), // Độ cong góc
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.1), // Màu của bóng mờ
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: GestureDetector(
                        //  final controller =
                        //       ref.read(signInControllerProvider.notifier);
                        //   await controller.signOut(context);
                        onTap: () {
                          context.router.push(SignInScreenRoute());
                        },
                        child: const Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.red, // Màu chữ đỏ
                            fontWeight: FontWeight.bold, // Độ dày chữ
                            fontSize: 16, // Kích thước chữ
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
