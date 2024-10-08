import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:toggle_switch/toggle_switch.dart';

Widget toggleSwitch({void Function(int?)? toggle, required double screenWidth}) {
  print('screenWidth ---> $screenWidth');
  final BikeDetailsController bikeDetailsController =
  Get.find<BikeDetailsController>();
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(screenWidth/180),
    child: ToggleSwitch(
        minWidth: screenWidth/4,
        minHeight: screenWidth/14.4,
        cornerRadius: screenWidth/18,
        activeBgColors: [
          [MyTheme.accent_color],
          [MyTheme.accent_color],
          [MyTheme.accent_color],
          [MyTheme.accent_color]
        ],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.white,
        inactiveFgColor: Colors.black,
        initialLabelIndex: bikeDetailsController.selectedIndex.value,
        totalSwitches: 4,
        labels: ['HOUR', 'DAY', 'WEEK', 'MONTH'],
        fontSize: screenWidth/36,
        radiusStyle: true,
        onToggle: toggle),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth/18),
        border: Border.all(width: 1, color: MyTheme.secondary_accent_color)),
  );
}
