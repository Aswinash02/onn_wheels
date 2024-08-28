import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/models/bike_details_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/bike_details_simmer.dart';
import 'package:onnwheels/views/bikedetails/components/bike_details_widgets.dart';
import 'package:onnwheels/views/bikedetails/components/date_time_picker.dart';
import 'package:onnwheels/views/bikedetails/components/toggle_switch.dart';
import 'package:onnwheels/views/checkout/checkout_page.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/text_widget.dart';

class BikeDetailsPage extends StatefulWidget {
  const BikeDetailsPage({super.key, required this.id});

  final int id;

  @override
  State<BikeDetailsPage> createState() => _BikeDetailsPageState();
}

class _BikeDetailsPageState extends State<BikeDetailsPage> {
  final BikeDetailsController bikeDetailsController =
      Get.put(BikeDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    bikeDetailsController.fetchProductDetailsData(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.bike_details_ucf,
          backgroundColor: MyTheme.white,
          setLeading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: MyTheme.black),
          ),
          textColor: MyTheme.black),
      body: Obx(
        () => bikeDetailsController.loadingState.value
            ? CustomSimmer()
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => BikeDetailWidgets.buildProductSliderImageSection(
                        productImageList:
                            bikeDetailsController.bikeImageResponse,
                        carouselController:
                            bikeDetailsController.carouselController,
                        currentImage: bikeDetailsController.currentImage.value,
                        controller: bikeDetailsController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => CustomText(
                              text: bikeDetailsController.bikeTitle.value,
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth / 18,
                            ),
                          ),
                          CustomText(
                            text: bikeDetailsController
                                    .bikeDetails!.description ??
                                '',
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth / 36,
                            maxLines: 100,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: toggleSwitch(toggle: (index) {
                              bikeDetailsController.selectedIndex.value =
                                  index!;
                            }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => selectedDetail(
                                index:
                                    bikeDetailsController.selectedIndex.value),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BikeDetailDateTimeRangePicker(),
                          Obx(
                            () => bikeDetailsController
                                    .stationDropdownItems.isNotEmpty
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(),
                          ),
                          bikeDetailsController.total != 0
                              ? Wrap(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Color(0XFF000080),
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: Obx(
                                            () => CustomText(
                                              text:
                                                  "Total Price : \u20B9 ${bikeDetailsController.total.value}",
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Obx(
                                          () => CustomText(
                                            text:
                                                "${bikeDetailsController.kmLimit} km Limit",
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => bikeDetailsController
                                    .stationDropdownItems.isNotEmpty
                                ? CustomText(text: 'Available At')
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => bikeDetailsController
                                    .stationDropdownItems.isNotEmpty
                                ? SizedBox(
                                    height: 40,
                                    child: DropdownButtonFormField<Stations>(
                                      value: bikeDetailsController
                                          .selectedStation.value,
                                      style: TextStyle(color: Colors.black),
                                      hint: Text("Select Zone"),
                                      onChanged: bikeDetailsController
                                          .onChangeAvailableDropdown,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      items:
                                          bikeDetailsController.dropdownItems,
                                    ),
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              bikeDetailsController.onTapBookNow(
                                  context: context, bikeId: widget.id);
                            },
                            child: Container(
                              width: screenWidth,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0XFF000080),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: "Book Now",
                                  color: MyTheme.white,
                                  fontSize: screenWidth / 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  selectedDetail({required int index}) {
    switch (index) {
      case 0:
        return referencePriceDetailHour();
      case 1:
        return referencePriceDetailDay();
      case 2:
        return referencePriceDetailWeek();
      case 3:
        return referencePriceDetailMonth();
    }
  }

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
                    '\u{20B9} ${controller.bikeDetails!.hoursPrice!.kmLimit ?? ''}/hr'),
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
            // rupeeRow(
            //     title: 'WeekEnd Extra Price',
            //     rupee:
            //         '\u{20B9} ${controller.bikeDetails!.weekendPrice ?? ''}'),
            CustomText(
              text: "Extras",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            rupeeRow(
                title: 'Km limit',
                rupee:
                    '\u{20B9} ${controller.bikeDetails!.daysPrice!.kmLimit ?? ''}/day'),
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
                    '\u{20B9} ${controller.bikeDetails!.weekPrice!.kmLimit ?? ''}/week'),
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
                    '\u{20B9} ${controller.bikeDetails!.monthPrice!.kmLimit ?? ''}/month'),
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
}
