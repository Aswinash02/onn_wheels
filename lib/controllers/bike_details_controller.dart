import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/models/bike_details.dart';
import 'package:onnwheels/repositories/product_repositories.dart';

class BikeDetailsController extends GetxController {
  var bikeImageResponse = [].obs;
  BikeDetailsResponse? bikeDetails;
  final CarouselController carouselController = CarouselController();
  var currentImage = 0.obs;
  var productDescription = ''.obs;
  var bikeTitle = ''.obs;
  var imageFile = ''.obs;
  var ratingCount = 0.obs;
  var price = 0.obs;
  TextEditingController dateTimeCon = TextEditingController();

  fetchProductDetailsData({int? id}) async {
    var bikeDetailsResponse =
        await ProductRepository().getProductDetails(id: id);
    bikeImageResponse.addAll(bikeDetailsResponse.images!);
    productDescription.value = bikeDetailsResponse.description!;
    bikeTitle.value = bikeDetailsResponse.name!;
    imageFile.value = bikeDetailsResponse.image!;
    ratingCount.value = bikeDetailsResponse.ratingCount!;
    price.value = bikeDetailsResponse.price!;
  }

  Future dateTimePicker(BuildContext context) async {
    return DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2000, 1, 1),
        maxTime: DateTime(4000, 12, 31), onConfirm: (date) {
          String desiredFormat = "yyyy-MM-dd HH:mm";
          dateTimeCon.text = DateFormat(desiredFormat).format(date);
          update();
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }


  void changeIndex(index) {
    currentImage.value = index;
    update();
  }
}
