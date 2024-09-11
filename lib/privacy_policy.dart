import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/profile_controller.dart';
import 'package:onnwheels/models/profile_page_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late String privacyPolicyText;
  ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data =
        controller.profileDataList.firstWhere((element) => element.id == 90);
    privacyPolicyText = data.translations!.first.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        foregroundColor: Colors.black,
        title: CustomText(
          text: 'Privacy Policy',
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: privacyPolicyText == ''
          ? Center(
              child: Text("About Us"),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: Html(
                  data: privacyPolicyText,
                  style: {
                    "body": Style(
                      fontSize: FontSize.large,
                      color: Colors.black87,
                    ),
                  },
                ),
              ),
            ),
    );
  }
}
