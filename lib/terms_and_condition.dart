import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/profile_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  late String termsAndConditionText;
  ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data =
    controller.profileDataList.firstWhere((element) => element.id == 89);
    termsAndConditionText = data.translations!.first.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        foregroundColor: Colors.black,
        title: CustomText(
          text: 'Terms And Condition',
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: termsAndConditionText == ''
          ? Center(
        child: Text("Terms And Condition"),
      )
          : SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Html(
            data: termsAndConditionText,
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
