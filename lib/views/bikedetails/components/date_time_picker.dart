import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class DateTimeRangePicker extends StatefulWidget {
//   // const DateTimeRangePicker({required this.index});
//
//   // final int index;
//
//   @override
//   _DateTimeRangePickerState createState() => _DateTimeRangePickerState();
// }
//
// class _DateTimeRangePickerState extends State<DateTimeRangePicker> {
//   final BikeDetailsController bikeDetailsController =
//       Get.find<BikeDetailsController>();
//
//   DateTime? _endDateTime;
//
//   DateTime? _startDateTime;
//
//   Future<TimeOfDay?> showCustomTimePicker({
//     required BuildContext context,
//     required TimeOfDay initialTime,
//   }) {
//     print('initialTime ${DateTime.now()}');
//     return showDialog<TimeOfDay>(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomTimePickerDialog(
//           initialTime: TimeOfDay.fromDateTime(DateTime.now()),
//         );
//       },
//     );
//   }
//
//   void _showCustomTimePicker(String destination) async {
//     final TimeOfDay? picked = await showCustomTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
//     );
//     if (picked != null) {
//       if (destination == 'startTime') {
//         setState(() {
//           _startDateTime = DateTime(
//             _startDateTime?.year ?? DateTime.now().year,
//             _startDateTime?.month ?? DateTime.now().month,
//             _startDateTime?.day ?? DateTime.now().day,
//             picked.hour,
//             0,
//           );
//           String startDateTime =
//               DateFormat('MMM d, yyyy h:mm a').format(_startDateTime!);
//           bikeDetailsController.startDateTime.value = startDateTime.toString();
//         });
//       } else {
//         setState(() {
//           _endDateTime = DateTime(
//             _endDateTime?.year ?? DateTime.now().year,
//             _endDateTime?.month ?? DateTime.now().month,
//             _endDateTime?.day ?? DateTime.now().day,
//             picked.hour,
//             0,
//           );
//           String endDateTime =
//               DateFormat('MMM d, yyyy h:mm a').format(_endDateTime!);
//
//           bikeDetailsController.endDateTime.value = endDateTime.toString();
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: WillPopScope(
//         onWillPop: () async {
//           return false;
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SfDateRangePicker(
//               startRangeSelectionColor: MyTheme.orange,
//               endRangeSelectionColor: MyTheme.orange,
//               rangeSelectionColor: MyTheme.orange.withOpacity(0.1),
//               cellBuilder:
//                   (BuildContext context, DateRangePickerCellDetails details) {
//                 bool isToday = details.date.year == DateTime.now().year &&
//                     details.date.month == DateTime.now().month &&
//                     details.date.day == DateTime.now().day;
//
//                 return Container(
//                   margin: EdgeInsets.all(0),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isToday
//                         ? MyTheme.orange
//                         : Colors.transparent, // Highlight the current date
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                     child: Container(
//                       child: Center(
//                         child: Text(
//                           details.date.day.toString(),
//                           style: TextStyle(
//                             color: isToday ? Colors.white : Colors.black,
//                             fontWeight:
//                                 isToday ? FontWeight.bold : FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
//                 setState(() {
//                   if (args.value is PickerDateRange) {
//                     _startDateTime = DateTime(
//                         args.value.startDate.year,
//                         args.value.startDate.month,
//                         args.value.startDate.day,
//                         DateTime.now().hour,
//                         0);
//                     String startDateTime = DateFormat('MMM d, yyyy h:mm a')
//                         .format(_startDateTime!);
//                     bikeDetailsController.startDateTime.value = startDateTime;
//                     if (args.value.endDate != null) {
//                       _endDateTime = DateTime(
//                           args.value.endDate.year,
//                           args.value.endDate.month,
//                           args.value.endDate.day,
//                           DateTime.now().hour,
//                           0);
//                       String endDateTime = DateFormat('MMM d, yyyy h:mm a')
//                           .format(_endDateTime!);
//                       bikeDetailsController.endDateTime.value = endDateTime;
//                     }
//                   }
//                 });
//               },
//               selectionMode: DateRangePickerSelectionMode.range,
//               minDate: DateTime.now(),
//               monthViewSettings: DateRangePickerMonthViewSettings(
//                 viewHeaderHeight: 50,
//                 dayFormat: 'EEE',
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _startDateTime == null
//                   ? null
//                   : () {
//                       _showCustomTimePicker('startTime');
//                     },
//               child: Text('Select Start Time'),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _endDateTime == null
//                   ? null
//                   : () {
//                       _showCustomTimePicker('endTime');
//                     },
//               child: Text('Select End Time'),
//             ),
//             SizedBox(height: 20),
//             Obx(
//               () => CustomText(
//                 text: bikeDetailsController.endDateTime == ""
//                     ? 'Start DateTime : Not selected'
//                     : 'Start DateTime : ${bikeDetailsController.startDateTime.value}',
//               ),
//             ),
//             Obx(
//               () => CustomText(
//                 text: bikeDetailsController.endDateTime == ""
//                     ? 'End DateTime : Not selected'
//                     : 'End DateTime : ${bikeDetailsController.endDateTime.value}',
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateColor.resolveWith((states) => Colors.red),
//                   ),
//                   onPressed: () {
//                     bikeDetailsController.startDateTime.value = '';
//                     bikeDetailsController.endDateTime.value = '';
//                     Navigator.pop(context);
//                   },
//                   child: Text('Cancel'),
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateColor.resolveWith(
//                         (states) => MyTheme.orange),
//                   ),
//                   onPressed: () {
//                     bikeDetailsController.onTapDone(context);
//                   },
//                   child: Text('Done'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;

  CustomTimePickerDialog({required this.initialTime});

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
                      print('value 1============ >  $value');
                      selectedHour = value!;
                    });
                  },
                ),
                Text(
                  "00",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 6,
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
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => MyTheme.orange),
            ),
            onPressed: () {
              int hour = selectedHour % 12;
              if (selectedPeriod == "PM") {
                hour += 12;
              }
              Navigator.pop(
                  context, TimeOfDay(hour: hour, minute: selectedMinute));
            },
            child: Text('Confirm'),
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
              primaryColor: MyTheme.orange,
              hintColor: MyTheme.orange,
              colorScheme: ColorScheme.light(
                primary: MyTheme.orange,
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
        bikeDetailsController.clearData();
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
      print(
          'bikeDetailsController--------- > ${bikeDetailsController.selectedIndex}');
      setState(() {});
      print(
          'bikeDetailsController-----after ---- > ${bikeDetailsController.selectedIndex}');
    }
  }

  Future<TimeOfDay?> showCustomTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
  }) {
    return showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return CustomTimePickerDialog(initialTime: initialTime);
      },
    );
  }

  void _showCustomTimePicker(String destination) async {
    final TimeOfDay? picked = await showCustomTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
    );

    if (picked != null) {
      setState(() {
        if (destination == 'startTime') {
          DateTime selectedDateTime = DateTime(
            _startDateTime!.year,
            _startDateTime!.month,
            _startDateTime!.day,
            picked.hour,
            0,
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
            0,
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
          border: Border.all(color: MyTheme.orange)),
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
                        color: Color(0XFF000080),
                        size: 18,
                      ),
                      hintText: "Select Date",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 4),
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
                        color: Color(0XFF000080),
                        size: 18,
                      ),
                      hintText: "Select time",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 4),
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
                        color: Color(0XFF000080),
                        size: 18,
                      ),
                      hintText: "Select Date",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 4),
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
                        color: Color(0XFF000080),
                        size: 18,
                      ),
                      hintText: "Select time",
                      hintStyle:
                          TextStyle(color: MyTheme.grey_153, fontSize: 14),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 4),
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
