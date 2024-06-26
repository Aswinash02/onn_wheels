import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
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

  // void stepContinue() {
  //   if (verifyController.activeCurrentStep.value < (StepperHelper.stepList(verifyController).length - 1)) {
  //     verifyController.activeCurrentStep += 1;
  //     print("Active Current Step==========>${verifyController.activeCurrentStep}");
  //     setState(() {});
  //     if(StepperHelper.stepList(verifyController).length < 2){
  //       print("confirmed");
  //     }
  //   }
  // }
  void stepContinue() {
    int currentStep = verifyController.activeCurrentStep.value;
    int lastStep = StepperHelper.stepList(verifyController).length - 1;

    if (currentStep < lastStep) {
      // Move to the next step
      verifyController.activeCurrentStep.value += 1;
      print("Active Current Step==========>${verifyController.activeCurrentStep.value}");
      setState(() {});
    } else if (currentStep == lastStep) {
      // Final step, call the API
      print("Final Step Reached, calling API...");
      // callFinalStepAPI();
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
      body: Obx(
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
      ),
    );
  }
}
