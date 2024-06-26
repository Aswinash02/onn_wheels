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
  DateTime? _startDateTime;

  DateTime? _endDateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SfDateRangePicker(
          //   cellBuilder:
          //       (BuildContext context, DateRangePickerCellDetails details) {
          //     return Container(
          //         margin: EdgeInsets.all(0),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 15.0, vertical: 8),
          //           child: Container(
          //             child: Center(
          //               child: Text(
          //                 details.date.day.toString(),
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontWeight: FontWeight.normal,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ));
          //   },
          //
          //   // This highlights today's date with a circle
          //
          //   onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          //     setState(() {
          //       if (args.value is PickerDateRange) {
          //         // bikeDetailsController.startDateTime =
          //         _startDateTime = DateTime(
          //           args.value.startDate.year,
          //           args.value.startDate.month,
          //           args.value.startDate.day,
          //           DateTime.now().hour,
          //           DateTime.now().minute,
          //         );
          //         String startDateTime =
          //             DateFormat('MMMM d, yyyy h:mm a').format(_startDateTime!);
          //         bikeDetailsController.startDateTime.value = startDateTime;
          //         if (args.value.endDate != null) {
          //           _endDateTime = DateTime(
          //             args.value.endDate.year,
          //             args.value.endDate.month,
          //             args.value.endDate.day,
          //             DateTime.now().hour + 24,
          //             DateTime.now().minute,
          //           );
          //           String endDateTime =
          //               DateFormat('MMMM d, yyyy h:mm a').format(_endDateTime!);
          //           bikeDetailsController.endDateTime.value = endDateTime;
          //         }
          //       }
          //     });
          //   },
          //   selectionMode: DateRangePickerSelectionMode.range,
          //   minDate: DateTime.now(),
          // ),
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
                  // bikeDetailsController.startDateTime =
                  _startDateTime = DateTime(
                    args.value.startDate.year,
                    args.value.startDate.month,
                    args.value.startDate.day,
                    DateTime.now().hour,
                    DateTime.now().minute,
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
                      DateTime.now().minute,
                    );
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
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (time) {
                        setState(() {
                          _startDateTime = DateTime(
                            _startDateTime!.year,
                            _startDateTime!.month,
                            _startDateTime!.day,
                            time.hour,
                            time.minute,
                          );

                          // String formattedDateTime = DateFormat.yMMMMEEEEd()
                          //     .add_jm()
                          //     .format(_startDateTime!);
                          String startDateTime =
                              DateFormat('MMMM d, yyyy h:mm a')
                                  .format(_startDateTime!);
                          bikeDetailsController.startDateTime.value =
                              startDateTime.toString();
                        });
                      },
                      currentTime: DateTime.now(),
                    );
                  },
            child: Text('Select Start Time'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _endDateTime == null
                ? null
                : () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (time) {
                        setState(() {
                          _endDateTime = DateTime(
                            _endDateTime!.year,
                            _endDateTime!.month,
                            _endDateTime!.day,
                            time.hour,
                            time.minute,
                          );
                          // String endDateTime = DateFormat.yMMMMEEEEd()
                          //     .add_jm()
                          //     .format(_endDateTime!);
                          String endDateTime = DateFormat('MMMM d, yyyy h:mm a')
                              .format(_endDateTime!);

                          bikeDetailsController.endDateTime.value = endDateTime;
                        });
                      },
                      currentTime: DateTime.now(),
                    );
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
              Navigator.pop(context);
            },
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
