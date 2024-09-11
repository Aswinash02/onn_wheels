import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/views/bikedetails/components/rupee_row.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

Widget referencePriceDetailDay() {
  return GetBuilder<BikeDetailsController>(builder: (controller) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Mon - Thu",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Per Day',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.daysPrice!.price ?? ''}'),
          CustomText(
            text: "Fri - Sun",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Per Day',
              rupee:
                  '\u{20B9} ${int.parse(controller.bikeDetails!.daysPrice!.price ?? '0') + (controller.bikeDetails!.weekendPrice ?? 0)}'),
          CustomText(
            text: "Extras",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Km limit',
              rupee:
                  '${controller.bikeDetails!.daysPrice!.kmLimit ?? ''} Km/day'),
          rupeeRow(
              title: 'Excess Km charges',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.daysPrice!.kmCharges ?? ''}/km'),
          rupeeRow(
              title: 'Excess hour charges',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.daysPrice!.extraHours ?? ''}'),
        ],
      ),
    );
  });
}
