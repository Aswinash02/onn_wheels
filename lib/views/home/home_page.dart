import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onnwheels/utils/image_directory.dart';
import 'package:onnwheels/views/home/components/custom_gridview.dart';
import 'package:onnwheels/views/zone_areas/zone_list.dart';
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

  Future displayTimePicker(BuildContext context, timeData) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);
    if (time != null) {
      setState(() {
        timeData.text = "${time.hour}:${time.minute}";
        print("time data======>${timeData}");
      });
    }
  }

  Future displayDatePicker(BuildContext context, dateValue) async {
    DateTime date = DateTime(1900);
    FocusScope.of(context).requestFocus(FocusNode());
    date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)) as DateTime;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    if (date != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      dateValue.text = formatter.format(date);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        homeController.getAllProductsHome(page: _page);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Obx(
                () => DropdownButton<String>(
                  // Value will hold the selected city
                  value: homeController.selectedCity.value.isEmpty
                      ? null
                      : homeController.selectedCity.value,
                  // Called when the user selects an item
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      homeController.selectCity(newValue);
                    }
                  },
                  // Map each city to a DropdownMenuItem
                  items: homeController.tamilNaduCities
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    () => ZoneAreasPage(),
                  );
                },
                child: Text("Select Zone"),
              ),
            ],
          ),
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
                              Color(0XFFACA6F3),
                              Color(0XFFD25858),
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
                                Container(
                                  width: 160,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyTheme.white),
                                  child: TextFormField(
                                    controller: dateCtl1,
                                    textAlign: TextAlign.start,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.date_range),
                                      hintText: "Select Date",
                                      hintStyle: TextStyle(
                                          color: MyTheme.grey_153,
                                          fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 10),
                                      border: InputBorder.none,
                                      // This removes the border
                                      enabledBorder: InputBorder.none,
                                      // Optional: removes the border when enabled
                                      focusedBorder: InputBorder.none,
                                      // Optional: removes the border when focused
                                      errorBorder: InputBorder.none,
                                      // Optional: removes the border when an error is displayed
                                      disabledBorder: InputBorder.none,
                                      // Optional: removes the border when disabled
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      await displayDatePicker(
                                          context, dateCtl1);
                                    },
                                  ),
                                ),
                                Container(
                                  width: 160,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyTheme.white),
                                  child: TextFormField(
                                    controller: timeCtl1,
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
                                      // This removes the border
                                      enabledBorder: InputBorder.none,
                                      // Optional: removes the border when enabled
                                      focusedBorder: InputBorder.none,
                                      // Optional: removes the border when focused
                                      errorBorder: InputBorder.none,
                                      // Optional: removes the border when an error is displayed
                                      disabledBorder: InputBorder.none,
                                      // Optional: removes the border when disabled
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      // This might be optional if dateCtl1's text update triggers a rebuild
                                      await displayTimePicker(
                                          context, timeCtl1);
                                    },
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
                                Container(
                                  width: 160,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyTheme.white),
                                  child: TextFormField(
                                    controller: dateCtl2,
                                    textAlign: TextAlign.start,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.date_range),
                                      hintText: "Select Date",
                                      hintStyle: TextStyle(
                                          color: MyTheme.grey_153,
                                          fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 10),
                                      border: InputBorder.none,
                                      // This removes the border
                                      enabledBorder: InputBorder.none,
                                      // Optional: removes the border when enabled
                                      focusedBorder: InputBorder.none,
                                      // Optional: removes the border when focused
                                      errorBorder: InputBorder.none,
                                      // Optional: removes the border when an error is displayed
                                      disabledBorder: InputBorder.none,
                                      // Optional: removes the border when disabled
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      await displayDatePicker(
                                          context, dateCtl2);
                                    },
                                  ),
                                ),
                                Container(
                                  width: 160,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyTheme.white),
                                  child: TextFormField(
                                    controller: timeCtl2,
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
                                      // This removes the border
                                      enabledBorder: InputBorder.none,
                                      // Optional: removes the border when enabled
                                      focusedBorder: InputBorder.none,
                                      // Optional: removes the border when focused
                                      errorBorder: InputBorder.none,
                                      // Optional: removes the border when an error is displayed
                                      disabledBorder: InputBorder.none,
                                      // Optional: removes the border when disabled
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      // This might be optional if dateCtl1's text update triggers a rebuild
                                      await displayTimePicker(
                                          context, timeCtl2);
                                      // dateCtl.text = date.toString();
                                    },
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
                                  ),
                                ],
                              ),
                            )
                          ],
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
