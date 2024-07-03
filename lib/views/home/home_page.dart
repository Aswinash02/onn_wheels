import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/repositories/product_repositories.dart';
import 'package:onnwheels/utils/image_directory.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/bikedetails/components/date_time_picker.dart';
import 'package:onnwheels/views/home/components/custom_gridview.dart';
import '../../controllers/home_controller.dart';
import '../../mytheme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  // final HomeController homeController = Get.find();
  TextEditingController dateCtl1 = TextEditingController();
  TextEditingController dateCtl2 = TextEditingController();
  TextEditingController timeCtl1 = TextEditingController();
  TextEditingController timeCtl2 = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  int _page = 1;
  bool _showLoadingContainer = false;
  ScrollController _scrollController = ScrollController();

  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);

  Future<void> _selectTime(BuildContext context, timeData) async {
    final TimeOfDay? picked = await showCustomTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        timeData.text = "${picked.format(context)}";
      });
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

  Future displayDatePicker(
      BuildContext context, dateValue, dateValueApi) async {
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100)) as DateTime;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateFormat formatDate = DateFormat('MMMM dd, yyyy hh:mm a');
    dateValue.text = formatter.format(date);
    dateValueApi = formatDate.format(date);
    setState(() {});
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
    super.initState();
  }

  fetchUserName() async {
    SharedPreference sharedPreference = SharedPreference();
    homeController.userName.value = await sharedPreference.getUserName();
    homeController.userId.value = await sharedPreference.getUserId();
    homeController.userEmail.value = await sharedPreference.getUserEmail();
    homeController.userPhone.value = await sharedPreference.getUserPhoneNo();
    print(
        "fetching User Details=======>${homeController.userName.value},${homeController.userId.value}, ${homeController.userEmail.value} ${homeController.userPhone.value}");
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
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.date_range),
                                        hintText: "Select Date",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 10),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
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
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.access_time),
                                        hintText: "Select time",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 10),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        _selectTime(context, timeCtl1);
                                        // await displayTimePicker(
                                        //     context, timeCtl1);
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
                                    child: TextFormField(
                                      controller: dateCtl2,
                                      textAlign: TextAlign.start,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.date_range),
                                        hintText: "Select Date",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 10),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        await displayDatePicker(
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
                                    child: TextFormField(
                                      controller: timeCtl2,
                                      readOnly: true,
                                      textAlign: TextAlign.start,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.access_time),
                                        hintText: "Select time",
                                        hintStyle: TextStyle(
                                            color: MyTheme.grey_153,
                                            fontSize: 14),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 1, horizontal: 10),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      onTap: () async {
                                        _selectTime(context, timeCtl2);
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
                                    child: Container(
                                      width: 248,
                                      height: 37,
                                      decoration: BoxDecoration(
                                        color: MyTheme.accent_color,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Search",
                                          style: TextStyle(
                                              color: MyTheme.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      if (dateCtl1.text.isEmpty) {
                                        const snackdemo = SnackBar(
                                          content:
                                              Text('Please select Pickup Date'),
                                          backgroundColor: MyTheme.accent_color,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackdemo);
                                        return;
                                      }
                                      if (dateCtl2.text.isEmpty) {
                                        const snackdemo = SnackBar(
                                          content:
                                              Text('Please select Drop Date'),
                                          backgroundColor: MyTheme.accent_color,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackdemo);
                                        return;
                                      }
                                      if (timeCtl1.text.isEmpty) {
                                        const snackdemo = SnackBar(
                                          content:
                                              Text('Please select Pickup Time'),
                                          backgroundColor: MyTheme.accent_color,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackdemo);
                                        return;
                                      }
                                      if (timeCtl2.text.isEmpty) {
                                        const snackdemo = SnackBar(
                                          content:
                                              Text('Please select Drop Time'),
                                          backgroundColor: MyTheme.accent_color,
                                          elevation: 10,
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.all(5),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackdemo);
                                        return;
                                      }
                                      homeController.getSearchProductsHome(
                                          startDate:
                                              homeController.dateValue1.value,
                                          startTime: timeCtl1.text,
                                          endDate:
                                              homeController.dateValue2.value,
                                          endTime: timeCtl2.text);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => CustomWidget.buildSearchListProduct(
                            context, homeController.searchBikeProducts),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "All Products",
                          style: TextStyle(
                              color: Color(0XFF003361),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Obx(
                        () => CustomWidget.buildCustomGridView(
                            context, homeController.allBikeProducts),
                      ),
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
