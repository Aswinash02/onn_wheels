import 'package:flutter/material.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

Widget rupeeRow({required String title, required String rupee}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            // width: 130,
            child: CustomText(
              text: "${title}",
              fontSize: 12,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomText(
            text: ":",
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: CustomText(
              text: "$rupee",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
