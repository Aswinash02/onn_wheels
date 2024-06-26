import 'package:flutter/material.dart';

class MyTheme {
  /*configurable colors stars*/
  // static const Color accent_color = Color.fromRGBO(230, 46, 4, 1);
  static const Color accent_color = Color(0xFFF89520);
  // static const Color accent_color_shadow =
  //     Color.fromRGBO(229, 65, 28, .40);
  static const Color accent_color_shadow = Color(0xFF529b47); // this color is a dropshadow of
  static Color soft_accent_color = Color.fromRGBO(254, 234, 209, 1);
  // static Color splash_screen_color = Color.fromRGBO(
  //     230, 46, 4, 1); // if not sure , use the same color as accent color
  /*configurable colors ends*/
  static Color splash_screen_color = Color(0xFFF5CF46);
  /*If you are not a developer, do not change the bottom colors*/
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static Color noColor = Color.fromRGBO(255, 255, 255, 0);
  static Color light_grey = Color.fromRGBO(239, 239, 239, 1);
  static Color dark_grey = Color.fromRGBO(107, 115, 119, 1);
  static Color medium_grey = Color.fromRGBO(167, 175, 179, 1);
  static Color blue_grey = Color.fromRGBO(168, 175, 179, 1);
  static Color medium_grey_50 = Color.fromRGBO(167, 175, 179, .5);
  static const Color grey_153 = Color.fromRGBO(153, 153, 153, 1);
  static Color dark_font_grey = Color.fromRGBO(62, 68, 71, 1);
  static const Color font_grey = Color.fromRGBO(107, 115, 119, 1);
  static const Color textfield_grey = Color.fromRGBO(209, 209, 209, 1);
  static Color golden = Color.fromRGBO(255, 168, 0, 1);
  static Color orange = Colors.orange;
  static Color amber = Color.fromRGBO(254, 234, 209, 1);
  static Color amber_medium = Color.fromRGBO(254, 240, 215, 1);
  static Color golden_shadow = Color.fromRGBO(255, 168, 0, .4);
  static Color green = Colors.green;
  static Color? green_light = Colors.green[200];
  static Color shimmer_base = Colors.grey.shade50;
  static Color shimmer_highlighted = Colors.grey.shade200;
  //testing shimmer
  /*static Color shimmer_base = Colors.redAccent;
  static Color shimmer_highlighted = Colors.yellow;*/

  // gradient color for coupons
  static const Color gigas = Color.fromRGBO(95, 74, 139, 1);
  static const Color polo_blue = Color.fromRGBO(152, 179, 209, 1);
  //------------
  static const Color blue_chill = Color.fromRGBO(71, 148, 147, 1);
  static const Color cruise = Color.fromRGBO(124, 196, 195, 1);
  static const Color blue = Color(0XFF0403ff);
  static const Color pink = Color(0XFFf86aa9);
  static const Color beetroot = Color(0XFF760039);
  //---------------
  static const Color brick_red = Color.fromRGBO(191, 25, 49, 1);
  static const Color cinnabar = Color.fromRGBO(226, 88, 62, 1);
  static const Color black = Colors.black;


  static const PrimaryColor = Color(0xffea4b4b);
  static const PrimaryLightColor = Color(0xffF7F9F9);
  static const CardBackgroundColor = Color(0xfff3f4f4);
  static const PrimaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
  );
  static const SecondaryColor = Color(0xFF979797);
  static const SecondaryColorDark = Color(0xff292929);

  static TextTheme textTheme1 = TextTheme(
    bodyLarge: TextStyle(fontFamily: "PublicSansSerif", fontSize: 14),
    bodyMedium: TextStyle(fontFamily: "PublicSansSerif", fontSize: 12),
  );

  static LinearGradient buildLinearGradient3() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [MyTheme.polo_blue, MyTheme.gigas],
    );
  }

  static LinearGradient buildLinearGradient2() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [MyTheme.cruise, MyTheme.blue_chill],
    );
  }

  static LinearGradient buildLinearGradient1() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [MyTheme.cinnabar, MyTheme.brick_red],
    );
  }
}
