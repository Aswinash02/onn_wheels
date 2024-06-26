import 'package:get/get.dart';
import 'package:onnwheels/utils/shared_preference.dart';

class CheckoutController extends GetxController {
  var userName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userId = "".obs;
  var orderId = "".obs;

  fetchUserName() async {
    SharedPreference sharedPreference = SharedPreference();
    userName.value = await sharedPreference.getUserName();
    userId.value = await sharedPreference.getUserId();
    userEmail.value = await sharedPreference.getUserEmail();
    userPhone.value = await sharedPreference.getUserPhoneNo();
    print(
        "fetching User Details=======>${userName.value},${userId.value}, ${userEmail.value} ${userPhone.value}");
  }

}
