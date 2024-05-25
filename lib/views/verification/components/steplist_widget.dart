import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/verification_controller.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/verification_repositories.dart';
import 'package:toast/toast.dart';

class StepperHelper {
  static List<Step> stepList(VerificationController verifyController) {
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: verifyController.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'phone',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: verifyController.city,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: verifyController.address,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full House Address',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: verifyController.pincode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pin Code',
                ),
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Aadhar Number',
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
                    color: MyTheme.black,
                  ),
                  child: Center(
                    child: Text(
                      "Verify",
                      style: TextStyle(color: MyTheme.white),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: verifyController.panData,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pan Number',
                    enabled: verifyController.panSuccess.value == false
                        ? true
                        : false),
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
                      color: verifyController.panSuccess.value != true
                          ? MyTheme.black
                          : MyTheme.green,
                    ),
                    child: Center(
                      child: Text(
                        verifyController.panSuccess.value != true
                            ? "Verify"
                            : "Verified",
                        style: TextStyle(color: MyTheme.white),
                      ),
                    ),
                  ),
                ),
                onTap: () async {
                  if (verifyController.panSuccess.value != true) {
                    var panVerifyResponse = await VerificationRepository()
                        .panVerificationPost(
                            panNumber: verifyController.panData.text);
                    if (panVerifyResponse.status == 0) {
                      verifyController.panSuccess.value = true;
                      print("success");
                      ToastComponent.showDialog(
                          panVerifyResponse.message!.toString(),
                          gravity: Toast.center,
                          duration: Toast.lengthLong);
                    } else {
                      print("failed");
                      ToastComponent.showDialog(
                          panVerifyResponse.message!.toString(),
                          gravity: Toast.center,
                          duration: Toast.lengthLong);
                    }
                  }
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
                              child: verifyController.selectedImagePathFront.value !=
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
                              child: verifyController.selectedImagePathBack.value !=
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
              Text('Phone: ${verifyController.phone.text}'),
              Text('City: ${verifyController.city.text}'),
              Text('Address : ${verifyController.address.text}'),
              Text('PinCode : ${verifyController.pincode.text}'),
            ],
          )))
    ];
  }
}
