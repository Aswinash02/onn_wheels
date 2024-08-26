import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/auth_controller.dart';
import 'package:onnwheels/customs/auth_ui.dart';
import 'package:onnwheels/customs/loading_class.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/helpers/validator_helper.dart';
import 'package:onnwheels/models/user_info_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/auth_repositories.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/utils/btn_elements.dart';
import 'package:onnwheels/utils/shared_preference.dart';
import 'package:onnwheels/views/auth/signin.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:toast/toast.dart';

import 'components/input_decorations.dart';

class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';

  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  var countries_code = <String?>[];

  String? _phone = "";
  String otpPin = '';

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  OtpFieldController _verificationController = OtpFieldController();

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
          .getConfirmCodeResponse(code, _phoneNumberController.text);

      if (response != null) {
        UserInfo userInfo = UserInfo(
          id: response.user?.id,
          name: response.user?.fName,
          email: response.user?.email,
          phone: response.user?.phone,
        );

        Get.find<AuthController>().saveUserInfo(userInfo);
        SharedPreference().setUserData(loginResponse: response);
        Navigator.of(context).pop();
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

  onPressedSendOTP() async {
    if (_phoneNumberController.text.isEmpty) {
      ToastComponent.showDialog("Enter Phone Number",
          gravity: Toast.center, duration: Toast.lengthLong);
    } else if (_phoneNumberController.text.length < 10) {
      ToastComponent.showDialog("Enter Valid Phone Number",
          gravity: Toast.center, duration: Toast.lengthLong);
    } else {
      try {
        Loading.show(context);

        var response = await AuthRepository().getLoginResponsePhone(
          _phoneNumberController.text.trim().toString(),
        );
        print('response ------- ${response}');
        Loading.close();
        if (response != null) {
          sendOtp();
        }
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
  }

  sendOtp() {
    showDialog(
      barrierDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (_) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Text(
            "Enter OTP to Login",
            maxLines: 3,
            style: TextStyle(color: MyTheme.font_grey, fontSize: 14),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        content: OTPTextField(
          keyboardType: TextInputType.number,
          controller: _verificationController,
          length: 4,
          textFieldAlignment: MainAxisAlignment.spaceBetween,
          fieldWidth: 40,
          fieldStyle: FieldStyle.box,
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
        actions: [
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.close_ucf,
              style: TextStyle(color: MyTheme.medium_grey),
            ),
            onPressed: () {
              // Navigator.pop(context, true);
              Navigator.of(_).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: MyTheme.accent_color,
            ),
            child: Text(
              AppLocalizations.of(context)!.confirm_ucf,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              onPressConfirm();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context,
        "${AppLocalizations.of(context)!.login_to} " + AppConfig.app_name,
        buildBody(context, _screen_width));
  }

  Widget buildBody(BuildContext context, double _screen_width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: _screen_width * (3 / 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  _login_by == "email"
                      ? AppLocalizations.of(context)!.email_ucf
                      : AppLocalizations.of(context)!.login_screen_phone,
                  style: TextStyle(
                      color: MyTheme.accent_color, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      // height: 45,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        autofocus: false,
                        onChanged: (String str) {
                          if (str.length == 10) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                        decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "01XXX XXX XXX"),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        validator: Validator.validatePhone,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 45,
                  child: Btn.minWidthFixHeight(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50,
                    color: MyTheme.black,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6.0))),
                    child: Text(
                      "Sent OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () async {
                      onPressedSendOTP();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                child: Btn.minWidthFixHeight(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  color: MyTheme.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.or_login_with_an_email,
                    style: TextStyle(
                        color: MyTheme.accent_color,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
