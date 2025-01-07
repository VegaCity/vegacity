// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CardScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CardScreen(),
      );
    },
    ChangePasswordScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangePasswordScreen(),
      );
    },
    HistoryScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryScreen(),
      );
    },
    HomeScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    MapScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapScreen(),
      );
    },
    OTPVerificationScreenRoute.name: (routeData) {
      final args = routeData.argsAs<OTPVerificationScreenRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OTPVerificationScreen(
          key: args.key,
          phoneNumber: args.phoneNumber,
          verifyType: args.verifyType,
        ),
      );
    },
    PackageScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PackageScreen(),
      );
    },
    PolicyPrivacyScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PolicyPrivacyScreen(),
      );
    },
    PrivacyPolicyScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PrivacyPolicyScreenRouteArgs>(
          orElse: () => const PrivacyPolicyScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PrivacyPolicyScreen(key: args.key),
      );
    },
    ProfileDetailsScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileDetailsScreen(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    PromotionScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PromotionScreen(),
      );
    },
    QRResultRoute.name: (routeData) {
      final args = routeData.argsAs<QRResultRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QRResult(
          key: args.key,
          code: args.code,
          closeScreen: args.closeScreen,
        ),
      );
    },
    QrScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const QrScreen(),
      );
    },
    ScannerScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ScannerScreen(),
      );
    },
    SignInScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SignInScreenRouteArgs>(
          orElse: () => const SignInScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignInScreen(key: args.key),
      );
    },
    SignUpScreenRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpScreenRouteArgs>(
          orElse: () => const SignUpScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpScreen(key: args.key),
      );
    },
    SplashScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    TabViewScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TabViewScreen(),
      );
    },
    TermOfUseScreenRoute.name: (routeData) {
      final args = routeData.argsAs<TermOfUseScreenRouteArgs>(
          orElse: () => const TermOfUseScreenRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TermOfUseScreen(key: args.key),
      );
    },
    TestScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TestScreen(),
      );
    },
    TransferScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransferScreen(),
      );
    },
    TransferSuccessRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TransferSuccess(),
      );
    },
    WalletScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WalletScreen(),
      );
    },
  };
}

