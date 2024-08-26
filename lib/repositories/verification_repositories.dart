import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:onnwheels/models/kyc_result_response.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:toast/toast.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import '../customs/toastcomponent.dart';
import '../helpers/api_helpers.dart';
import '../models/kyc_model_response.dart';
import '../models/pan_verify_models.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class VerificationRepository {
  Future<PanResponse> panVerificationPost({String? panNumber}) async {
    String url = ("${AppConfig.BASE_URL}/verification/pan-verify");
    var post_body = jsonEncode({
      "pan_number": "$panNumber",
      "purpose": 1,
      "purpose_desc": "onboarding"
    });
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body);
    print("get All pan Data response=======>${response.body}");

    return panResponseFromJson(response.body);
  }

  Future getKycResponse(
    File front,
    File back,
    String aadhar,
    String pan,
  ) async {
    String getToken = await SharedPreference().getUserToken();
    String url = "${AppConfig.BASE_URL}/customer/user-kyc";
    print('getToken ===== ${getToken}');

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));
    print(
        "post Datas========>${front.path} ${back.path} ${aadhar} ${pan} ${getToken}");

    // Add fields to the request
    request.fields['aadhar'] = aadhar;
    request.fields['pan'] = pan;

    // Add files to the request
    request.files.add(await http.MultipartFile.fromPath(
      'license_front',
      front.path,
      filename: path.basename(front.path),
    ));

    request.files.add(await http.MultipartFile.fromPath(
      'license_back',
      back.path,
      filename: path.basename(back.path),
    ));

    // Add headers
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
      "moduleId": "1",
      "zoneId": "2",
      "Authorization": "Bearer $getToken",
    });
    try {
      print(
          "post Datas kyc========>${front.path} ${back.path} ${aadhar} ${pan} ${getToken}");
      // Send the initial request
      var response = await request.send();

      // Handle redirection
      if (response.statusCode == 302 || response.statusCode == 301) {
        var redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          print("Redirecting to: $redirectUrl");
          var newRequest = http.Request('GET', Uri.parse(redirectUrl))
            ..headers.addAll({
              "Content-Type": "multipart/form-data",
              "moduleId": "1",
              "zoneId": "2",
            });

          // Send the new request
          var newResponse = await newRequest.send();

          if (newResponse.statusCode == 200) {
            var responseBody = await newResponse.stream.bytesToString();
            print("kyc response Body: $responseBody");
            ToastComponent.showDialog("User KYC details stored successfully",
                gravity: Toast.center, duration: Toast.lengthLong);
            return kycResponseFromJson(responseBody);
          } else {
            print("Failed with status code: ${newResponse.statusCode}");
          }
        }
      } else if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print("kyc response Body: $responseBody");
        ToastComponent.showDialog("User KYC details stored successfully",
            gravity: Toast.center, duration: Toast.lengthLong);
        return kycResponseFromJson(responseBody);
      } else if (response.statusCode == 403) {
        print("Not Applicable");
        ToastComponent.showDialog("Not Applicable",
            gravity: Toast.center, duration: Toast.lengthLong);
      } else {
        print("Failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception during API call: $e");
    }
  }

  Future<kycResultResponse> getKycDetails() async {
    String getToken = await SharedPreference().getUserToken();
    String url = ("${AppConfig.BASE_URL}/customer/user-kyc-status");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $getToken"
      },
    );
    print("get User Kyc response=======>${response.body}");

    return kycResultFromJson(response.body);
  }

  Future<http.Response> aadhaarVerify(String aadhaarNumber) async {
    String userToken = await SharedPreference().getUserToken();
    return await ApiHelper.post(
      body: jsonEncode({"aadhar": aadhaarNumber}),
      url: "${AppConfig.BASE_URL}/verification/aadhar-verify",
      headers: {
        'Authorization': 'Bearer $userToken',
      },
    );
  }

  Future<http.Response> aadhaarOTPVerify(
      String referenceNumber, String otp) async {
    String userToken = await SharedPreference().getUserToken();
    return await ApiHelper.post(
      body: jsonEncode({"reference_id": referenceNumber, "otp": otp}),
      url: "${AppConfig.BASE_URL}/verification/aadhaar-otp-verify",
      headers: {
        'Authorization': 'Bearer $userToken',
      },
    );
  }
}
