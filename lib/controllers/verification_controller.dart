import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onnwheels/models/aadhaar_otp_model.dart';
import 'package:onnwheels/models/aadhaar_verify_model.dart';
import 'package:onnwheels/models/kyc_result_response.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../customs/toastcomponent.dart';
import '../repositories/verification_repositories.dart';
import 'auth_controller.dart';

class VerificationController extends GetxController {
  var activeCurrentStep = 0.obs;
  File? _imageFile;
  var panSuccess = false.obs;
  var aadhaarVerified = false.obs;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController panData = TextEditingController();
  TextEditingController aadharData = TextEditingController();
  TextEditingController aadharOTP = TextEditingController();
  var selectedImagePathFront = ''.obs;
  var isUpdateLicenseFront = ''.obs;
  var selectedImagePathBack = ''.obs;
  var isUpdateLicenseBack = ''.obs;
  bool isFront = false;
  RxBool isUpdate = false.obs;

  RxBool panLoadingState = false.obs;
  RxBool kycLoadingState = false.obs;
  RxBool otpLoadingState = false.obs;
  RxBool aadhaarVerifyLoadingState = false.obs;
  RxBool isEnableOTP = false.obs;
  RxBool loading = false.obs;
  int? refNum;
  static const String baseUrl = AppConfig.BASE_URL;

  Rx<UserInfo> user = UserInfo().obs;
  Rx<kycResultResponse> kycResponse = kycResultResponse().obs;

  Future<void> initCall() async {
    user.value = (await Get.find<AuthController>().getUserInfo())!;
  }

  Future<void> getKycUpdateData() async {
    String licenseFrontUrl =
        '${AppConfig.BASE_URL}/public/${kycResponse.value.data!.licenseFront ?? ''}';
    String licenseBackUrl =
        '${AppConfig.BASE_URL}/public/${kycResponse.value.data!.licenseBack ?? ''}';

    String licenseFrontFileName = Uri.parse(licenseFrontUrl).pathSegments.last;
    String licenseBackFileName = Uri.parse(licenseBackUrl).pathSegments.last;

    await downloadAndSaveFile(licenseFrontUrl, licenseFrontFileName, 'front');
    await downloadAndSaveFile(licenseBackUrl, licenseBackFileName, 'back');

    final appDir = await getApplicationDocumentsDirectory();

    final licenseFrontPath =
        '${appDir.path}/uploads/user/kyc/$licenseFrontFileName';
    final licenseBackPath =
        '${appDir.path}/uploads/user/kyc/$licenseBackFileName';

    print('licenseFrontPath - $licenseFrontPath');
    print('licenseBackPath - $licenseBackPath');

    aadharData.text = kycResponse.value.data!.aadhaar ?? '';
    panData.text = kycResponse.value.data!.pan ?? '';
    name.text = kycResponse.value.data!.userName ?? '';
    aadhaarVerified.value = true;
    panSuccess.value = true;
    if (isUpdateLicenseFront.value == '') {
      selectedImagePathFront.value = licenseFrontPath;
    } else {
      selectedImagePathFront.value = isUpdateLicenseFront.value;
    }
    if (isUpdateLicenseBack.value == '') {
      selectedImagePathBack.value = licenseBackPath;
    } else {
      selectedImagePathBack.value = isUpdateLicenseBack.value;
    }
  }

  Future<void> downloadAndSaveFile(
      String url, String fileName, String type) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final directoryPath = '${appDir.path}/uploads/user/kyc/';
      final filePath = '$directoryPath$fileName';

      final directory = Directory(directoryPath);
      if (!await directory.exists()) {
        print('directoryPath ------ ${directoryPath}');
        await directory.create(recursive: true);
      }

      final file = File(filePath);
      if (await file.exists()) {
        print('File already exists, overwriting: $filePath');
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        print('File saved at $filePath');
      } else {
        print('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error downloading or saving file: $e');
    }
  }

  getUserKycDetails() async {
    loading.value = true;
    try {
      var getKycDetails = await VerificationRepository().getKycDetails();

      if (getKycDetails.data != null) {
        kycResponse.value = getKycDetails;
      }
    } catch (_) {}

    loading.value = false;
  }

  Future<void> chooseAndUploadFile(BuildContext context) async {
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

  Future<void> aadhaarVerify() async {
    aadhaarVerifyLoadingState.value = true;
    var response =
        await VerificationRepository().aadhaarVerify(aadharData.text);
    if (response.statusCode == 200) {
      AadhaarVerifyModel responseModel =
          AadhaarVerifyModel.fromJson(jsonDecode(response.body));
      if (responseModel.data?.message == "OTP sent successfully") {
        isEnableOTP.value = true;
        refNum = responseModel.data?.referenceId;
        ToastComponent.showDialog(responseModel.data!.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
      } else {
        ToastComponent.showDialog(responseModel.data!.message!,
            gravity: Toast.center, duration: Toast.lengthLong);
      }
    }
    aadhaarVerifyLoadingState.value = false;
  }

  Future<void> aadhaarOTPVerify() async {
    otpLoadingState.value = true;
    try {
      var response = await VerificationRepository()
          .aadhaarOTPVerify(refNum.toString(), aadharOTP.text);
      print(response.body);
      if (response.statusCode == 200) {
        AadhaarOTPModel responseModel =
            AadhaarOTPModel.fromJson(jsonDecode(response.body));
        if (responseModel.data?.message == "Aadhaar Card Exists") {
          aadhaarVerified.value = true;
          ToastComponent.showDialog("Aadhaar Verified Successful ",
              gravity: Toast.center, duration: Toast.lengthLong);
        } else {
          ToastComponent.showDialog(responseModel.data!.message!,
              gravity: Toast.center, duration: Toast.lengthLong);
        }
      }
    } catch (e) {
      ToastComponent.showDialog(e.toString(),
          gravity: Toast.center, duration: Toast.lengthLong);
    } finally {
      otpLoadingState.value = false;
    }
  }

  Future<void> onTapPanVerify() async {
    if (panSuccess.value != true) {
      panLoadingState.value = true;
      var panVerifyResponse = await VerificationRepository()
          .panVerificationPost(panNumber: panData.text);
      if (panVerifyResponse.status == 0) {
        panSuccess.value = true;

        ToastComponent.showDialog(panVerifyResponse.message!.toString(),
            gravity: Toast.center, duration: Toast.lengthLong);
      } else {
        ToastComponent.showDialog(panVerifyResponse.message!.toString(),
            gravity: Toast.center, duration: Toast.lengthLong);
      }
    }
    panLoadingState.value = false;
  }

  Future<void> _pickImage(ImageSource source) async {
    XFile? selected = await ImagePicker().pickImage(source: source);
    if (selected != null) {
      _imageFile = File(selected.path);
      if (isFront) {
        if (isUpdate.value) {
          isUpdateLicenseFront.value = selected.path;
          selectedImagePathFront.value = selected.path;
        } else {
          selectedImagePathFront.value = selected.path;
        }
      } else {
        print('selected.path ${selected.path}');
        if (isUpdate.value) {
          isUpdateLicenseBack.value = selected.path;
          selectedImagePathBack.value = selected.path;
        } else {
          selectedImagePathBack.value = selected.path;
        }
      }
    }
  }

  void stepCancel() {
    if (activeCurrentStep.value == 0) {
      return;
    }
    activeCurrentStep.value -= 1;
  }

  void stepTapped(index) {
    activeCurrentStep.value = index;
    if (index == 2) {
      print("2");
    }
  }
}
