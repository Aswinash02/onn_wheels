import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/locationcontroller.dart';
import '../../mytheme.dart';
import '../main_page/components/custom_appbar.dart';

class ZoneAreasPage extends StatefulWidget {
  const ZoneAreasPage({super.key});

  @override
  State<ZoneAreasPage> createState() => _ZoneAreasPageState();
}

class _ZoneAreasPageState extends State<ZoneAreasPage> {
  final LocationController locationController = Get.put(LocationController());
  @override
  void initState() {
    // TODO: implement initState
    locationController.getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
        title: AppLocalizations.of(context)!.select_zone,
        backgroundColor: MyTheme.white,
        setLeading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.black,
          ),
        ),
        textColor: MyTheme.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Your Zone',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
