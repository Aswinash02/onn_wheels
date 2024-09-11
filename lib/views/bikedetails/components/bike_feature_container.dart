import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

Widget bikeFeatureContainer(
    {required String title, required String value, required String icon}) {
  return SizedBox(
    width: 160,
    child: Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SizedBox(
              height: 22,
              width: 22,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  MyTheme.accent_color,
                  BlendMode.srcIn,
                ),
                child: Image.asset(
                  icon,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            SizedBox(
              width: 110,
              child: CustomText(
                text: value,
                maxLines: 2,
                fontSize: 12,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