/// generated route for
/// [CardScreen]
class CardScreenRoute extends PageRouteInfo<void> {
  const CardScreenRoute({List<PageRouteInfo>? children})
      : super(
          CardScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'CardScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangePasswordScreen]
class ChangePasswordScreenRoute extends PageRouteInfo<void> {
  const ChangePasswordScreenRoute({List<PageRouteInfo>? children})
      : super(
          ChangePasswordScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryScreen]
class HistoryScreenRoute extends PageRouteInfo<void> {
  const HistoryScreenRoute({List<PageRouteInfo>? children})
      : super(
          HistoryScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeScreenRoute extends PageRouteInfo<void> {
  const HomeScreenRoute({List<PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MapScreen]
class MapScreenRoute extends PageRouteInfo<void> {
  const MapScreenRoute({List<PageRouteInfo>? children})
      : super(
          MapScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OTPVerificationScreen]
class OTPVerificationScreenRoute
    extends PageRouteInfo<OTPVerificationScreenRouteArgs> {
  OTPVerificationScreenRoute({
    Key? key,
    required String phoneNumber,
    required VerificationOTPType verifyType,
    List<PageRouteInfo>? children,
  }) : super(
          OTPVerificationScreenRoute.name,
          args: OTPVerificationScreenRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
            verifyType: verifyType,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPVerificationScreenRoute';

  static const PageInfo<OTPVerificationScreenRouteArgs> page =
      PageInfo<OTPVerificationScreenRouteArgs>(name);
}

class OTPVerificationScreenRouteArgs {
  const OTPVerificationScreenRouteArgs({
    this.key,
    required this.phoneNumber,
    required this.verifyType,
  });

  final Key? key;

  final String phoneNumber;

  final VerificationOTPType verifyType;

  @override
  String toString() {
    return 'OTPVerificationScreenRouteArgs{key: $key, phoneNumber: $phoneNumber, verifyType: $verifyType}';
  }
}

/// generated route for
/// [PackageItem]
class PackageItemRoute extends PageRouteInfo<PackageItemRouteArgs> {
  PackageItemRoute({
    Key? key,
    required PackageItemEntities card,
    required void Function() onCallback,
    List<PageRouteInfo>? children,
  }) : super(
          PackageItemRoute.name,
          args: PackageItemRouteArgs(
            key: key,
            card: card,
            onCallback: onCallback,
          ),
          initialChildren: children,
        );

  static const String name = 'PackageItemRoute';

  static const PageInfo<PackageItemRouteArgs> page =
      PageInfo<PackageItemRouteArgs>(name);
}

class PackageItemRouteArgs {
  const PackageItemRouteArgs({
    this.key,
    required this.card,
    required this.onCallback,
  });

  final Key? key;

  final PackageItemEntities card;

  final void Function() onCallback;

  @override
  String toString() {
    return 'PackageItemRouteArgs{key: $key, card: $card, onCallback: $onCallback}';
  }
}

/// generated route for
/// [PackageScreen]
class PackageScreenRoute extends PageRouteInfo<void> {
  const PackageScreenRoute({List<PageRouteInfo>? children})
      : super(
          PackageScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PackageScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PolicyPrivacyScreen]
class PolicyPrivacyScreenRoute extends PageRouteInfo<void> {
  const PolicyPrivacyScreenRoute({List<PageRouteInfo>? children})
      : super(
          PolicyPrivacyScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PolicyPrivacyScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyPolicyScreen]
class PrivacyPolicyScreenRoute
    extends PageRouteInfo<PrivacyPolicyScreenRouteArgs> {
  PrivacyPolicyScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          PrivacyPolicyScreenRoute.name,
          args: PrivacyPolicyScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyScreenRoute';

  static const PageInfo<PrivacyPolicyScreenRouteArgs> page =
      PageInfo<PrivacyPolicyScreenRouteArgs>(name);
}

class PrivacyPolicyScreenRouteArgs {
  const PrivacyPolicyScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'PrivacyPolicyScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfileDetailsScreen]
class ProfileDetailsScreenRoute extends PageRouteInfo<void> {
  const ProfileDetailsScreenRoute({List<PageRouteInfo>? children})
      : super(
          ProfileDetailsScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileDetailsScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileScreenRoute extends PageRouteInfo<void> {
  const ProfileScreenRoute({List<PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PromotionScreen]
class PromotionScreenRoute extends PageRouteInfo<void> {
  const PromotionScreenRoute({List<PageRouteInfo>? children})
      : super(
          PromotionScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'PromotionScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QRResult]
class QRResultRoute extends PageRouteInfo<QRResultRouteArgs> {
  QRResultRoute({
    Key? key,
    required String code,
    required dynamic Function() closeScreen,
    List<PageRouteInfo>? children,
  }) : super(
          QRResultRoute.name,
          args: QRResultRouteArgs(
            key: key,
            code: code,
            closeScreen: closeScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'QRResultRoute';

  static const PageInfo<QRResultRouteArgs> page =
      PageInfo<QRResultRouteArgs>(name);
}

class QRResultRouteArgs {
  const QRResultRouteArgs({
    this.key,
    required this.code,
    required this.closeScreen,
  });

  final Key? key;

  final String code;

  final dynamic Function() closeScreen;

  @override
  String toString() {
    return 'QRResultRouteArgs{key: $key, code: $code, closeScreen: $closeScreen}';
  }
}

/// generated route for
/// [QrScreen]
class QrScreenRoute extends PageRouteInfo<void> {
  const QrScreenRoute({List<PageRouteInfo>? children})
      : super(
          QrScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'QrScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ScannerScreen]
class ScannerScreenRoute extends PageRouteInfo<void> {
  const ScannerScreenRoute({List<PageRouteInfo>? children})
      : super(
          ScannerScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ScannerScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInScreen]
class SignInScreenRoute extends PageRouteInfo<SignInScreenRouteArgs> {
  SignInScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignInScreenRoute.name,
          args: SignInScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInScreenRoute';

  static const PageInfo<SignInScreenRouteArgs> page =
      PageInfo<SignInScreenRouteArgs>(name);
}

class SignInScreenRouteArgs {
  const SignInScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignUpScreen]
class SignUpScreenRoute extends PageRouteInfo<SignUpScreenRouteArgs> {
  SignUpScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpScreenRoute.name,
          args: SignUpScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpScreenRoute';

  static const PageInfo<SignUpScreenRouteArgs> page =
      PageInfo<SignUpScreenRouteArgs>(name);
}

class SignUpScreenRouteArgs {
  const SignUpScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashScreenRoute extends PageRouteInfo<void> {
  const SplashScreenRoute({List<PageRouteInfo>? children})
      : super(
          SplashScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TabViewScreen]
class TabViewScreenRoute extends PageRouteInfo<void> {
  const TabViewScreenRoute({List<PageRouteInfo>? children})
      : super(
          TabViewScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabViewScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TermOfUseScreen]
class TermOfUseScreenRoute extends PageRouteInfo<TermOfUseScreenRouteArgs> {
  TermOfUseScreenRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          TermOfUseScreenRoute.name,
          args: TermOfUseScreenRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'TermOfUseScreenRoute';

  static const PageInfo<TermOfUseScreenRouteArgs> page =
      PageInfo<TermOfUseScreenRouteArgs>(name);
}

class TermOfUseScreenRouteArgs {
  const TermOfUseScreenRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'TermOfUseScreenRouteArgs{key: $key}';
  }
}

/// generated route for
/// [TestScreen]
class TestScreenRoute extends PageRouteInfo<void> {
  const TestScreenRoute({List<PageRouteInfo>? children})
      : super(
          TestScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TestScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransferScreen]
class TransferScreenRoute extends PageRouteInfo<void> {
  const TransferScreenRoute({List<PageRouteInfo>? children})
      : super(
          TransferScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransferScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TransferSuccess]
class TransferSuccessRoute extends PageRouteInfo<void> {
  const TransferSuccessRoute({List<PageRouteInfo>? children})
      : super(
          TransferSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransferSuccessRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WalletScreen]
class WalletScreenRoute extends PageRouteInfo<void> {
  const WalletScreenRoute({List<PageRouteInfo>? children})
      : super(
          WalletScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WalletScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
