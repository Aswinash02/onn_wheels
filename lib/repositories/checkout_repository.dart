import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/helpers/api_helpers.dart';
import 'package:onnwheels/models/checkout_model.dart';
import 'package:onnwheels/utils/shared_value.dart';
import 'package:onnwheels/views/order_details/components/order_page_card.dart';
import 'package:onnwheels/views/order_details/order_details_screen.dart';
import 'package:toast/toast.dart';

import '../utils/app_config.dart';

class CheckoutRepository {
  Future getCheckoutResponse(
    String userId,
    String userName,
    String phone,
    String email,
    String address,
    String long,
    String lat,
    int store_id,
    int amount,
    String status,
    String transactionReference,
    int item_id,
    double distance,
    String startDate,
    String? endDate,
  ) async {
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
      "payment_status": "$status",
      "transaction_reference": "$transactionReference",
      "item_id": item_id,
      "distance": distance,
      "start_date": "$startDate",
      "end_date": "$endDate"
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
    print("order response=======>${response.body}");
    if (response.statusCode == 200) {
      Get.to(
        () => OrderCardListView(),
      );
      return checkoutResponseFromJson(response.body);
    } else if (response.statusCode == 403) {
      ToastComponent.showDialog("Not Applicable",
          gravity: Toast.center, duration: Toast.lengthLong);
    }
  }
}
