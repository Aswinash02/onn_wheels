import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/verification_repositories.dart';
import 'package:onnwheels/simmer/bike_details_simmer.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:onnwheels/views/verification/kyc_status_screen.dart';
import 'package:toast/toast.dart';
import 'components/steplist_widget.dart';

class VerificationFlowPage extends StatefulWidget {
  const VerificationFlowPage({super.key});

  @override
  State<VerificationFlowPage> createState() => _VerificationFlowPageState();
}

class _VerificationFlowPageState extends State<VerificationFlowPage> {
  final VerificationController verifyController =
      Get.put(VerificationController());

  Future<void> stepContinue() async {
    int currentStep = verifyController.activeCurrentStep.value;
    int lastStep = StepperHelper.stepList(verifyController, context).length - 1;

    if (currentStep < lastStep) {
      verifyController.activeCurrentStep.value += 1;
    } else if (currentStep == 2) {
      if (verifyController.name.text.isEmpty) {
        ToastComponent.showDialog("Enter UserName",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else if (verifyController.aadharData.text.isEmpty) {
        ToastComponent.showDialog("Enter Aadhaar Number",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else if (verifyController.panData.text.isEmpty) {
        ToastComponent.showDialog("Enter Pan Number",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else if (verifyController.selectedImagePathFront.value == "") {
        ToastComponent.showDialog("Upload License Front Image",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else if (verifyController.selectedImagePathBack.value == "") {
        ToastComponent.showDialog("Upload License Back Image",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else if (verifyController.panSuccess.value == false) {
        ToastComponent.showDialog("Pan is Not Verified",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else if (verifyController.aadhaarVerified.value == false) {
        ToastComponent.showDialog("Aadhaar is Not Verified",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else {
        verifyController.kycLoadingState.value = true;
        await VerificationRepository().getKycResponse(
            File(verifyController.selectedImagePathFront.value),
            File(verifyController.selectedImagePathBack.value),
            verifyController.aadharData.text,
            verifyController.panData.text);
        await verifyController.getUserKycDetails();
        verifyController.kycLoadingState.value = false;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyController.initCall();
    verifyController.getUserKycDetails();
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
      body: Obx(() {
        return verifyController.loading.value
            ? CustomSimmer()
            : verifyController.kycResponse.value.success == null ||
                    (verifyController.kycResponse.value.success == true &&
                        verifyController.isUpdate.value)
                ? Obx(
                    () => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: MyTheme.orange,
                          onPrimary: Colors.white,
                          secondary: MyTheme.orange,
                        ),
                      ),
                      child: Stepper(
                        type: StepperType.horizontal,
                        currentStep: verifyController.activeCurrentStep.value,
                        steps:
                            StepperHelper.stepList(verifyController, context),
                        onStepContinue: verifyController.kycLoadingState.value
                            ? null
                            : stepContinue,
                        onStepCancel: verifyController.stepCancel,
                        onStepTapped: (int index) {
                          verifyController.stepTapped(index);
                        },
                        controlsBuilder:
                            (BuildContext context, ControlsDetails controls) {
                          return Row(
                            children: <Widget>[
                              Obx(() => GestureDetector(
                                    onTap: stepContinue,
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: MyTheme.orange,
                                      ),
                                      child: verifyController
                                              .kycLoadingState.value
                                          ? SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : Text(
                                              'CONTINUE',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                    ),
                                  )),
                              TextButton(
                                onPressed: controls.onStepCancel,
                                child: const Text('CANCEL'),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : verifyController.kycResponse.value.data!.isVerified == 0 &&
                        verifyController.kycResponse.value.data!.isReject == 0
                    ? KycStatusScreen(
                        status: true,
                        controller: verifyController,
                      )
                    : verifyController.kycResponse.value.data!.isReject == 2
                        ? KycStatusScreen(
                            status: false,
                            controller: verifyController,
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: Obx(
                              () => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset("assets/Successmark.png",
                                        height: 160, width: 160),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  detailsRow(
                                      title: "Name",
                                      value: verifyController.user.value.name ??
                                          ''),
                                  detailsRow(
                                      title: "Email",
                                      value:
                                          verifyController.user.value.email ??
                                              ''),
                                  detailsRow(
                                      title: "Pan",
                                      value: verifyController
                                              .kycResponse.value.data!.pan ??
                                          ''),
                                  detailsRow(
                                      title: "Aadhaar",
                                      value: verifyController.kycResponse.value
                                              .data!.aadhaar ??
                                          ''),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: "Uploaded License",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  licenseImageContainer(
                                      imgName: 'Front Image',
                                      imgUrl: verifyController.kycResponse.value
                                              .data!.licenseFront ??
                                          ''),
                                  licenseImageContainer(
                                      imgName: 'Back Image',
                                      imgUrl: verifyController.kycResponse.value
                                              .data!.licenseBack ??
                                          '')
                                ],
                              ),
                            ),
                          );
      }),
    );
  }

  Widget detailsRow({required String title, required String value}) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 18,
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
          child: CustomText(
            text: value,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ))
      ],
    );
  }

  Widget licenseImageContainer(
      {required String imgName, required String imgUrl}) {
    Uri uri = Uri.parse(imgUrl);
    String filename = uri.pathSegments.last;
    return Row(
      children: [
        CustomText(
          text: imgName,
          fontWeight: FontWeight.w600,
          fontSize: 15,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(10.0),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                  "${AppConfig.BASE_URL}/public$imgUrl"),
                              SizedBox(height: 10),
                              CustomText(text: 'License $imgName'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: CustomText(
                                text: 'Close',
                                color: MyTheme.orange,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        color: MyTheme.orange,
                        size: 18,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 4),
                            child: CustomText(
                              text: filename,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
