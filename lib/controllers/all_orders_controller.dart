import 'package:get/get.dart';
import 'package:onnwheels/models/all_orders_model.dart';
import 'package:onnwheels/repositories/all_orders_repository.dart';

class AllOrdersController extends GetxController {
  RxList<AllOrdersModel> allOrdersList = <AllOrdersModel>[].obs;

  Future<void> getAllOrders() async {
    var response = await AllOrdersRepository().getAllOrders(27);
    allOrdersList.addAll(response);
    print('allOrdersList =========== > ${allOrdersList.first.id}');
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
