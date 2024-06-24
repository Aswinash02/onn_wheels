import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

Widget toggleSwitch() {
  return Container(
    padding: EdgeInsets.all(2),
    child: ToggleSwitch(
      minWidth: 60.0,
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
      initialLabelIndex: 0,
      totalSwitches: 5,
      labels: ['HOUR', 'Day', 'WEEk', 'MONTH', 'KM'],
      fontSize: 8,
      radiusStyle: true,
      onToggle: (index) {
        print('switched to: $index');
      },
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.amber)),
  );
}
