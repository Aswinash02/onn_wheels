import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/views/bikedetails/components/rupee_row.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

Widget referencePriceDetailHour() {
  return GetBuilder<BikeDetailsController>(builder: (controller) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                text: "Mon - Thu",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 2,
              ),
              CustomText(
                text:
                "(Min ${controller.bikeDetails!.hoursPrice!.hourLimit} hrs booking)",
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          rupeeRow(
              title: 'Per Hour',
              rupee:
              "\u{20B9} ${controller.bikeDetails!.hoursPrice!.price ?? ''}"),
          Row(
            children: [
              CustomText(
                text: "Fri - Sun",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: 2,
              ),
              CustomText(
                text:
                "(Min ${controller.bikeDetails!.hoursPrice!.hourWeekendLimit} hrs booking)",
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          rupeeRow(
              title: 'Per Hour',
              rupee:
              "\u{20B9} ${int.parse(controller.bikeDetails!.hoursPrice!.price ?? '0')}"),
          rupeeRow(
              title: 'WeekEnd Price',
              rupee:
              "\u{20B9} ${controller.bikeDetails!.hoursPrice!.hourWeekendPrice ?? '0'}"),
          CustomText(
            text: "Extras",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          rupeeRow(
              title: 'Km limit',
              rupee:
              '${controller.bikeDetails!.hoursPrice!.kmLimit ?? ''} Km/hr'),
          rupeeRow(
              title: 'Excess Km charges',
              rupee:
              '\u{20B9} ${controller.bikeDetails!.hoursPrice!.kmCharges ?? ''}/km'),
          rupeeRow(
              title: 'Excess hour charges',
              rupee:
              "\u{20B9} ${controller.bikeDetails!.hoursPrice!.extraHours ?? ''}"),
        ],
      ),
    );
  });
}