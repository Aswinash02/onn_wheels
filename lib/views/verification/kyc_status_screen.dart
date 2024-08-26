import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class KycStatusScreen extends StatelessWidget {
  final bool status;
  final VerificationController controller;

  const KycStatusScreen(
      {super.key, required this.status, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Column(
              children: [
                Image(
                  image: AssetImage(status
                      ? "assets/Successmark.png"
                      : "assets/failure_img.png"),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 10),
                CustomText(
                  text: status ? "KYC Submitted" : "KYC Rejected",
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
                const SizedBox(height: 40),
                CustomText(
                  text: status
                      ? "Thanks for submitting your document we’ll "
                          "verify it and complete your KYC as soon as possible"
                      : Get.find<VerificationController>()
                              .kycResponse
                              .value
                              .data!
                              .status ??
                          '',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    print('yes entered ----------');
                    if (status) {
                      Navigator.pop(context);
                    } else {
                      print('yes entered 0000000');
                      controller.isUpdate.value = true;
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFF000080),
                    ),
                    child: Center(
                      child: CustomText(
                        text: status ? "Back" : "Update KYC",
                        color: MyTheme.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
