import 'dart:convert';

import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/helpers/api_helpers.dart';
import 'package:onnwheels/models/checkout_model.dart';
import 'package:onnwheels/models/get_gst_model.dart';
import 'package:toast/toast.dart';

import '../utils/app_config.dart';

class CheckoutRepository {
  Future getCheckoutResponse({
    required String userId,
    required String userName,
    required String phone,
    required String email,
    required String address,
    required String long,
    required String lat,
    required int store_id,
    required int amount,
    required int unitAmount,
    required String status,
    required String transactionReference,
    required int item_id,
    required double distance,
    required String startDate,
    String? endDate,
    int? weekEndPrice,
    int? kmLimit,
    String? vehicleNumber,
    int? discount,
    int? helmetPrice,
  }) async {
    var post_body = jsonEncode({
      "user_id": userId,
      "contact_person_name": "$userName",
      "contact_person_number": "$phone",
      "contact_person_email": "$email",
      "address": "$address",
      "lng": "$long",
      "lat": "$lat",
      "store_id": store_id,
      "order_amount": amount,
      "unit_price": unitAmount,
      "payment_status": "$status",
      "transaction_reference": "$transactionReference",
      "item_id": item_id,
      "distance": distance,
      "start_date": "$startDate",
      "end_date": "$endDate",
      "weekend_price": weekEndPrice,
      "km_limit": kmLimit,
      "vehicle_number": vehicleNumber,
      "discount": discount,
      "helmet_amount": helmetPrice.toString()
    });
    String url = ("${AppConfig.BASE_URL}/items/create-order");
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "moduleId": "1",
          "zoneId": "2"
        },
        body: post_body);
    if (response.statusCode == 200) {
      return checkoutResponseFromJson(response.body);
    } else if (response.statusCode == 403) {
      ToastComponent.showDialog("Not Applicable",
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }

  Future<gstResponse> getGstValue() async {
    try {
      String url = ("${AppConfig.BASE_URL}/items/get-gst");
      var response = await ApiHelper.get(
        url: url,
        headers: {"moduleId": '1'},
      );
      return gstResponseFromJson(response.body);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
