import 'package:get/get.dart';
import 'package:onnwheels/models/all_orders_model.dart';
import 'package:onnwheels/models/order_detail_model.dart';
import 'package:onnwheels/repositories/all_orders_repository.dart';
import 'package:onnwheels/utils/shared_preference.dart';

class OrderController extends GetxController {
  RxList<AllOrdersModel> allOrdersList = <AllOrdersModel>[].obs;

  Rx<OrderDetailModel> order = OrderDetailModel().obs;
  RxBool loading = false.obs;
  RxBool orderDetailLoading = false.obs;

  Future<void> getAllOrders() async {
    loading.value = true;
    String userId = await SharedPreference().getUserId();
    var response = await OrderRepository().getAllOrders(int.parse(userId));
    allOrdersList.addAll(response);
    loading.value = false;
    update();
  }

  Future<void> getOrderDetails({required int orderId}) async {
    orderDetailLoading.value = true;
    order.value = await OrderRepository().getOrderDetails(orderId);
    orderDetailLoading.value = false;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllOrders();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
