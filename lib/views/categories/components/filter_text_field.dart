import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/home_controller.dart';
import 'package:onnwheels/mytheme.dart';

class FilterTextField extends StatelessWidget {
  final List<String> itemList;
  final String hintText;
  final void Function(String?) onChange;
  final String? value;

  const FilterTextField(
      {super.key,
      required this.itemList,
      required this.hintText,
      required this.onChange,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SizedBox(
        height: 35,
        child: DropdownButtonFormField(
          value: value,
          onChanged: onChange,
          items: itemList.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          style: TextStyle(fontSize: 14, color: MyTheme.black),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: MyTheme.grey_153, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
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
      );
    });
  }
}
