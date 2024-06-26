
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
  var storeId = 0.obs;
  TextEditingController dateTimeCon = TextEditingController();
  TextEditingController availableAtCon = TextEditingController();
  RxString selectedValue = 'Item 1'.obs;
  RxList stationDropdownItems = [].obs;
  RxString startDateTime = ''.obs;
  RxString endDateTime = ''.obs;

  // RxList to hold the dropdown items
  RxList<DropdownMenuItem<Stations>> dropdownItems =
      <DropdownMenuItem<Stations>>[].obs;

  Rx<Stations?> selectedStation = Rx<Stations?>(null);

  // Method to update the dropdown items
  void setDropdownItems(List<Stations> stations) {
    dropdownItems.value = stations.map((station) {
      return DropdownMenuItem<Stations>(
        value: station,
        child: Text(station.name ?? "Unknown"),
      );
    }).toList();
  }

  // Method to handle changes
  void onChangeAvailableDropdown(Stations? newValue) {
    selectedStation.value = newValue;
  }

  fetchProductDetailsData({int? id}) async {
    var bikeDetailsResponse =
        await ProductRepository().getProductDetails(id: id);
    bikeImageResponse.addAll(bikeDetailsResponse.images!);
    productDescription.value = bikeDetailsResponse.description!;
    bikeTitle.value = bikeDetailsResponse.name!;
    imageFile.value = bikeDetailsResponse.image!;
    ratingCount.value = bikeDetailsResponse.ratingCount!;
    price.value = bikeDetailsResponse.price!;
    stationDropdownItems.value = bikeDetailsResponse.stations!;
    storeId.value = bikeDetailsResponse.storeId!;
    setDropdownItems(bikeDetailsResponse.stations ?? []);
  }

  Future dateTimePicker(BuildContext context) async {
    return DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(2000, 1, 1),
        maxTime: DateTime(4000, 12, 31), onConfirm: (date) {
      String desiredFormat = "yyyy-MM-dd HH:mm";
      dateTimeCon.text = DateFormat(desiredFormat).format(date);
      print('dateTimeCon${dateTimeCon.text}');
      update();
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void changeIndex(index) {
    currentImage.value = index;
    update();
  }


}
