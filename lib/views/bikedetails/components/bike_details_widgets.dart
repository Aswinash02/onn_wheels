import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/helpers/shimmer_helper.dart';
import 'package:onnwheels/mytheme.dart';

class BikeDetailWidgets {
  static buildProductSliderImageSection(
      {productImageList,
      carouselController,
      currentImage,
      required BikeDetailsController controller}) {
    if (productImageList.isEmpty) {
      return ShimmerHelper().buildBasicShimmer(
        height: 300,
      );
    } else {
      return Obx(
        () => CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            // aspectRatio: 355 / 375,
            viewportFraction: 1,
            initialPage: 0,
            height: 300,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInExpo,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              controller.changeIndex(index);
            },
          ),
          items: controller.bikeImageResponse.map((i) {
            return Container(
              child: Stack(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder_rectangle.png',
                        image:
                            "https://onnwheels.com/storage/app/public/product/$i",
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/placeholder_rectangle.png',
                            fit: BoxFit.fill,
                          ); // Path to your error image
                        },
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.bikeImageResponse.length,
                        (index) => Container(
                          width: 7.0,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentImage == index
                                ? MyTheme.font_grey
                                : Colors.grey.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
  }
}
