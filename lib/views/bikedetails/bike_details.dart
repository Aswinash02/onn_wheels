import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/bike_details_widgets.dart';
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => BikeDetailWidgets.buildProductSliderImageSection(
                productImageList: bikeDetailsController.bikeImageResponse,
                carouselController: bikeDetailsController.carouselController,
                currentImage: bikeDetailsController.currentImage.value,
                controller: bikeDetailsController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
                              text: bikeDetailsController.ratingCount.value
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
                      text: "\u20B9 ${bikeDetailsController.price.value}",
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth / 18,
                      color: MyTheme.orange,
                    ),
                  ),
                  Obx(
                    () => CustomText(
                      text: bikeDetailsController.productDescription.value,
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
                      setState(() async {
                        await bikeDetailsController.dateTimePicker(context);
                      });
                    },
                    child: Container(
                      height: 40,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: MyTheme.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child:
                            Text(bikeDetailsController.dateTimeCon.text ?? ''),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: screenWidth,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0XFF000080)),
                      child: Center(
                        child: CustomText(
                          text: "Book Now",
                          color: MyTheme.white,
                          fontSize: screenWidth / 20,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
