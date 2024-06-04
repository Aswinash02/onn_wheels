import 'package:flutter/material.dart';
import 'package:onnwheels/helpers/auth_helper.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/utils/shared_value.dart';
import 'package:onnwheels/views/auth/signin.dart';
import 'package:onnwheels/views/main_page/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getSharedValueHelperData().then(
      (value) {
        Future.delayed(const Duration(seconds: 3)).then(
          (value) async {
            final isLogged = await SharedPreference().getLogin();
            if (isLogged) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(),
                ),
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Login();
                  },
                ),
                (route) => false,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Image(
            image: AssetImage('assets/image/app_logo.png'),
          ),
        ),
      ),
    );
  }

  Future<String?> getSharedValueHelperData() async {
    access_token.load().whenComplete(() {
      // AuthHelper().fetch_and_set();
    });
    // AddonsHelper().setAddonsData();
    // BusinessSettingHelper().setBusinessSettingData();
    await app_language.load();
    await app_mobile_language.load();
    await app_language_rtl.load();
    await system_currency.load();
    return app_mobile_language.$;
  }
}
