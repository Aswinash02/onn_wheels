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
  var total = 0.obs;

  // var startDateTime = ''.obs;
  // var endDateTime = ''.obs;

  // var hourlyRate = 10.0;
  // var dailyRate = 50.0;
  // var weeklyRate = 300.0;
  // var monthlyRate = 1000.0;
  var hourlyRate = "".obs;
  var dailyRate = "".obs;
  var weeklyRate = "".obs;
  var monthlyRate = "".obs;
  TextEditingController dateTimeCon = TextEditingController();
  TextEditingController availableAtCon = TextEditingController();
  RxString selectedValue = 'Item 1'.obs;
  RxList stationDropdownItems = [].obs;
  RxString startDateTime = ''.obs;
  RxString endDateTime = ''.obs;
  RxBool loadingState = false.obs;

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
    loadingState.value = true;
    var bikeDetailsResponse =
        await ProductRepository().getProductDetails(id: id);

    // Log the rates after fetching
    // print("Fetched Hourly Rate: ${bikeDetailsResponse.hoursPrice!.price}");
    // print("Fetched Daily Rate: ${bikeDetailsResponse.daysPrice!.price}");
    // print("Fetched Weekly Rate: ${bikeDetailsResponse.weekPrice!.price}");
    // print("Fetched Monthly Rate: ${bikeDetailsResponse.monthPrice!.price}");
    // print("Fetched Hourly Rate: ${bikeDetailsResponse.hoursPrice!.value}");
    // print("Fetched Daily Rate: ${bikeDetailsResponse.daysPrice!.value}");
    // print("Fetched Weekly Rate: ${bikeDetailsResponse.weekPrice!.value}");
    // print("Fetched Monthly Rate: ${bikeDetailsResponse.monthPrice!.value}");

    bikeImageResponse.addAll(bikeDetailsResponse.images!);
    productDescription.value = bikeDetailsResponse.description!;
    bikeTitle.value = bikeDetailsResponse.name!;
    imageFile.value = bikeDetailsResponse.image!;
    ratingCount.value = bikeDetailsResponse.ratingCount!;
    price.value = bikeDetailsResponse.price!;
    stationDropdownItems.value = bikeDetailsResponse.stations!;
    storeId.value = bikeDetailsResponse.storeId!;
    hourlyRate.value = bikeDetailsResponse.hoursPrice?.price ?? '0';
    dailyRate.value = bikeDetailsResponse.daysPrice?.price ?? '0';
    weeklyRate.value = bikeDetailsResponse.weekPrice?.price ?? '0';
    monthlyRate.value = bikeDetailsResponse.monthPrice?.price ?? '0';
    setDropdownItems(bikeDetailsResponse.stations ?? []);
    loadingState.value = false;
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

  void calculatePrice(int index) {
    if (startDateTime.isNotEmpty && endDateTime.isNotEmpty) {
      DateTime start =
          DateFormat('MMMM d, yyyy h:mm a').parse(startDateTime.value);
      DateTime end = DateFormat('MMMM d, yyyy h:mm a').parse(endDateTime.value);
      Duration difference = end.difference(start);

      double calculatedPrice = 0.0;
      String pricingMap;

      print("Start DateTime: $start");
      print("End DateTime: $end");
      print("Duration in Hours: ${difference.inHours}");
      print("Duration in Days: ${difference.inDays}");

      try {
        switch (index) {
          case 0:
            pricingMap = hourlyRate.value;
            print("Hourly Rate: $pricingMap");
            total.value = 0;
            calculatedPrice =
                (difference.inHours > 0 ? difference.inHours : 1) *
                    double.parse(pricingMap);
            break;
          case 1:
            pricingMap = dailyRate.value;
            print("Daily Rate: $pricingMap");
            total.value = 0;

            calculatedPrice = (difference.inDays > 0 ? difference.inDays : 1) *
                double.parse(pricingMap);
            break;
          case 2:
            pricingMap = weeklyRate.value;
            print("Weekly Rate: $pricingMap");
            total.value = 0;

            calculatedPrice =
                (difference.inDays / 7).ceil() * double.parse(pricingMap);
            break;
          case 3:
            pricingMap = monthlyRate.value;
            print("Monthly Rate: $pricingMap");
            total.value = 0;

            calculatedPrice =
                (difference.inDays / 30).ceil() * double.parse(pricingMap);
            break;
          default:
            break;
        }
      } catch (e) {
        print("Error parsing pricingMap: $e");
        return;
      }

      // Print calculated price for debugging
      print("Calculated Price: $calculatedPrice");

      // Update total price
      total.value = (calculatedPrice).toInt();
      print("Total Price value==================>${total.value}");
      print(
          "Calculated Additional Price==================>${calculatedPrice.toInt()}");
      update();
    }
  }

  void changeIndex(index) {
    currentImage.value = index;
    update();
  }
}
