import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/models/bike_details.dart';
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

  // Future<void> dateTimeRangeBottomSheet(BuildContext context) {
  //   DateTime? _startDateTime;
  //   DateTime? _endDateTime;
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SfDateRangePicker(
  //               onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
  //                 setState(() {
  //                   if (args.value is PickerDateRange) {
  //
  //                     _startDateTime = args.value.startDate;
  //                     _endDateTime = args.value.endDate;
  //                     print('_startDateTime $_startDateTime');
  //                     print('_endDateTime $_endDateTime');
  //                   }
  //                 });
  //               },
  //               selectionMode: DateRangePickerSelectionMode.range,
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: _startDateTime == null
  //                   ? null
  //                   : () {
  //                       DatePicker.showTimePicker(
  //                         context,
  //                         showTitleActions: true,
  //                         onConfirm: (time) {
  //                           setState(() {
  //                             _startDateTime = DateTime(
  //                               _startDateTime!.year,
  //                               _startDateTime!.month,
  //                               _startDateTime!.day,
  //                               time.hour,
  //                               time.minute,
  //                             );
  //                           });
  //                         },
  //                         currentTime: DateTime.now(),
  //                       );
  //                     },
  //               child: Text('Select Start Time'),
  //             ),
  //             SizedBox(height: 10),
  //             ElevatedButton(
  //               onPressed: _endDateTime == null
  //                   ? null
  //                   : () {
  //                       DatePicker.showTimePicker(
  //                         context,
  //                         showTitleActions: true,
  //                         onConfirm: (time) {
  //                           setState(() {
  //                             _endDateTime = DateTime(
  //                               _endDateTime!.year,
  //                               _endDateTime!.month,
  //                               _endDateTime!.day,
  //                               time.hour,
  //                               time.minute,
  //                             );
  //                           });
  //                         },
  //                         currentTime: DateTime.now(),
  //                       );
  //                     },
  //               child: Text('Select End Time'),
  //             ),
  //             SizedBox(height: 20),
  //             Text(
  //               'Selected Start DateTime: ${_startDateTime?.toString() ?? 'Not selected'}',
  //             ),
  //             Text(
  //               'Selected End DateTime: ${_endDateTime?.toString() ?? 'Not selected'}',
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Done'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  Future<void> dateTimeRangeBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DateTimeRangePicker();
      },
    );
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => CustomText(
                                  text: bikeDetailsController.bikeTitle.value,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth / 18,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.star,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Obx(
                                    () => CustomText(
                                      text: bikeDetailsController
                                          .ratingCount.value
                                          .toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth / 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Obx(
                            () => CustomText(
                              text: bikeDetailsController.total.value == 0
                                  ? ""
                                  : "\u20B9 ${bikeDetailsController.total.value}",
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth / 18,
                              color: MyTheme.orange,
                            ),
                          ),
                          Obx(
                            () => CustomText(
                              text: bikeDetailsController
                                  .productDescription.value,
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth / 36,
                              maxLines: 6,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              dateTimeRangeBottomSheet(context);
                            },
                            child: Container(
                              height: 40,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                color: MyTheme.orange,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Obx(
                                  () => CustomText(
                                    text: bikeDetailsController.startDateTime ==
                                            ''
                                        ? "Select Date And Time"
                                        : "${bikeDetailsController.startDateTime} - ${bikeDetailsController.endDateTime}",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: toggleSwitch(toggle: (index) {
                              bikeDetailsController.calculatePrice(index!);
                            }),
                          ),

                          Obx(
                            () => bikeDetailsController
                                    .stationDropdownItems.isNotEmpty
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(),
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
                          // Obx(
                          //   () => SizedBox(
                          //     height: 40,
                          //     child: DropdownButtonFormField<String>(
                          //       value: bikeDetailsController.selectedValue.value,
                          //       style: TextStyle(color: Colors.black),
                          //       onChanged:
                          //           bikeDetailsController.onChangeAvailableDropdown,
                          //       padding: EdgeInsets.all(0),
                          //       decoration: InputDecoration(
                          //         contentPadding: EdgeInsets.all(8),
                          //         border: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         enabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         disabledBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(10),
                          //         ),
                          //       ),
                          //       items: bikeDetailsController.stationDropdownItems.map((item) {
                          //         return DropdownMenuItem(
                          //           value: item,
                          //           child: Text(item),
                          //         );
                          //       }).toList(),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (bikeDetailsController.startDateTime.value ==
                                      "" ||
                                  bikeDetailsController.endDateTime.value ==
                                      '') {
                                const snackBar = SnackBar(
                                  content: Text('Please select date and time'),
                                  backgroundColor: MyTheme.accent_color,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                              if (bikeDetailsController.selectedStation.value ==
                                      "" ||
                                  bikeDetailsController.selectedStation.value ==
                                      null) {
                                const snackdemo = SnackBar(
                                  content: Text('Please select station'),
                                  backgroundColor: MyTheme.accent_color,
                                  elevation: 10,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackdemo);
                                return;
                              }
                              Get.to(
                                () => CheckoutPage(
                                  imageUrl:
                                      bikeDetailsController.imageFile.value,
                                  startTime:
                                      bikeDetailsController.startDateTime.value,
                                  endTime:
                                      bikeDetailsController.endDateTime.value,
                                  station: bikeDetailsController
                                      .selectedStation.value!.name!,
                                  totalPayableAmount:
                                      bikeDetailsController.total.value == 0
                                          ? bikeDetailsController.price.value
                                              .toString()
                                          : bikeDetailsController.total.value
                                              .toString(),
                                  lat: bikeDetailsController
                                      .selectedStation.value!.lat!,
                                  long: bikeDetailsController
                                      .selectedStation.value!.lon!,
                                  name: bikeDetailsController.bikeTitle.value,
                                  id: widget.id,
                                ),
                              );
                            },
                            child: Container(
                              width: screenWidth,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
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
}
