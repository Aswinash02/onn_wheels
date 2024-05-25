import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:toast/toast.dart';
import 'package:dotted_border/dotted_border.dart';
import '../customs/toastcomponent.dart';
import '../repositories/verification_repositories.dart';

class VerificationController extends GetxController {
  var activeCurrentStep = 0.obs;
  File? _imageFile;
  var panSuccess = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController panData = TextEditingController();
  TextEditingController aadharData = TextEditingController();

  void stepContinue() {
    if (activeCurrentStep.value < (stepList().length - 1)) {
      activeCurrentStep += 1;
      update();
    }
  }

  Future<void> chooseAndUploadFile(BuildContext context) async {
    // Show dialog to choose between camera and gallery
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Choose Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.camera);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    await _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await ImagePicker().pickImage(source: source);
    if (selected != null) {
      // Convert XFile to File
      _imageFile = File(selected.path);
      update();
    } else {

    }
  }

  void stepCancel() {
    if (activeCurrentStep.value == 0) {
      return;
    }
    activeCurrentStep.value -= 1;
    update();
  }

  void stepTapped(index) {
    activeCurrentStep.value = index;
    update();
  }

  List<Step> stepList() => [
        Step(
          state: activeCurrentStep.value <= 0
              ? StepState.editing
              : StepState.complete,
          isActive: activeCurrentStep.value >= 0,
          title: const Text(
            'Personal Details',
            style: TextStyle(fontSize: 10),
          ),
          content: Container(
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'phone',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: city,
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
                  controller: address,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full House Address',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: pincode,
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
          state: activeCurrentStep.value <= 1
              ? StepState.editing
              : StepState.complete,
          isActive: activeCurrentStep.value >= 1,
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
                  controller: aadharData,
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
                        "Get OTP",
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
                  controller: panData,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pan Number',
                    enabled: panSuccess.value == false ? true : false
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  child: Obx(
                  ()=> Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: panSuccess.value != true ?MyTheme.black : MyTheme.green,
                      ),
                      child: Center(
                        child: Text(
                          panSuccess.value != true ? "Get OTP" : "Verified",
                          style: TextStyle(color: MyTheme.white),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (panSuccess.value != true) {
                      var panVerifyResponse = await VerificationRepository()
                          .panVerificationPost(panNumber: panData.text);

                      if(panVerifyResponse.status == 0) {
                        panSuccess.value = true;
                        print("success");
                        ToastComponent.showDialog(panVerifyResponse.message!.toString(),
                            gravity: Toast.center, duration: Toast.lengthLong);
                      } else {
                        print("failed");
                        ToastComponent.showDialog(panVerifyResponse.message!.toString(),
                            gravity: Toast.center, duration: Toast.lengthLong);
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
                                child: Center(
                                  child: Icon(Icons.cloud_download),
                                ),
                              ),
                            ),
                            onTap: () {
                              _pickImage(ImageSource.camera);
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
                                child: Center(
                                  child: Icon(Icons.cloud_download),
                                ),
                              ),
                            ),
                            onTap: () {
                               _pickImage(ImageSource.camera);
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
            isActive: activeCurrentStep.value >= 2,
            title: const Text(
              'Confirm',
              style: TextStyle(fontSize: 10),
            ),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Phone: ${phone.text}'),
                Text('City: ${city.text}'),
                Text('Address : ${address.text}'),
                Text('PinCode : ${pincode.text}'),
              ],
            )))
      ];
}
