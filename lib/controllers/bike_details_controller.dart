import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/models/bike_details_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/product_repositories.dart';
import 'package:onnwheels/views/checkout/checkout_page.dart';

class BikeDetailsController extends GetxController {
  var bikeImageResponse = [].obs;
  BikeDetailsResponse? bikeDetails;

  final CarouselController carouselController = CarouselController();
  var currentImage = 0.obs;
  var productDescription = ''.obs;
  var bikeTitle = ''.obs;
  var imageFile = ''.obs;
  var ratingCount = 0.obs;
  RxDouble price = 0.0.obs;
  var storeId = 0.obs;
  var total = 0.obs;
  RxInt kmLimit = 0.obs;
  var selectedIndex = 0.obs;
  var hourlyRate = "".obs;
  var hourWeekEndRate = "".obs;
  var dailyRate = "".obs;
  var weeklyRate = "".obs;
  var monthlyRate = "".obs;
  TextEditingController dateTimeCon = TextEditingController();
  TextEditingController availableAtCon = TextEditingController();
  TextEditingController startDateCon = TextEditingController();
  TextEditingController endDateCon = TextEditingController();
  TextEditingController startTimeCon = TextEditingController();
  TextEditingController endTimeCon = TextEditingController();
  RxString selectedValue = 'Item 1'.obs;
  RxList stationDropdownItems = [].obs;
  RxString startDateTime = ''.obs;
  RxString endDateTime = ''.obs;

  RxBool loadingState = false.obs;

  RxList<DropdownMenuItem<Stations>> dropdownItems =
      <DropdownMenuItem<Stations>>[].obs;

  Rx<Stations?> selectedStation = Rx<Stations?>(null);

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
    print('bikeDetailsResponse.name ${bikeDetailsResponse}');

    bikeImageResponse.addAll(bikeDetailsResponse.images ?? []);
    bikeTitle.value = bikeDetailsResponse.name ?? '';
    imageFile.value = bikeDetailsResponse.image ?? '';
    stationDropdownItems.value = bikeDetailsResponse.stations ?? [];
    hourlyRate.value = bikeDetailsResponse.hoursPrice?.price ?? '0';
    hourWeekEndRate.value =
        bikeDetailsResponse.hoursPrice?.hourWeekendPrice ?? '0';
    dailyRate.value = bikeDetailsResponse.daysPrice?.price ?? '0';
    weeklyRate.value = bikeDetailsResponse.weekPrice?.price ?? '0';
    monthlyRate.value = bikeDetailsResponse.monthPrice?.price ?? '0';
    setDropdownItems(bikeDetailsResponse.stations ?? []);
    bikeDetails = bikeDetailsResponse;
    loadingState.value = false;
    update();
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

