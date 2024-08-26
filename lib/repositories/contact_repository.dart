import 'dart:convert';

import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/helpers/api_helpers.dart';
import 'package:onnwheels/models/contact_response_model.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:toast/toast.dart';

class ContactRepository{
  Future getContactResponse(
      String name,
      String email,
      String subject,
      String message,
      ) async {
    var post_body = jsonEncode({
      "name": "$name",
      "email": "$email",
      "subject": "$subject",
      "message": "$subject"
    });
    String getToken = await SharedPreference().getUserToken();
    String url = ("${AppConfig.BASE_URL}/customer/send-message");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $getToken"
        },
        body: post_body);
    print("category response=======>${response.body}");
    if (response.statusCode == 200) {
      return contactResponseDataFromJson(response.body);
    } else if (response.statusCode == 403) {
      ToastComponent.showDialog("Not Applicable",
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }
}