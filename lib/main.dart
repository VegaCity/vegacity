import 'package:base/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'configs/routes/app_router.dart';
import 'configs/theme/app_theme.dart';
import 'utils/constants/asset_constant.dart';
// import 'package:base/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final user = await SharedPreferencesUtils.getInstance('user_token');

  // print( user?.toJson());

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await initFirebaseMessaging();

  // check firebase anonymous user connect
  //await testFirebaseConnection();
  // await testFirebaseConnectionWithPhone('+84382703625');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const ProviderScope(
        child: MyApp(),
      )));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSplashScreen = useState(true);
    // useEffect(() {
    //   initUniLinks(context, ref);
    //   return null;
    // }, []);
    useEffect(() {
      Future.delayed(const Duration(seconds: 3)).then((_) {
        showSplashScreen.value = false;
      });
      return null;
    }, []);

    if (showSplashScreen.value) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AssetsConstants.appTitle,
      theme: AppTheme.theme.copyWith(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      routerConfig: ref.watch(appRouterProvider).config(),
    );
  }
}