  void onTapBookNow({required BuildContext context, required int bikeId}) {
    if (startDateTime.value == "" || endDateTime.value == '') {
      const snackBar = SnackBar(
        content: Text('Please select date and time'),
        backgroundColor: MyTheme.accent_color,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (total == 0) {
      const snackBar = SnackBar(
        content: Text('Select Valid date and time'),
        backgroundColor: MyTheme.accent_color,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (selectedStation.value == "" || selectedStation.value == null) {
      const snackBar = SnackBar(
        content: Text('Please select station'),
        backgroundColor: MyTheme.accent_color,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    Get.to(
      () => CheckoutPage(
        imageUrl: imageFile.value,
        startTime: startDateTime.value,
        endTime: endDateTime.value,
        station: selectedStation.value!.name ?? '',
        totalPayableAmount:
            total.value == 0 ? price.value.toString() : total.value.toString(),
        lat: selectedStation.value!.lat!,
        long: selectedStation.value!.lon!,
        name: bikeTitle.value,
        id: bikeId,
        weekEndPrice: 0,
        kmLimit: kmLimit.value,
        vehicleNumber: bikeDetails!.vehicleNumber ?? '',
        discount: double.parse(bikeDetails!.discountPrice ?? '0.0').toInt(),
      ),
    );
  }

  void calculatePrice() {
    if (startDateTime.isNotEmpty && endDateTime.isNotEmpty) {
      DateTime start =
          DateFormat('MMM d, yyyy h:mm a').parse(startDateTime.value);
      DateTime end = DateFormat('MMM d, yyyy h:mm a').parse(endDateTime.value);
      Duration difference = end.difference(start);

      double hourlyRate = double.parse(bikeDetails!.hoursPrice!.price!);
      double hourWeekEndRate =
          double.parse(bikeDetails!.hoursPrice!.hourWeekendPrice!);
      double convertWeekendPrice =
          double.parse(bikeDetails!.weekendPrice!.toString());
      double convertHourWeekendPrice =
          double.parse(bikeDetails!.hoursPrice!.hourWeekendPrice ?? '0');
      double hourlyWeekEndRate = hourlyRate + convertHourWeekendPrice;
      double dailyRate = double.parse(bikeDetails!.daysPrice!.price!);
      double dailyWeekEndRate = dailyRate + convertWeekendPrice;
      double weeklyRate = double.parse(bikeDetails!.weekPrice!.price!);
      double monthlyRate = double.parse(bikeDetails!.monthPrice!.price!);
      double hourlyKmLimit = double.parse(bikeDetails!.hoursPrice!.kmLimit!);
      double dailyKmLimit = double.parse(bikeDetails!.daysPrice!.kmLimit!);
      double weeklyKmLimit = double.parse(bikeDetails!.weekPrice!.kmLimit!);
      double monthlyKmLimit = double.parse(bikeDetails!.monthPrice!.kmLimit!);
      double calculatedPrice = 0.0;
      double totalKmLimit = 0.0;

      try {
        int totalMonths = (difference.inDays / 30).floor();
        int remainingDaysAfterMonths = difference.inDays % 30;

        int totalWeeks = (remainingDaysAfterMonths / 7).floor();
        int remainingDaysAfterWeeks = remainingDaysAfterMonths % 7;

        int totalDays = remainingDaysAfterWeeks;
        int totalHours = difference.inHours % 24;

        calculatedPrice =
            (totalMonths * monthlyRate) + (totalWeeks * weeklyRate);

        for (int i = 0; i < totalDays; i++) {
          DateTime currentDay = start.add(Duration(days: i));
          bool isWeekendDay = currentDay.weekday == DateTime.friday ||
              currentDay.weekday == DateTime.saturday ||
              currentDay.weekday == DateTime.sunday;

          double currentDailyRate = isWeekendDay ? dailyWeekEndRate : dailyRate;
          calculatedPrice += currentDailyRate;
        }

        if (totalMonths == 0 &&
            totalWeeks == 0 &&
            totalDays == 0 &&
            totalHours > 0) {
          bool isStartingOnWeekend = start.weekday == DateTime.friday ||
              start.weekday == DateTime.saturday ||
              start.weekday == DateTime.sunday;
          calculatedPrice = (totalMonths * monthlyRate) +
              (totalWeeks * weeklyRate) +
              (totalDays * dailyRate) +
              (totalHours * hourlyRate);
          if (isStartingOnWeekend) {
            calculatedPrice += hourWeekEndRate;
          }
        } else if ((totalMonths != 0 || totalWeeks != 0 || totalDays != 0) &&
            totalHours > 0) {
          for (int i = 0; i < totalHours; i++) {
            DateTime currentHour = end.add(Duration(hours: i));
            bool isWeekendHour = currentHour.weekday == DateTime.friday ||
                currentHour.weekday == DateTime.saturday ||
                currentHour.weekday == DateTime.sunday;
            double currentHourlyRate =
                isWeekendHour ? hourlyWeekEndRate : hourlyRate;
            calculatedPrice += currentHourlyRate;
          }
        }

        if (totalMonths > 0) {
          totalKmLimit += totalMonths * monthlyKmLimit;
        }
        if (totalWeeks > 0) {
          totalKmLimit += totalWeeks * weeklyKmLimit;
        }
        if (totalDays > 0) {
          totalKmLimit += totalDays * dailyKmLimit;
        }
        if (totalHours > 0) {
          totalKmLimit += totalHours * hourlyKmLimit;
        }
      } catch (e) {
        return;
      }

      total.value = calculatedPrice.toInt();
      kmLimit.value = totalKmLimit.toInt();
      update();
    }
  }

  void changeIndex(index) {
    currentImage.value = index;
    update();
  }

  void onTapDone(BuildContext context) {
    if (startDateTime.isNotEmpty && endDateTime.isNotEmpty) {
      DateTime start =
          DateFormat('MMM d, yyyy h:mm a').parse(startDateTime.value);
      DateTime end = DateFormat('MMM d, yyyy h:mm a').parse(endDateTime.value);
      Duration difference = end.difference(start);

      bool isWeekend(DateTime date) {
        return date.weekday == DateTime.friday ||
            date.weekday == DateTime.saturday ||
            date.weekday == DateTime.sunday;
      }

      bool includesWeekend(DateTime start, DateTime end) {
        DateTime currentDate = start;
        while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
          if (isWeekend(currentDate)) {
            return true;
          }
          currentDate = currentDate.add(Duration(days: 1));
        }
        return false;
      }

      bool isValidSelection(Duration duration) {
        bool hasWeekend = includesWeekend(start, end);
        int minHours = hasWeekend
            ? int.parse(bikeDetails!.hoursPrice!.hourWeekendLimit!)
            : int.parse(bikeDetails!.hoursPrice!.hourLimit!);
        return duration.inHours >= minHours;
      }

      if (isValidSelection(difference)) {
        calculatePrice();
      } else {
        endDateTime.value = '';
        startDateTime.value = '';
        endTimeCon.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'The rental period must be at least ${includesWeekend(start, end) ? int.parse(bikeDetails!.hoursPrice!.hourWeekendLimit!) : int.parse(bikeDetails!.hoursPrice!.hourLimit!)} hours.'),
          backgroundColor: MyTheme.accent_color,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ));
      }
    }
  }

  void clearData() {
    startDateTime.value = '';
    endDateTime.value = '';
    startDateCon.clear();
    startTimeCon.clear();
    endDateCon.clear();
    endTimeCon.clear();
    kmLimit.value = 0;
    total.value = 0;
    selectedStation.value = null;
  }
}
