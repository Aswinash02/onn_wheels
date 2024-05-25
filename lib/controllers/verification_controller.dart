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
  var selectedImagePathFront = ''.obs;
  var selectedImagePathBack = ''.obs;
  bool isFront = false;



  Future<void> chooseAndUploadFile(BuildContext context) async {
    // Show dialog to choose between camera and gallery
    showDialog(
      context: Get.context!,
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
      if (isFront) {
        selectedImagePathFront.value = selected.path;
      } else {
        selectedImagePathBack.value = selected.path;
      }
      update(); // Update the UI immediately
    } else {
      // Handle case where no image is selected
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


}
