import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/views/bikedetails/components/rupee_row.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

Widget referencePriceDetailMonth() {
  return GetBuilder<BikeDetailsController>(builder: (controller) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Monthly",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Per Month',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.monthPrice!.price ?? ''}'),
          CustomText(
            text: "Extras",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Km limit',
              rupee:
                  '${controller.bikeDetails!.monthPrice!.kmLimit ?? ''} Km/month'),
          rupeeRow(
              title: 'Excess Km charges',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.monthPrice!.kmCharges ?? ''}/km'),
          rupeeRow(
              title: 'Excess hour charges',
              rupee:
                  '\u{20B9} ${controller.bikeDetails!.monthPrice!.extraHours ?? ''}'),
        ],
      ),
    );
  });
}
