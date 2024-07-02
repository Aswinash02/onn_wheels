import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:toast/toast.dart';

import '../../customs/toastcomponent.dart';
import '../../mytheme.dart';
import '../../repositories/verification_repositories.dart';
import 'components/steplist_widget.dart';

class VerificationFlowPage extends StatefulWidget {
  const VerificationFlowPage({super.key});

  @override
  State<VerificationFlowPage> createState() => _VerificationFlowPageState();
}

class _VerificationFlowPageState extends State<VerificationFlowPage> {
  final VerificationController verifyController =
      Get.put(VerificationController());

  void stepContinue() {
    int currentStep = verifyController.activeCurrentStep.value;
    int lastStep = StepperHelper.stepList(verifyController).length - 1;

    if (currentStep < lastStep) {
      // Move to the next step
      if (currentStep == 0) {
        if (verifyController.name.text == '') {
          ToastComponent.showDialog("Need to Fill UserName",
              gravity: Toast.center, duration: Toast.lengthLong);
        } else {
          verifyController.activeCurrentStep.value += 1;
        }
      } else if (currentStep == 1) {
        if (verifyController.aadharData.text == '' ||
            verifyController.panData.text == "" ||
            verifyController.selectedImagePathFront.value == "" ||
            verifyController.selectedImagePathBack.value == "") {
          ToastComponent.showDialog("Need to Fill KYC",
              gravity: Toast.center, duration: Toast.lengthLong);
        } else {
          verifyController.activeCurrentStep.value += 1;
        }
      }
      // verifyController.activeCurrentStep.value += 1;
      print(
          "Active Current Step==========>${verifyController.activeCurrentStep.value}");
      setState(() {});
    } else if (currentStep == lastStep) {
      // Final step, call the API
      print("Final Step Reached, calling API...");
      // callFinalStepAPI();
      VerificationRepository().getKycResponse(
          File(verifyController.selectedImagePathFront.value),
          File(verifyController.selectedImagePathBack.value),
          verifyController.aadharData.text,
          verifyController.panData.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
        textColor: MyTheme.black,
        backgroundColor: MyTheme.white,
        title: "Verification Details",
        setLeading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.black,
          ),
        ),
      ),
      // Here we have initialized the stepper widget
      body: verifyController.user.value.isVerifiedKyc == 1
          ? Obx(
              () => Stepper(
                type: StepperType.horizontal,
                currentStep: verifyController.activeCurrentStep.value,
                steps: StepperHelper.stepList(verifyController),
                // steps: verifyController.stepList(),
                onStepContinue: stepContinue,
                onStepCancel: verifyController.stepCancel,
                onStepTapped: (int index) {
                  verifyController.stepTapped(index);
                },
              ),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/Successmark.png",
                        height: 160, width: 160),
                    SizedBox(
                      height: 40,
                    ),
                    detailsRow(
                        title: "Name",
                        value: verifyController.user.value.name!),
                    detailsRow(
                        title: "Email",
                        value: verifyController.user.value.email!),
                    detailsRow(
                        title: "Pan", value: verifyController.panValue.value),
                    detailsRow(
                        title: "Aadhar",
                        value: verifyController.aadharValue.value),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        verifyController.licenseFront.value != null &&
                                verifyController.licenseFront.value != ""
                            ? Image.network(
                                "https://onnwheels.com/public${verifyController.licenseFront.value}",
                                height: 160,
                                width: 160)
                            : SizedBox(),
                        verifyController.licenseBack.value != null &&
                                verifyController.licenseBack.value != ""
                            ? Image.network(
                                "https://onnwheels.com/public${verifyController.licenseBack.value}",
                                height: 160,
                                width: 160)
                            : SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget detailsRow({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            text: ':',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        Expanded(
            child: SizedBox(
          child: Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: value,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ))
      ],
    );
  }
}
