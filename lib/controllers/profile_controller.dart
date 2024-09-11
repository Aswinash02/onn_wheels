import 'package:get/get.dart';
import 'package:onnwheels/controllers/auth_controller.dart';
import 'package:onnwheels/models/profile_page_model.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/repositories/profile_repository.dart';

class ProfileController extends GetxController {
  Rx<UserInfo> user = UserInfo().obs;
  RxBool loadingState = false.obs;
  RxList<ProfilePageModel> profileDataList = <ProfilePageModel>[].obs;

  Future<void> initCall() async {
    user.value = (await Get.find<AuthController>().getUserInfo())!;
  }

  Future<void> fetchProfilePageResponse() async {
    try {
      var result = await ProfileRepository().getProfilePageResponse();
      profileDataList.value = result;
    } catch (_) {}
  }
}
