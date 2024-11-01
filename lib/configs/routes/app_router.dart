import 'package:auto_route/auto_route.dart';
import 'package:base/configs/routes/guard/auth_guard.dart';
import 'package:base/features/e-tag/presentation/screen/card_screen.dart';
import 'package:base/features/map/map_screen.dart';
import 'package:base/features/payment/presentation/screen/transfer_screen.dart';
import 'package:base/features/payment/presentation/screen/transfer_success_screen.dart';
import 'package:base/features/profile/presentation/screens/change_password/change_password_screen.dart';
import 'package:base/features/scanner/scanner_result.dart';
import 'package:base/features/scanner/scanner_screen.dart';
import 'package:base/features/profile/presentation/screens/privacy_policy/policy_privacy_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// guard

// screen-auth
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:base/features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:base/features/auth/presentation/screens/privacy_term/privacy_screen.dart';
import 'package:base/features/auth/presentation/screens/privacy_term/term_screen.dart';
import 'package:base/features/auth/presentation/screens/otp_verification/otp_verification_screen.dart';
import 'package:base/features/history/presentation/screen/history_screen/history_screen.dart';
import 'package:base/features/profile/presentation/screens/profile_detail_screen/profile_detail_screen.dart';
import 'package:base/features/scanner1/manage_scanner_screen.dart';

// screen-home
import 'package:base/features/home/presentation/screens/home_screen/home_screen.dart';
import 'package:base/features/profile/presentation/screens/profile_screen/profile_screen.dart';

// screen-test
import 'package:base/features/test/presentation/screens/test_screen/test_screen.dart';
import 'package:base/features/package/presentation/screens/package_screen/package_screen.dart';

import 'package:base/splash_screen.dart';
import 'package:base/tab_screen.dart';

// import 'package:base/onboarding_screen.dart';

// model

// utils
import 'package:base/utils/enums/enums_export.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends _$AppRouter {
  final Ref _ref;
  AppRouter({
    required Ref ref,
  }) : _ref = ref;

  @override
  List<AutoRoute> get routes => [
        // auth
        AutoRoute(
          page: SignInScreenRoute.page,
          initial: true,
        ),
        AutoRoute(page: SignUpScreenRoute.page),
        AutoRoute(page: OTPVerificationScreenRoute.page),

        // Màn hình Onboarding
        // AutoRoute(page: OnboardingScreenRoute.page),

        // Màn hình chính
        AutoRoute(
          page: TabViewScreenRoute.page,
          guards: [
            // OnboardingGuard(ref: _ref),
            AuthGuard(ref: _ref),
          ],
          children: [
            AutoRoute(page: HomeScreenRoute.page),
            AutoRoute(page: PackageScreenRoute.page),
            AutoRoute(page: ScannerScreenRoute.page),
            AutoRoute(page: HistoryScreenRoute.page),
            AutoRoute(page: ProfileScreenRoute.page),
            // AutoRoute(page: TestScreenRoute.page),
          ],
        ),
        AutoRoute(
          page: HomeScreenRoute.page,
        ),

        AutoRoute(
          page: ScannerScreenRoute.page,
        ),
        AutoRoute(
          page: ProfileDetailsScreenRoute.page,
        ),
        AutoRoute(
          page: ChangePasswordScreenRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: TransferSuccessRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: MapScreenRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: PolicyPrivacyScreenRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: TransferScreenRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: QRResultRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: CardScreenRoute.page,
        ),
        AutoRoute(page: TestScreenRoute.page),
      ];
}

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));
