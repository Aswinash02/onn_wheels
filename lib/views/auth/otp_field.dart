import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/auth_controller.dart';
import 'package:onnwheels/customs/loading_class.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/main_page/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import '../../customs/toastcomponent.dart';
import '../../helpers/auth_helper.dart';
import '../../helpers/validator_helper.dart';
import '../../mytheme.dart';
import '../../repositories/auth_repositories.dart';
import '../../utils/btn_elements.dart';
import '../../utils/shared_value.dart';
import 'components/input_decorations.dart';

class Otp extends StatefulWidget {
  String? title;
  String phoneNumber;

  Otp({Key? key, this.title, this.phoneNumber = ""}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  //controllers
  OtpFieldController _verificationController = OtpFieldController();
  String otpPin = "";

  onPressConfirm() async {
    var code = otpPin;
    if (code == "") {
      ToastComponent.showDialog(
          AppLocalizations.of(context)!.enter_verification_code,
          gravity: Toast.center,
          duration: Toast.lengthLong);
      return;
    }
    try {
      Loading.show(context);

      var response = await AuthRepository()
          .getConfirmCodeResponse(code, widget.phoneNumber);

      if (response != null) {
        UserInfo userInfo = UserInfo(
          id: response.user?.id,
          name: response.user?.fName,
          email: response.user?.email,
          phone: response.user?.phone,
        );

        Get.find<AuthController>().saveUserInfo(userInfo);
        SharedPreference().setUserData(loginResponse: response);
      }

      Loading.close();
    } catch (e) {
      Loading.close();
      print("Error occurred during login: $e");
      ToastComponent.showDialog(
        e.toString(),
        gravity: Toast.center,
        duration: Toast.lengthLong,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                    child: Container(
                      width: 75,
                      height: 75,
                      child: Image.asset("assets/app_logo.png"),
                    ),
                  ),
                  Container(
                    width: _screen_width * (3 / 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 15),
                          child: Text(
                            "Mobile Number Verification",
                            style: TextStyle(
                                fontSize: 20,
                                color: MyTheme.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            "Enter the 4-digit verification code send to your email address.",
                            style: TextStyle(
                                fontSize: 12, color: MyTheme.grey_153),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OTPTextField(
                            keyboardType: TextInputType.number,
                            controller: _verificationController,
                            length: 4,
                            fieldStyle: FieldStyle.box,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            // Adjust based on space
                            fieldWidth: 40,
                            // Adjust fieldWidth dynamically
                            outlineBorderRadius: 15,
                            style: TextStyle(fontSize: 16),
                            onChanged: (pin) {
                              print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                              setState(() {
                                otpPin = pin;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyTheme.textfield_grey, width: 1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12.0))),
                            child: Btn.basic(
                              minWidth: MediaQuery.of(context).size.width,
                              color: MyTheme.accent_color,
                              shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              child: Text(
                                AppLocalizations.of(context)!.confirm_ucf,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                onPressConfirm();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: InkWell(
                      onTap: () {},
                      child: Text(AppLocalizations.of(context)!.resend_code_ucf,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: MyTheme.accent_color,
                              decoration: TextDecoration.underline,
                              fontSize: 13)),
                    ),
                  ),
                  // SizedBox(height: 15,),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40.0, right: 40, left: 40),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: MyTheme.textfield_grey, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      child: Btn.basic(
                        minWidth: MediaQuery.of(context).size.width,
                        color: MyTheme.black,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0))),
                        child: Text(
                          AppLocalizations.of(context)!.back_ucf,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  onTapLogout(context) async {
    // AuthHelper().clearUserData();
    context.go("/");
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    //   return Main();
    // }), (route) => false);
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: false,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(CupertinoIcons.arrow_left, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Verification Code",
        style: TextStyle(fontSize: 16, color: MyTheme.black),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
