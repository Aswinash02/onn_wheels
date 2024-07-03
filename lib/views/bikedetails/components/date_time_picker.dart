import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateTimeRangePicker extends StatefulWidget {
  @override
  _DateTimeRangePickerState createState() => _DateTimeRangePickerState();
}

class _DateTimeRangePickerState extends State<DateTimeRangePicker> {
  final BikeDetailsController bikeDetailsController =
      Get.find<BikeDetailsController>();

  DateTime? _endDateTime;

  DateTime? _startDateTime;

  void _showCustomTimePicker(String destination) async {
    final TimeOfDay? picked = await showCustomTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
    );
    if (picked != null) {
      if (destination == 'startTime') {
        setState(() {
          int roundedMinute = _roundToNearest15(picked.minute);
          _startDateTime = DateTime(
            _startDateTime?.year ?? DateTime.now().year,
            _startDateTime?.month ?? DateTime.now().month,
            _startDateTime?.day ?? DateTime.now().day,
            picked.hour,
            roundedMinute,
          );
          String startDateTime =
              DateFormat('MMMM d, yyyy h:mm a').format(_startDateTime!);
          bikeDetailsController.startDateTime.value = startDateTime.toString();
        });
      } else {
        setState(() {
          int roundedMinute = _roundToNearest15(picked.minute);
          _endDateTime = DateTime(
            _endDateTime?.year ?? DateTime.now().year,
            _endDateTime?.month ?? DateTime.now().month,
            _endDateTime?.day ?? DateTime.now().day,
            picked.hour,
            roundedMinute,
          );
          String endDateTime =
              DateFormat('MMMM d, yyyy h:mm a').format(_endDateTime!);

          bikeDetailsController.endDateTime.value = endDateTime.toString();
        });
      }
    }
  }

  int _roundToNearest15(int minute) {
    if (minute == 00) return 00;
    if (minute <= 15) return 15;
    if (minute <= 30) return 30;
    if (minute <= 45) return 45;
    return 0;
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SfDateRangePicker(
            cellBuilder:
                (BuildContext context, DateRangePickerCellDetails details) {
              bool isToday = details.date.year == DateTime.now().year &&
                  details.date.month == DateTime.now().month &&
                  details.date.day == DateTime.now().day;

              return Container(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isToday
                      ? Colors.deepPurple
                      : Colors.transparent, // Highlight the current date
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: Container(
                    child: Center(
                      child: Text(
                        details.date.day.toString(),
                        style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          // Change text color for current date
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              setState(() {
                if (args.value is PickerDateRange) {
                  _startDateTime = DateTime(
                    args.value.startDate.year,
                    args.value.startDate.month,
                    args.value.startDate.day,
                    DateTime.now().hour,
                    _roundToNearest15(DateTime.now().minute),
                  );
                  String startDateTime =
                      DateFormat('MMMM d, yyyy h:mm a').format(_startDateTime!);
                  bikeDetailsController.startDateTime.value = startDateTime;
                  if (args.value.endDate != null) {
                    _endDateTime = DateTime(
                        args.value.endDate.year,
                        args.value.endDate.month,
                        args.value.endDate.day,
                        DateTime.now().hour,
                        _roundToNearest15(DateTime.now().minute));
                    String endDateTime =
                        DateFormat('MMMM d, yyyy h:mm a').format(_endDateTime!);
                    bikeDetailsController.endDateTime.value = endDateTime;
                  }
                }
              });
            },
            selectionMode: DateRangePickerSelectionMode.range,
            minDate: DateTime.now(),
            monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderHeight: 50,
              dayFormat: 'EEE',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _startDateTime == null
                ? null
                : () {
                    _showCustomTimePicker('startTime');
                  },
            child: Text('Select Start Time'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _endDateTime == null
                ? null
                : () {
                    _showCustomTimePicker('endTime');
                  },
            child: Text('Select End Time'),
          ),
          SizedBox(height: 20),
          Obx(
            () => CustomText(
              text: bikeDetailsController.endDateTime == ""
                  ? 'Start DateTime : Not selected'
                  : 'Start DateTime : ${bikeDetailsController.startDateTime.value}',
            ),
          ),
          Obx(
            () => CustomText(
              text: bikeDetailsController.endDateTime == ""
                  ? 'End DateTime : Not selected'
                  : 'End DateTime : ${bikeDetailsController.endDateTime.value}',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              bikeDetailsController.calculatePrice(0);
              Navigator.pop(context);
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

// class TimePickerPage extends StatefulWidget {
//   @override
//   _TimePickerPageState createState() => _TimePickerPageState();
// }
//
// class _TimePickerPageState extends State<TimePickerPage> {
//   DateTime? _startDateTime;
//   final bikeDetailsController = BikeDetailsController();
//
//   void _showCustomTimePicker() async {
//     final TimeOfDay? picked = await showCustomTimePicker(
//       context: context,
//       initialTime: TimeOfDay.fromDateTime(_startDateTime ?? DateTime.now()),
//     );
//     if (picked != null) {
//       setState(() {
//         int roundedMinute = _roundToNearest15(picked.minute);
//         _startDateTime = DateTime(
//           _startDateTime?.year ?? DateTime.now().year,
//           _startDateTime?.month ?? DateTime.now().month,
//           _startDateTime?.day ?? DateTime.now().day,
//           picked.hour,
//           roundedMinute,
//         );
//         String startDateTime =
//             DateFormat('MMMM d, yyyy h:mm a').format(_startDateTime!);
//         bikeDetailsController.startDateTime.value = startDateTime.toString();
//       });
//     }
//   }
//
//   int _roundToNearest15(int minute) {
//     if (minute < 15) return 15;
//     if (minute < 30) return 30;
//     if (minute < 45) return 45;
//     return 0;
//   }
//
//   Future<TimeOfDay?> showCustomTimePicker({
//     required BuildContext context,
//     required TimeOfDay initialTime,
//   }) {
//     return showDialog<TimeOfDay>(
//       context: context,
//       builder: (BuildContext context) {
//         return CustomTimePickerDialog(initialTime: initialTime);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Custom Time Picker Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Selected time: ${_startDateTime != null ? DateFormat('MMMM d, yyyy h:mm a').format(_startDateTime!) : 'None'}',
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _showCustomTimePicker,
//               child: Text('Select Time'),
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
    selectedHour = widget.initialTime.hourOfPeriod == 0
        ? 12
        : widget.initialTime.hourOfPeriod;
    selectedMinute = _roundToNearest15(widget.initialTime.minute);
    selectedPeriod = widget.initialTime.period == DayPeriod.am ? "AM" : "PM";
  }

  int _roundToNearest15(int minute) {
    if (minute < 15) return 15;
    if (minute < 30) return 30;
    if (minute < 45) return 45;
    return 0;
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
                  onChanged: (value) {
                    setState(() {
                      print('value 1============ >  $value');
                      selectedHour = value!;
                      // _startDateTime = DateTime(
                      //     _startDateTime!.year,
                      //     _startDateTime!.month,
                      //     _startDateTime!.day,
                      //     selectedHour,
                      //     selectedMinute);
                      // String startDateTime = DateFormat('MMMM d, yyyy h:mm a')
                      //     .format(_startDateTime!);
                      // bikeDetailsController.startDateTime.value =
                      //     startDateTime.toString();
                    });
                  },
                ),
                DropdownButton<int>(
                  value: selectedMinute,
                  items: [0, 15, 30, 45].map((minute) {
                    return DropdownMenuItem(
                      value: minute,
                      child: Text(minute.toString().padLeft(2, '0')),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      print('value ============ >  $value');
                      selectedMinute = value!;
                    });
                    // _startDateTime = DateTime(
                    //     _startDateTime!.year,
                    //     _startDateTime!.month,
                    //     _startDateTime!.day,
                    //     selectedHour,
                    //     selectedMinute);
                    // String startDateTime = DateFormat('MMMM d, yyyy h:mm a')
                    //     .format(_startDateTime!);
                    // bikeDetailsController.startDateTime.value =
                    //     startDateTime.toString();
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
