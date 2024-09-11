import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/views/bikedetails/components/rupee_row.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

Widget referencePriceDetailWeek() {
  return GetBuilder<BikeDetailsController>(builder: (controller) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Weekly",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Per Week',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.weekPrice!.price ?? ''}'),
          CustomText(
            text: "Extras",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Km limit',
              rupee:
                  '${controller.bikeDetails!.weekPrice!.kmLimit ?? ''} Km/week'),
          rupeeRow(
              title: 'Excess Km charges',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.weekPrice!.kmCharges ?? ''}/km'),
          rupeeRow(
              title: 'Excess hour charges',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.weekPrice!.extraHours ?? ''}'),
        ],
      ),
    );
  });
}
