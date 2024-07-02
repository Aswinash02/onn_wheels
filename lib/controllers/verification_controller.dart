import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:toast/toast.dart';
import 'package:dotted_border/dotted_border.dart';
import '../customs/toastcomponent.dart';
import '../repositories/verification_repositories.dart';
import 'auth_controller.dart';

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
  var panValue = ''.obs;
  var aadharValue = ''.obs;
  var licenseFront = ''.obs;
  var licenseBack = ''.obs;

  Rx<UserInfo> user = UserInfo().obs;

  Future<void> initCall() async {
    user.value = (await Get.find<AuthController>().getUserInfo())!;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCall();
    getUserKycDetails();
  }

  getUserKycDetails() async {
    var getKycDetails = await VerificationRepository().getKycDetails();
    panValue.value = getKycDetails.data!.pan!;
    aadharValue.value = getKycDetails.data!.aadhar!;
    licenseFront.value = getKycDetails.data!.licenseFront!;
    licenseBack.value = getKycDetails.data!.licenseBack!;
  }

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
    if (index == 2) {
      print("2");
    }
    update();
  }
}
