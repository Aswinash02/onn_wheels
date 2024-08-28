import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/home_controller.dart';
import 'package:onnwheels/mytheme.dart';

Widget filterRadio({required String title}) {
  return GetBuilder<HomeController>(builder: (controller) {
    return ListTile(
      title: Text(title),
      leading: Radio<String?>(
          value: title,
          activeColor:MyTheme.accent_color,
          groupValue: controller.selectedPackage,
          onChanged: controller.onChangePackage),
    );
  });
}
