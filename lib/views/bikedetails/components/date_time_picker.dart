import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final int? minute;

  CustomTimePickerDialog({required this.initialTime, this.minute});

  @override
  _CustomTimePickerDialogState createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late int selectedHour;
  late int selectedMinute;
  late String selectedPeriod;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime newTime = now.add(Duration(hours: 1));
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(newTime);
    selectedHour = selectedTime.hourOfPeriod;
    selectedMinute = 00;
    selectedPeriod = selectedTime.period == DayPeriod.am ? "AM" : "PM";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<int>(
                  value: selectedHour,
                  items: List.generate(12, (index) {
                    int hour = index + 1;
                    return DropdownMenuItem(
                      value: hour,
                      child: Text(hour.toString().padLeft(2, '0')),
                    );
                  }).toList(),
                  underline: SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      selectedHour = value!;
                    });
                  },
                ),
                DropdownButton<int>(
                  value: selectedMinute,
                  items: [0, 30].map((minute) {
                    return DropdownMenuItem(
                      value: minute,
                      child: Text(minute.toString().padLeft(2, '0')),
                    );
                  }).toList(),
                  underline: SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      selectedMinute = value!;
                    });
                  },
                ),
                DropdownButton<String>(
                  value: selectedPeriod,
                  items: ["AM", "PM"].map((period) {
                    return DropdownMenuItem(
                      value: period,
                      child: Text(period),
                    );
                  }).toList(),
                  underline: SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      selectedPeriod = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              int hour = selectedHour % 12;
              if (selectedPeriod == "PM") {
                hour += 12;
              }
              Navigator.pop(
                  context, TimeOfDay(hour: hour, minute: selectedMinute));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                  color: MyTheme.accent_color,
                  borderRadius: BorderRadius.circular(3)),
              child: Text(
                'Confirm',
                style: TextStyle(color: MyTheme.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BikeDetailDateTimeRangePicker extends StatefulWidget {
  const BikeDetailDateTimeRangePicker({super.key});

  @override
  State<BikeDetailDateTimeRangePicker> createState() =>
      _BikeDetailDateTimeRangePickerState();
}

class _BikeDetailDateTimeRangePickerState
    extends State<BikeDetailDateTimeRangePicker> {
  final BikeDetailsController bikeDetailsController =
      Get.find<BikeDetailsController>();
  DateTime? _endDateTime;

  DateTime? _startDateTime;

  Future<void> displayDatePicker(String destination) async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: MyTheme.accent_color,
              hintColor: MyTheme.accent_color,
              colorScheme: ColorScheme.light(
                primary: MyTheme.accent_color,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    if (date != null) {
      final DateFormat formatDate = DateFormat('MMM dd yyyy');
      final String formattedDate = formatDate.format(date);
      final String formattedDateTime =
          DateFormat('MMM d, yyyy h:mm a').format(date);

      if (destination == "startDate") {
        bikeDetailsController.clearControllerData();
        _startDateTime = DateTime(date.year, date.month, date.day);
        bikeDetailsController.startDateTime.value = formattedDateTime;
        bikeDetailsController.startDateCon.text = formattedDate;
      } else {
        bikeDetailsController.endTimeCon.clear();

        _endDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          _startDateTime!.hour,
          0,
        );

        if (_endDateTime!.isBefore(_startDateTime!)) {
          bikeDetailsController.endDateCon.clear();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Pick Valid Date'),
            backgroundColor: MyTheme.accent_color,
            elevation: 10,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          ));
          return;
        }

        bikeDetailsController.endDateCon.text = formattedDate;
      }
      setState(() {});
    }
  }

  Future<TimeOfDay?> showCustomTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    required int minute,
  }) {
    return showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePickerDialog(
          initialTime: initialTime,
          minute: minute,
        );
      },
    );
  }

  void _showCustomTimePicker(String destination) async {
    final TimeOfDay? picked = await showCustomTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
        minute: _startDateTime!.minute);

    if (picked != null) {
      setState(() {
        if (destination == 'startTime') {
          DateTime selectedDateTime = DateTime(
            _startDateTime!.year,
            _startDateTime!.month,
            _startDateTime!.day,
            picked.hour,
            picked.minute,
          );
          bikeDetailsController.endTimeCon.clear();
          bikeDetailsController.endDateCon.clear();
          _startDateTime = selectedDateTime;

          String formattedStartDateTime =
              DateFormat('MMM d, yyyy h:mm a').format(_startDateTime!);
          bikeDetailsController.startTimeCon.text =
              DateFormat('h:mm a').format(_startDateTime!);
          if (_startDateTime!.isBefore(DateTime.now())) {
            bikeDetailsController.startTimeCon.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Pick Valid Date & Time'),
              backgroundColor: MyTheme.accent_color,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(5),
            ));
            return;
          }

          bikeDetailsController.startDateTime.value = formattedStartDateTime;
        } else {
          DateTime selectedDateTime = DateTime(
            _endDateTime!.year,
            _endDateTime!.month,
            _endDateTime!.day,
            picked.hour,
            picked.minute,
          );
          _endDateTime = selectedDateTime;
          String formattedEndDateTime =
              DateFormat('MMM d, yyyy h:mm a').format(_endDateTime!);
          bikeDetailsController.endTimeCon.text =
              DateFormat('h:mm a').format(_endDateTime!);
          if (_endDateTime!.isBefore(_startDateTime!)) {
            bikeDetailsController.endTimeCon.clear();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Pick Valid Date & Time'),
              backgroundColor: MyTheme.accent_color,
              elevation: 10,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(5),
            ));
            return;
          }
          bikeDetailsController.endDateTime.value = formattedEndDateTime;
          String formattedStartDateTime =
              DateFormat('MMM d, yyyy h:mm a').format(_startDateTime!);
          bikeDetailsController.startDateTime.value = formattedStartDateTime;
          bikeDetailsController.onTapDone(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyTheme.accent_color)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pick Date & Time",
            style: TextStyle(
              color: MyTheme.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => bikeDetailsController.startDateTime != '' &&
                    bikeDetailsController.endDateTime != ''
                ? CustomText(
                    text:
                        "${bikeDetailsController.startDateTime} - ${bikeDetailsController.endDateTime}",
                    color: Colors.black,
                  )
                : SizedBox(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Pickup",
            style: TextStyle(
              color: MyTheme.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyTheme.white),
                  child: TextField(
                    controller: bikeDetailsController.startDateCon,
                    textAlign: TextAlign.start,
                    readOnly: true,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: MyTheme.accent_color,
                        size: 18,
                      ),
                      hintText: "Select Date",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    onTap: () async {
                      await displayDatePicker("startDate");
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyTheme.white),
                  child: TextField(
                    controller: bikeDetailsController.startTimeCon,
                    readOnly: true,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: MyTheme.accent_color,
                        size: 18,
                      ),
                      hintText: "Select time",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    onTap: () async {
                      bikeDetailsController.endDateCon.clear();
                      bikeDetailsController.endTimeCon.clear();
                      bikeDetailsController.endDateTime.value = '';
                      if (bikeDetailsController.startDateCon.text.isEmpty) {
                        return;
                      }
                      _showCustomTimePicker('startTime');
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Drop",
            style: TextStyle(
              color: MyTheme.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyTheme.white),
                  child: TextField(
                    controller: bikeDetailsController.endDateCon,
                    textAlign: TextAlign.start,
                    readOnly: true,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: MyTheme.accent_color,
                        size: 18,
                      ),
                      hintText: "Select Date",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    onTap: () async {
                      if (bikeDetailsController.startTimeCon.text.isEmpty) {
                        return;
                      }
                      await displayDatePicker("endDate");
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyTheme.white),
                  child: TextField(
                    controller: bikeDetailsController.endTimeCon,
                    readOnly: true,
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.access_time,
                        color: MyTheme.accent_color,
                        size: 18,
                      ),
                      hintText: "Select time",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    onTap: () async {
                      if (bikeDetailsController.endDateCon.text.isEmpty) {
                        return;
                      }
                      _showCustomTimePicker('endTime');
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
