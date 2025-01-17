import 'dart:io';
import 'package:flutter/material.dart';

// import 'package:badges/badges.dart' as badges;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_context/one_context.dart';
import 'package:onnwheels/views/categories/categories.dart';
import 'package:onnwheels/views/contact_us/contact_us.dart';
import '../../mytheme.dart';
import '../../utils/image_directory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/shared_value.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../wishlist/wishlist.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key, go_back = true}) : super(key: key);

  late bool go_back;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  var bottomPages = [
    const HomePage(),
    const CategoriesPage(),
    ContactUsPage(),
    const ProfilePage()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else {
          final shouldPop = (await OneContext().showDialog<bool>(
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Directionality(
                textDirection:
                    app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
                child: AlertDialog(
                  contentPadding:
                      const EdgeInsets.only(left: 15, right: 15, top: 15),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                          image: AssetImage(ImageDirectory.appLogo),
                          height: 50,
                          width: 50,
                        ),
                        Text(AppLocalizations.of(context)!
                            .do_you_want_close_the_app),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Platform.isAndroid ? SystemNavigator.pop() : exit(0);
                      },
                      child: Text(AppLocalizations.of(context)!.yes_ucf),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.no_ucf),
                    ),
                  ],
                ),
              );
            },
          ))!;
          return shouldPop;
        }
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          body: bottomPages[_currentIndex],
          bottomNavigationBar: SizedBox(
            height: 70,
            child: BottomNavigationBar(
              onTap: onTapped,
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white.withOpacity(0.95),
              unselectedItemColor: MyTheme.grey_153,
              selectedItemColor: MyTheme.accent_color,
              selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: MyTheme.accent_color,
                  fontSize: 12),
              unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: MyTheme.grey_153,
                  fontSize: 12),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      ImageDirectory.homeIconImage,
                      color: _currentIndex == 0
                          ? MyTheme.accent_color
                          : MyTheme.grey_153,
                      height: 16,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.home_ucf,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      ImageDirectory.bikesIconImage,
                      color: _currentIndex == 1
                          ? MyTheme.accent_color
                          : MyTheme.grey_153,
                      height: 16,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.categories_ucf,
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        ImageDirectory.helps,
                        color: _currentIndex == 2
                            ? MyTheme.accent_color
                            : MyTheme.grey_153,
                        height: 16,
                      ),
                    ),
                    label: AppLocalizations.of(context)!.contact_us_ucf),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      ImageDirectory.profileIconImage,
                      color: _currentIndex == 3
                          ? MyTheme.accent_color
                          : MyTheme.grey_153,
                      height: 16,
                    ),
                  ),
                  label: AppLocalizations.of(context)!.profile_ucf,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
