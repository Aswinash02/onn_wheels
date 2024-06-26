import 'dart:convert';

import 'package:onnwheels/helpers/api_helpers.dart';
import 'package:onnwheels/models/all_orders_model.dart';
import 'package:onnwheels/models/order_detail_model.dart';
import 'package:onnwheels/utils/app_config.dart';

class OrderRepository {
  Future<List<AllOrdersModel>> getAllOrders(int userId) async {
    try {
      String url = ("${AppConfig.BASE_URL}/items/all-orders");
      var response = await ApiHelper.get(
        url: url,
        queryParams: {"user_id": userId},
        headers: {"moduleId": '1'},
      );
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => AllOrdersModel.fromJson(json)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<OrderDetailModel> getOrderDetails(int orderId) async {
    try {
      String url = ("${AppConfig.BASE_URL}/items/get-order");
      var response = await ApiHelper.get(
        url: url,
        queryParams: {"order_id": orderId},
        headers: {"moduleId": '1'},
      );
      print('response body ============ > ${response.body}');
      // List<dynamic> jsonList = jsonDecode(response.body);
      return OrderDetailModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
