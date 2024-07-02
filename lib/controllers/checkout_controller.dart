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

  fetchUserName() async {
    SharedPreference sharedPreference = SharedPreference();
    userName.value = await sharedPreference.getUserName();
    userId.value = await sharedPreference.getUserId();
    userEmail.value = await sharedPreference.getUserEmail();
    userPhone.value = await sharedPreference.getUserPhoneNo();
    print(
        "fetching User Details=======>${userName.value},${userId.value}, ${userEmail.value} ${userPhone.value}");
  }

  fetchGstData(String totalPayableAmount) async {
    var getGstResponse = await CheckoutRepository().getGstValue();

    // Convert string values to double
    int sgstValue = int.parse(getGstResponse.sgst ?? '0');
    int gstValue = int.parse(getGstResponse.gst ?? '0');

    // Perform the multiplication
    sgst.value = (sgstValue).toString();
    gst.value = (gstValue).toString();
    calculateNinePercent(int.tryParse(totalPayableAmount)!);
    print("Calculated SGST: ${sgst.value}");
    print("Calculated GST: ${gst.value}");
  }

  int calculateNinePercent(int totalAmount) {
    print("yes entered ============= >");
    int percentage = int.tryParse(sgst.value) ?? 0; // Default to 0 if parsing fails
    int percentage2 = int.tryParse(gst.value) ?? 0; // Default to 0 if parsing fails

    gstValue.value = (totalAmount * percentage) ~/ 100;
    gstValue2.value = (totalAmount * percentage2) ~/ 100;
    update();
    return gstValue.value + totalAmount + gstValue2.value;
  }

  int removeGstFromAmount(int totalAmount) {
    int percentage = int.tryParse(sgst.value) ?? 0; // Default to 0 if parsing fails
    double originalAmount = totalAmount / (1 + (percentage / 100));
    return originalAmount.round();
  }

  int getGstValueFromTotal(int totalAmount) {
    int percentage = int.tryParse(sgst.value) ?? 0; // Default to 0 if parsing fails
    int originalAmount = removeGstFromAmount(totalAmount);
    return totalAmount - originalAmount;
  }
  // int calculateNinePercent(int totalAmount) {
  //   int percentage = int.tryParse(sgst.value) ?? 0; // Default to 0 if parsing fails
  //   int percentage2 = int.tryParse(gst.value) ?? 0; // Default to 0 if parsing fails
  //
  //   gstValue.value = (totalAmount * percentage) ~/ 100;
  //   gstValue2.value = (totalAmount * percentage2) ~/ 100;
  //
  //   return gstValue.value + totalAmount + gstValue2.value;
  // }
  //
  // int removeGstFromAmount(int totalAmount) {
  //   int percentage = int.tryParse(sgst.value) ?? 0; // Default to 0 if parsing fails
  //   double originalAmount = totalAmount / (1 + (percentage / 100));
  //   return originalAmount.round();
  // }
  //
  // int getGstValueFromTotal(int totalAmount) {
  //   int percentage = int.tryParse(sgst.value) ?? 0; // Default to 0 if parsing fails
  //   int originalAmount = removeGstFromAmount(totalAmount);
  //   return totalAmount - originalAmount;
  // }

  int? parseInt(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      // Handle the exception if the value is not a valid integer
      print('Error parsing integer: $e');
      return null;
    }
  }
}
