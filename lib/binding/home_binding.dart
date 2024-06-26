import 'package:get/get.dart';
import 'package:onnwheels/controllers/home_controller.dart';

class HomeBinding implements Bindings {

  HomeBinding();

  @override
  void dependencies() {
    // Get.put(() => BottomNavigationController());
    Get.put(() => HomeController());
    // Get.put(() => OrderController());
    // Get.put(() => CartController());
    // Get.put(() => ProfileController());
  }
}

// Future<void> init() async{
//   Get.put(() => HomeController());
// }