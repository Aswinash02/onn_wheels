import 'package:get/get.dart';
import 'package:onnwheels/models/all_orders_model.dart';
import 'package:onnwheels/models/order_detail_model.dart';
import 'package:onnwheels/repositories/all_orders_repository.dart';
import 'package:onnwheels/utils/shared_preference.dart';

class OrderController extends GetxController {
  RxList<AllOrdersModel> allOrdersList = <AllOrdersModel>[].obs;

  Rx<OrderDetailModel> order = OrderDetailModel().obs;
  RxBool loading = false.obs;
  RxBool loadingState = false.obs;

  Future<void> getAllOrders() async {
    loading.value = true;
    update();
    String userId = await SharedPreference().getUserId();
    allOrdersList.clear();
    var response = await OrderRepository().getAllOrders(int.parse(userId));
    allOrdersList.addAll(response);
    loading.value = false;
    update();
  }

  Future<void> getOrderDetails({required int orderId}) async {
    loadingState.value = true;
    order.value = await OrderRepository().getOrderDetails(orderId);
    loadingState.value = false;
    update();
  }
}
