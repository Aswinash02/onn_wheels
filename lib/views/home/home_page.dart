import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/repositories/product_repositories.dart';
import 'package:onnwheels/utils/image_directory.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/bikedetails/components/date_time_picker.dart';
import 'package:onnwheels/views/home/components/custom_gridview.dart';
import 'package:onnwheels/views/home/components/filter_dialog.dart';
import '../../controllers/home_controller.dart';
import '../../mytheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  TextEditingController dateCtl1 = TextEditingController();
  TextEditingController dateCtl2 = TextEditingController();
  TextEditingController timeCtl1 = TextEditingController();
  TextEditingController timeCtl2 = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  int _page = 1;
  bool _showLoadingContainer = false;
  ScrollController _scrollController = ScrollController();

  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  DateTime? _endDateTime;

  DateTime? _startDateTime;

  Future<void> _selectTime(
      BuildContext context, TextEditingController timeData, String des) async {
    final TimeOfDay? picked = await showCustomTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      final now = DateTime.now();
      final pickedDateTime = DateTime(
          _startDateTime!.year,
          _startDateTime!.month,
          _startDateTime!.day,
          picked.hour,
          picked.minute);
      print('pickedDateTime ${pickedDateTime}');
      print(' picked.hour, ${picked.hour}');
      print('picked.minute ${picked.minute}');
      print('now ${now}');
      if (pickedDateTime.isBefore(now)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Pick Valid Date & Time'),
          backgroundColor: MyTheme.accent_color,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        ));
        return;
      }

      setState(() {
        selectedTime = picked;
        timeData.text = picked.format(context);
      });
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

  Future<void> displayDatePicker(BuildContext context,
      TextEditingController dateValue, dateValueApi) async {
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
      },
    );

    if (date != null) {
      final DateFormat formatter = DateFormat('MMM dd yyyy');
      final DateFormat formatDate = DateFormat('MMMM dd, yyyy hh:mm a');

      dateValue.text = formatter.format(date);
      dateValueApi = formatDate.format(date);
      _startDateTime = date;

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        homeController.getAllProductsHome();
      }
    });
    fetchUserName();
    homeController.fetchFilterDropDownData();
    super.initState();
  }

  fetchUserName() async {
    SharedPreference sharedPreference = SharedPreference();
    homeController.userName.value = await sharedPreference.getUserName();
    homeController.userId.value = await sharedPreference.getUserId();
    homeController.userEmail.value = await sharedPreference.getUserEmail();
    homeController.userPhone.value = await sharedPreference.getUserPhoneNo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        title: Text(
          "ONN WHEELS",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/app_logo.png"),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(ImageDirectory.home_main),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        height: 310,
                        width: 380,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0XFFF89520),
                              Color(0XFF003361),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Book Your Next Ride",
                              style: TextStyle(
                                color: MyTheme.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
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
                                    // width: 160,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: MyTheme.white),
                                    child: TextFormField(
                                      controller: dateCtl1,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 14),
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: MyTheme.orange,
                                        ),
                                        hintText: "Select Date",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 6),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        dateCtl2.clear();
                                        timeCtl1.clear();
                                        timeCtl2.clear();
                                        await displayDatePicker(
                                            context,
                                            dateCtl1,
                                            homeController.dateValue1);
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
                                    child: TextFormField(
                                      controller: timeCtl1,
                                      readOnly: true,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.access_time,
                                          color: MyTheme.orange,
                                        ),
                                        hintText: "Select time",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 6),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        dateCtl2.clear();
                                        timeCtl2.clear();
                                        dateCtl1.text.isEmpty
                                            ? null
                                            : _selectTime(
                                                context, timeCtl1, 'startTime');
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
                                      controller: dateCtl2,
                                      textAlign: TextAlign.start,
                                      readOnly: true,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: MyTheme.orange,
                                        ),
                                        hintText: "Select Date",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 6),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        timeCtl2.clear();
                                        timeCtl1.text.isEmpty
                                            ? null
                                            : await displayDatePicker(
                                                context,
                                                dateCtl2,
                                                homeController.dateValue2);
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
                                      controller: timeCtl2,
                                      readOnly: true,
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.access_time,
                                          color: MyTheme.orange,
                                        ),
                                        hintText: "Select time",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 6),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        dateCtl2.text.isEmpty
                                            ? null
                                            : _selectTime(
                                                context, timeCtl2, 'endTime');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Obx(
                                      () => Container(
                                        width: 248,
                                        height: 37,
                                        decoration: BoxDecoration(
                                          color: MyTheme.accent_color,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: homeController.loading.value
                                              ? SizedBox(
                                                  height: 18,
                                                  width: 18,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2,
                                                  ),
                                                )
                                              : Text(
                                                  "Search",
                                                  style: TextStyle(
                                                      color: MyTheme.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                        ),
                                      ),
                                    ),
                                    onTap: homeController.loading.value
                                        ? null
                                        : () {
                                            if (dateCtl1.text.isEmpty) {
                                              const snackdemo = SnackBar(
                                                content: Text(
                                                    'Please select Pickup Date'),
                                                backgroundColor:
                                                    MyTheme.accent_color,
                                                elevation: 10,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackdemo);
                                              return;
                                            }
                                            if (dateCtl2.text.isEmpty) {
                                              const snackdemo = SnackBar(
                                                content: Text(
                                                    'Please select Drop Date'),
                                                backgroundColor:
                                                    MyTheme.accent_color,
                                                elevation: 10,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackdemo);
                                              return;
                                            }
                                            if (timeCtl1.text.isEmpty) {
                                              const snackdemo = SnackBar(
                                                content: Text(
                                                    'Please select Pickup Time'),
                                                backgroundColor:
                                                    MyTheme.accent_color,
                                                elevation: 10,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackdemo);
                                              return;
                                            }
                                            if (timeCtl2.text.isEmpty) {
                                              const snackdemo = SnackBar(
                                                content: Text(
                                                    'Please select Drop Time'),
                                                backgroundColor:
                                                    MyTheme.accent_color,
                                                elevation: 10,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(5),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackdemo);
                                              return;
                                            }
                                            homeController
                                                .getSearchProductsHome(
                                                    startDate: homeController
                                                        .dateValue1.value,
                                                    startTime: timeCtl1.text,
                                                    endDate: homeController
                                                        .dateValue2.value,
                                                    endTime: timeCtl2.text);
                                          },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(() => homeController.searchBikeProducts.length > 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                "Search Vehicles",
                                style: TextStyle(
                                    color: Color(0XFF003361),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : SizedBox()),
                      Obx(
                        () => CustomWidget.buildSearchListProduct(
                            context, homeController.searchBikeProducts),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "All Vehicles",
                              style: TextStyle(
                                  color: Color(0XFF003361),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                _showFilterDialog(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0),
                                child: Icon(
                                  Icons.filter_list,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<HomeController>(builder: (controller) {
                        return controller.isFilter
                            ? CustomWidget.buildCustomGridView(
                                context, homeController.filterBikeList)
                            : CustomWidget.buildCustomGridView(
                                context, homeController.allBikeProducts);
                      })
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _showFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FilterDialog();
    },
  );
}

Future<void> displayTimePicker(
    BuildContext context, TextEditingController timeData) async {
  var time = await showDialog<TimeOfDay>(
    context: context,
    builder: (BuildContext context) {
      return CustomTimePickerDialog(
        initialTime: TimeOfDay.now(),
      );
    },
  );

  if (time != null) {
    timeData.text = "${time.format(context)}";
  }
}

// class CustomTimePickerDialog extends StatefulWidget {
//   final TimeOfDay initialTime;
//
//   CustomTimePickerDialog({required this.initialTime});
//
//   @override
//   _CustomTimePickerDialogState createState() => _CustomTimePickerDialogState();
// }
//
// class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
//   late int selectedHour;
//   late int selectedMinute;
//   late String selectedPeriod;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedHour = widget.initialTime.hourOfPeriod == 0
//         ? 12
//         : widget.initialTime.hourOfPeriod;
//     selectedMinute = _roundToNearest15(widget.initialTime.minute);
//     selectedPeriod = widget.initialTime.period == DayPeriod.am ? "AM" : "PM";
//   }
//
//   int _roundToNearest15(int minute) {
//     if (minute < 15) return 15;
//     if (minute < 30) return 30;
//     if (minute < 45) return 45;
//     return 0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 DropdownButton<int>(
//                   value: selectedHour,
//                   items: List.generate(12, (index) {
//                     int hour = index + 1;
//                     return DropdownMenuItem(
//                       value: hour,
//                       child: Text(hour.toString().padLeft(2, '0')),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       print('value 1============ >  $value');
//                       selectedHour = value!;
//                       // _startDateTime = DateTime(
//                       //     _startDateTime!.year,
//                       //     _startDateTime!.month,
//                       //     _startDateTime!.day,
//                       //     selectedHour,
//                       //     selectedMinute);
//                       // String startDateTime = DateFormat('MMMM d, yyyy h:mm a')
//                       //     .format(_startDateTime!);
//                       // bikeDetailsController.startDateTime.value =
//                       //     startDateTime.toString();
//                     });
//                   },
//                 ),
//                 DropdownButton<int>(
//                   value: selectedMinute,
//                   items: [0, 15, 30, 45].map((minute) {
//                     return DropdownMenuItem(
//                       value: minute,
//                       child: Text(minute.toString().padLeft(2, '0')),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       print('value ============ >  $value');
//                       selectedMinute = value!;
//                     });
//                     // _startDateTime = DateTime(
//                     //     _startDateTime!.year,
//                     //     _startDateTime!.month,
//                     //     _startDateTime!.day,
//                     //     selectedHour,
//                     //     selectedMinute);
//                     // String startDateTime = DateFormat('MMMM d, yyyy h:mm a')
//                     //     .format(_startDateTime!);
//                     // bikeDetailsController.startDateTime.value =
//                     //     startDateTime.toString();
//                   },
//                 ),
//                 DropdownButton<String>(
//                   value: selectedPeriod,
//                   items: ["AM", "PM"].map((period) {
//                     return DropdownMenuItem(
//                       value: period,
//                       child: Text(period),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedPeriod = value!;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               int hour = selectedHour % 12;
//               if (selectedPeriod == "PM") {
//                 hour += 12;
//               }
//               Navigator.pop(
//                   context, TimeOfDay(hour: hour, minute: selectedMinute));
//             },
//             child: Text('Confirm'),
//           ),
//         ],
//       ),
//     );
//   }
// }
