import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';

import '../../mytheme.dart';

class VerificationFlowPage extends StatefulWidget {
  const VerificationFlowPage({super.key});

  @override
  State<VerificationFlowPage> createState() => _VerificationFlowPageState();
}

class _VerificationFlowPageState extends State<VerificationFlowPage> {
  final VerificationController verifyController =
      Get.put(VerificationController());

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
        ()=> Stepper(
          type: StepperType.horizontal,
          currentStep: verifyController.activeCurrentStep.value,
          steps: verifyController.stepList(),
          onStepContinue: verifyController.stepContinue,
          onStepCancel: verifyController.stepCancel,
          onStepTapped: (int index) {
            verifyController.stepTapped(index);
          },
        ),
      ),
    );
  }
}
