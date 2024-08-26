import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onnwheels/controllers/auth_controller.dart';
import 'package:onnwheels/utils/routes.dart';
import 'package:onnwheels/utils/themes.dart';
import 'package:onnwheels/views/auth/signin.dart';
import 'package:onnwheels/views/auth/splash_screen.dart';
import 'package:shared_value/shared_value.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    SharedValue.wrapApp(
      const MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}
// final OneContext oneContext = OneContext();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OnnWheels',
      builder: OneContext().builder,
      navigatorKey: OneContext().navigator.key,
      debugShowCheckedModeBanner: false,
      theme: theme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('en'),
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      initialRoute: Routes.mainPage,
      getPages: getPages,
      home: SplashScreen(),
    );
  }
}

