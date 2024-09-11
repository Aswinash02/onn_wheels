import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/home_controller.dart';
import 'package:onnwheels/models/filter_bikes_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/categories/components/filter_radio.dart';
import 'package:onnwheels/views/categories/components/filter_text_field.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return AlertDialog(
        title: Text('Filter Bikes'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filterRadio(title: 'Hour'),
            filterRadio(title: 'Day'),
            filterRadio(title: 'Week'),
            filterRadio(title: 'Month'),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: "Station",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 35,
              child: DropdownButtonFormField<Stations>(
                value: controller.selectedStation,
                onChanged: controller.onChangeStation,
                items: controller.stationList.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item.name ?? ''),
                  );
                }).toList(),
                style: TextStyle(fontSize: 14, color: MyTheme.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Select Station",
                  hintStyle:
                      const TextStyle(color: MyTheme.grey_153, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: "Fuel Type",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 8.0),
              child: FilterTextField(
                  itemList: controller.fuelTypeList,
                  hintText: "Select Fuel Type",
                  onChange: controller.onChangeFuelType,
                  value: controller.selectedFuelType),
            ),
            CustomText(
              text: "Transmission Type",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 8.0),
              child: FilterTextField(
                  itemList: controller.transmissionTypeList,
                  hintText: "Select Transmission Type",
                  onChange: controller.onChangeTransmissionType,
                  value: controller.selectedTransmissionType),
            ),
            CustomText(
              text: "Brand",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 2,
            ),
            FilterTextField(
                itemList: controller.brandList,
                hintText: "Select Brand",
                onChange: controller.onChangeBrand,
                value: controller.selectedBrand),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.clearData(isDefault: true);
              Navigator.of(context).pop();
            },
            child: CustomText(text: 'Default', color: MyTheme.accent_color),
          ),
          TextButton(
            onPressed: () {
              controller.clearData();
              Navigator.of(context).pop();
            },
            child: CustomText(text: 'Cancel', color: MyTheme.accent_color),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.selectedPackage != null ||
                  controller.selectedStation != null ||
                  controller.selectedFuelType != null ||
                  controller.selectedTransmissionType != null ||
                  controller.selectedTransmissionType != null ||
                  controller.selectedBrand != null) {
                await controller.getFilterBikes();
              }
              Navigator.of(context).pop();
            },
            child: CustomText(text: 'Apply'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(MyTheme.accent_color)),
          ),
        ],
      );
    });
  }
}
