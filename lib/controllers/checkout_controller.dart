import 'package:get/get.dart';
import 'package:onnwheels/repositories/checkout_repository.dart';
import 'package:onnwheels/utils/shared_preference.dart';

class CheckoutController extends GetxController {
  var userName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userId = "".obs;
  var orderId = "".obs;
  var gst = ''.obs;
  var sgst = "".obs;
  var gstValue = 0.obs;
  var gstValue2 = 0.obs;
  RxBool loadingState = false.obs;

  fetchUserName() async {
    loadingState.value = true;
    SharedPreference sharedPreference = SharedPreference();
    userName.value = await sharedPreference.getUserName();
    userId.value = await sharedPreference.getUserId();
    userEmail.value = await sharedPreference.getUserEmail();
    userPhone.value = await sharedPreference.getUserPhoneNo();
    loadingState.value = false;
  }

  fetchGstData(int totalPayableAmount) async {
    loadingState.value = true;

    var getGstResponse = await CheckoutRepository().getGstValue();

    int sgstValue = int.parse(getGstResponse.sgst ?? '0');
    int gstValue = int.parse(getGstResponse.gst ?? '0');

    sgst.value = (sgstValue).toString();
    gst.value = (gstValue).toString();
    calculateNinePercent(totalPayableAmount);

    loadingState.value = false;
  }

  int calculateNinePercent(int totalAmount) {
    int percentage = int.tryParse(sgst.value) ?? 0;
    int percentage2 = int.tryParse(gst.value) ?? 0;

    gstValue.value = (totalAmount * percentage) ~/ 100;
    gstValue2.value = (totalAmount * percentage2) ~/ 100;
    update();
    return gstValue.value + totalAmount + gstValue2.value;
  }
}
