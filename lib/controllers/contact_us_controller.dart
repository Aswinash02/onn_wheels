import 'package:get/get.dart';
import 'package:onnwheels/models/general_details_model.dart';
import 'package:onnwheels/repositories/contact_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  Rx<GeneralDetailsModel> generalDetail = GeneralDetailsModel().obs;
  RxBool loadingState = false.obs;

  Future<void> getGeneralDetails() async {
    loadingState.value = true;
    GeneralDetailsModel response =
        await ContactRepository().getGeneralDetails();
    generalDetail.value = response;
    loadingState.value = false;
  }

  Future<void> launchPhone() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: generalDetail.value.phone.toString(),
    );
    try {
      if (await canLaunch(launchUri.toString())) {
        await launch(launchUri.toString());
      } else {
        throw 'Could not launch $launchUri';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> launchEmail() async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: generalDetail.value.email,
    );
    try {
      if (await canLaunch(launchUri.toString())) {
        await launch(launchUri.toString());
      } else {
        throw 'Could not launch $launchUri';
      }
    } catch (e) {
      print(e);
    }
  }
}
