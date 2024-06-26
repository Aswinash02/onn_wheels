import 'package:get/get.dart';
import 'package:onnwheels/controllers/auth_controller.dart';
import 'package:onnwheels/models/user_info_model.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCall();
  }

  Rx<UserInfo> user = UserInfo().obs;

  Future<void> initCall() async {
    user.value = (await Get.find<AuthController>().getUserInfo())!;
  }
}
