import 'package:bot_toast/bot_toast.dart';
import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'helpers/routes/app_routers.dart';
import 'helpers/theme/app_theme_controller.dart';
import 'helpers/theme/style.dart';
import 'helpers/theme/theme_enum.dart';
import 'view/layout/global/auth/controller/auth_controller.dart';
import 'view/layout/global/auth/controller/forget_pass_controller.dart';
import 'view/layout/global/on_boarding/screen/splash_screen.dart';
import 'view/layout/user/home/controller/parking_controller.dart';
import 'view/layout/user/home/controller/user_services_controller.dart';
import 'view/layout/worker/qr_code_scan/controller/qr_code_scan_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ThemeEnumAdapter());
  await Hive.openBox('app');

  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
  timeago.setLocaleMessages('ar', timeago.ArMessages());
  timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'i18n',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      saveLocale: true,
      child: ChangeNotifierProvider(
        create: (context) => AppThemeController()..initial(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setMyAppState(BuildContext context) async {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setMyAppState();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void setMyAppState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ParkingController()),
        ChangeNotifierProvider(create: (_) => QrCodeScanController()),
        ChangeNotifierProvider(create: (_) => UserServiceController()),
        ChangeNotifierProvider(create: (_) => ForgetPassController()),
      ],
      child: MaterialApp(
        title: "Valet Parking",
        localizationsDelegates: [
          ...context.localizationDelegates,
          CountryLocalizations.delegate,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: appThemeData(context),
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouters.onGenerateRoute,
        navigatorKey: AppRouters.navigatorKey,
      ),
    );
  }
}
