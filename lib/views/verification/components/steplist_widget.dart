import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/verification_repositories.dart';
import 'package:toast/toast.dart';

class StepperHelper {
  static List<Step> stepList(
      VerificationController verifyController, BuildContext context) {
    if (verifyController.isUpdate.value) {
      verifyController.getKycUpdateData();
    }

    return [
      Step(
        state: verifyController.activeCurrentStep.value <= 0
            ? StepState.editing
            : StepState.complete,
        isActive: verifyController.activeCurrentStep.value >= 0,
        title: const Text(
          'Personal Details',
          style: TextStyle(fontSize: 10),
        ),
        content: Container(
          child: Column(
            children: [
              TextField(
                controller: verifyController.name,
                cursorColor: MyTheme.orange,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
      Step(
        state: verifyController.activeCurrentStep.value <= 1
            ? StepState.editing
            : StepState.complete,
        isActive: verifyController.activeCurrentStep.value >= 1,
        title: const Text(
          'Verification',
          style: TextStyle(fontSize: 10),
        ),
        content: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: verifyController.aadharData,
                cursorColor: MyTheme.orange,
                onChanged: (String value) {
                  verifyController.aadhaarVerified.value = false;
                  if (value.length == 12) {
                    FocusScope.of(context).unfocus();
                    verifyController.aadhaarVerify();
                  }
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(12)
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: verifyController.aadhaarVerifyLoadingState.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                )),
                          ],
                        )
                      : SizedBox(),
                  labelText: 'Aadhaar Number',
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                controller: verifyController.aadharOTP,
                keyboardType: TextInputType.number,
                enabled: verifyController.isEnableOTP.value,
                cursorColor: MyTheme.orange,
                onChanged: (String str) {
                  verifyController.aadhaarVerified.value = false;

                  if (str.length == 6) {
                    FocusScope.of(context).unfocus();
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6)
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aadhaar OTP',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyTheme.orange,
                  ),
                  child: Center(
                    child: verifyController.otpLoadingState.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            verifyController.aadhaarVerified.value != true
                                ? "Verify"
                                : "Verified",
                            style: TextStyle(color: MyTheme.white),
                          ),
                  ),
                ),
                onTap: () {
                  verifyController.aadhaarOTPVerify();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: verifyController.panData,
                cursorColor: MyTheme.orange,
                onChanged: (String str) {
                  verifyController.panSuccess.value = false;
                  if (str.length == 10) {
                    FocusScope.of(context).unfocus();
                  }
                },
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pan Number',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                child: Obx(
                  () => Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.orange,
                    ),
                    child: Center(
                      child: verifyController.panLoadingState.value
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              verifyController.panSuccess.value != true
                                  ? "Verify"
                                  : "Verified",
                              style: TextStyle(color: MyTheme.white),
                            ),
                    ),
                  ),
                ),
                onTap: () async {
                  verifyController.onTapPanVerify();
                },
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    "Licence Upload",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          child: DottedBorder(
                            color: MyTheme.blue,
                            strokeWidth: 1,
                            child: Container(
                              height: 140,
                              width: 140,
                              color: MyTheme.white,
                              child: verifyController
                                          .selectedImagePathFront.value !=
                                      ''
                                  ? Obx(
                                      () => Image.file(
                                          File(verifyController
                                              .selectedImagePathFront.value),
                                          fit: BoxFit.fill),
                                    )
                                  : Center(child: Icon(Icons.cloud_download)),
                            ),
                          ),
                          onTap: () async {
                            verifyController.isFront = true;
                            await verifyController
                                .chooseAndUploadFile(Get.context!);
                            // _pickImage(ImageSource.camera);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Front"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          child: DottedBorder(
                            color: MyTheme.blue,
                            strokeWidth: 1,
                            child: Container(
                              height: 140,
                              width: 140,
                              color: MyTheme.white,
                              child: verifyController
                                          .selectedImagePathBack.value !=
                                      ''
                                  ? Obx(
                                      () => Image.file(
                                          File(verifyController
                                              .selectedImagePathBack.value),
                                          fit: BoxFit.fill),
                                    )
                                  : Center(child: Icon(Icons.cloud_download)),
                            ),
                          ),
                          onTap: () async {
                            verifyController.isFront = false;
                            await verifyController
                                .chooseAndUploadFile(Get.context!);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Back"),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Step(
          state: StepState.complete,
          isActive: verifyController.activeCurrentStep.value >= 2,
          title: const Text(
            'Confirm',
            style: TextStyle(fontSize: 10),
          ),
          content: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Name: ${verifyController.name.text}'),
              Text("Aadhar: ${verifyController.aadharData.text}"),
              Text("Pan: ${verifyController.panData.text}")
              // Text('Phone: ${verifyController.phone.text}'),
              // Text('City: ${verifyController.city.text}'),
              // Text('Address : ${verifyController.address.text}'),
              // Text('PinCode : ${verifyController.pincode.text}'),
            ],
          )))
    ];
  }
}
