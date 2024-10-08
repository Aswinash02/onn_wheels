import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/models/bike_details_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/bike_details_simmer.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/views/bikedetails/components/bike_details_widgets.dart';
import 'package:onnwheels/views/bikedetails/components/daily_price_details.dart';
import 'package:onnwheels/views/bikedetails/components/date_time_picker.dart';
import 'package:onnwheels/views/bikedetails/components/hour_price_details.dart';
import 'package:onnwheels/views/bikedetails/components/month_price_details.dart';
import 'package:onnwheels/views/bikedetails/components/toggle_switch.dart';
import 'package:onnwheels/views/bikedetails/components/week_price_details.dart';
import 'package:onnwheels/views/checkout/checkout_page.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onnwheels/views/webview/webview.dart';

import 'components/bike_feature_container.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bikeDetailsController.fetchProductDetailsData(id: widget.id);
    });
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
                          Row(
                            children: [
                              Obx(
                                () => CustomText(
                                  maxLines: 3,
                                  text: bikeDetailsController.bikeTitle.value,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth / 18,
                                ),
                              ),
                              SizedBox(width: 4),
                              CustomText(
                                text:
                                    "(${bikeDetailsController.bikeDetails!.vehicleNumber})",
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth / 36,
                                textAlign: TextAlign.justify,
                              ),
                            ],
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
                          CustomText(
                            text: "Bike Features",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              bikeFeatureContainer(
                                  title: "Make Year",
                                  value: bikeDetailsController
                                          .bikeDetails!.makeYear ??
                                      '',
                                  icon: "assets/icons/make_year.png"),
                              SizedBox(width: 5),
                              bikeFeatureContainer(
                                  title: "Displacement",
                                  value: bikeDetailsController
                                          .bikeDetails!.displacement ??
                                      '',
                                  icon: "assets/icons/displacement.png"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              bikeFeatureContainer(
                                  title: "Top Speed",
                                  value: bikeDetailsController
                                          .bikeDetails!.topSpeed ??
                                      '',
                                  icon: "assets/icons/speed.png"),
                              SizedBox(width: 5),
                              bikeFeatureContainer(
                                  title: "Fuel Capacity",
                                  value: bikeDetailsController
                                          .bikeDetails!.fullCapacity ??
                                      '',
                                  icon: "assets/icons/fuel_capacity.png"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              bikeFeatureContainer(
                                  title: "KMs Driven",
                                  value: bikeDetailsController
                                          .bikeDetails!.kmsDriven ??
                                      '',
                                  icon: "assets/icons/kms_driven.png"),
                              SizedBox(width: 5),
                              bikeFeatureContainer(
                                  title: "Kerb Weight",
                                  value: bikeDetailsController
                                          .bikeDetails!.kerbWeight ??
                                      '',
                                  icon: "assets/icons/kerb_weight.png"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              bikeFeatureContainer(
                                  title: "Mileage",
                                  value: bikeDetailsController
                                          .bikeDetails!.mileage ??
                                      '',
                                  icon: "assets/icons/mileage.png"),
                              SizedBox(width: 5),
                              bikeFeatureContainer(
                                  title: "Seat",
                                  value:
                                      bikeDetailsController.bikeDetails!.seat ??
                                          '',
                                  icon: "assets/icons/seat.png"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: toggleSwitch(toggle: (index) {
                              bikeDetailsController.selectedIndex.value =
                                  index!;
                            },screenWidth: screenWidth),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => selectedDetail(
                                index:
                                    bikeDetailsController.selectedIndex.value),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: bikeDetailsController.extraHelmet.value,
                                onChanged:
                                    bikeDetailsController.onChangeExtraHelmet,
                                checkColor: MyTheme.white,
                               activeColor: MyTheme.accent_color,
                              ),
                              CustomText(
                                  text:
                                      "Extra Helmet \u20B9 ${bikeDetailsController.bikeDetails!.helmetPrice}",
                                  fontWeight: FontWeight.w500),
                            ],
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
                                              color: MyTheme.accent_color,
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
                            height: 10,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: bikeDetailsController.isConfirm.value,
                                onChanged:
                                    bikeDetailsController.onChangeConfirm,
                                checkColor: MyTheme.white,
                                activeColor: MyTheme.accent_color,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text:
                                            "Confirm that you are above 18 years of age",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                    Row(
                                      children: [
                                        CustomText(
                                            text: "and you are agree to all",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommonWebViewScreen(
                                                          url:
                                                              "${AppConfig.BASE_URL}/terms-and-conditions",
                                                          page_name:
                                                              "Terms&Condition",
                                                        )));
                                          },
                                          child: CustomText(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: MyTheme.secondary_accent_color,
                                            text: "Terms & Condition",
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
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
                                color: MyTheme.accent_color,
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
}
