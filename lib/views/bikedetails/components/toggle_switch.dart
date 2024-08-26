import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

Widget toggleSwitch({void Function(int?)? toggle}) {
  final BikeDetailsController bikeDetailsController =
  Get.find<BikeDetailsController>();
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(2),
    child: ToggleSwitch(
        minWidth: 90.0,
        minHeight: 25,
        cornerRadius: 20.0,
        activeBgColors: [
          [Color(0XFF000080)],
          [Color(0XFF000080)],
          [Color(0XFF000080)],
          [Color(0XFF000080)],
          [Color(0XFF000080)],
        ],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.white,
        inactiveFgColor: Colors.black,
        initialLabelIndex: bikeDetailsController.selectedIndex.value,
        totalSwitches: 4,
        labels: ['HOUR', 'DAY', 'WEEK', 'MONTH'],
        fontSize: 10,
        radiusStyle: true,
        onToggle: toggle),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.amber)),
  );
}
