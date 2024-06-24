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
    Future.delayed(Duration(seconds: 2), () async {
      bool isLoggedIn = await SharedPreference().getLogin();
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login();
            },
          ),
        );
      }
    });

    // getSharedValueHelperData().then(
    //   (value) {
    //     Future.delayed(const Duration(seconds: 3)).then(
    //       (value) async {
    //         final isLogged = await SharedPreference().getLogin();
    //         if (isLogged) {
    //           Navigator.pushReplacement(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => MainPage(),
    //             ),
    //           );
    //         } else {
    //           Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) {
    //                 return Login();
    //               },
    //             ),
    //             (route) => false,
    //           );
    //         }
    //       },
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFFACA6F3),
              Color(0XFFD25858),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image(
              image: AssetImage('assets/app_logo.png'),
            ),
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
