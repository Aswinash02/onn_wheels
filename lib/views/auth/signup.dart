import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onnwheels/customs/auth_ui.dart';
import 'package:onnwheels/customs/loading_class.dart';
import 'package:onnwheels/helpers/validator_helper.dart';
import 'package:onnwheels/models/signup_model.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/auth_repositories.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/utils/btn_elements.dart';
import 'package:onnwheels/utils/shared_value.dart';
import 'package:onnwheels/views/auth/signin.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onnwheels/views/webview/webview.dart';
import 'components/input_decorations.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';

  var countries_code = <String?>[];

  // bool? _isAgree = false;
  String googleRecaptchaKey = "";
  bool _passwordVisible = false;

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  onPressSignUp() async {
    FocusScope.of(context).unfocus();
    Loading.show(context);
    var name = _nameController.text.toString();
    var email = _emailController.text.toString();
    var phone = _phoneNumberController.text.toString();
    var password = _passwordController.text.toString();
    SignupResponse? res = await AuthRepository().getSignupResponse(
      name,
      email,
      phone,
      password,
    );

    if (res?.result == true) {
      print('otp *********** ${res!.otp}');
      clearConData();
    }
    // SharedPreference().setUserData(loginResponse: signupResponse);
    Loading.close();
  }

  void clearConData() {
    _nameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _passwordController.clear();
    // _isAgree == false;
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
        context,
        "${AppLocalizations.of(context)!.join_ucf} ${AppConfig.app_name}",
        buildBody(context, _screen_width));
  }

  Widget buildBody(BuildContext context, double _screen_width) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: _screen_width * (3 / 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.name_ucf,
                    style: const TextStyle(
                        color: MyTheme.white, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                    // height: 45,
                    child: TextFormField(
                      controller: _nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
                      ],
                      autofocus: false,
                      decoration: InputDecorations.buildInputDecoration_1(
                          hint_text: "John Doe"),
                      validator: Validator.validateName,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    _register_by == "email"
                        ? AppLocalizations.of(context)!.email_ucf
                        : AppLocalizations.of(context)!.phone_ucf,
                    style: const TextStyle(
                        color: MyTheme.white, fontWeight: FontWeight.w600),
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
                          controller: _emailController,
                          autofocus: false,
                          decoration: InputDecorations.buildInputDecoration_1(
                              hint_text: "johndoe@example.com"),
                          validator: Validator.validateEmail,
                        ),
                      ),
                      otp_addon_installed.$
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _register_by = "phone";
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .or_register_with_a_phone,
                                style: const TextStyle(
                                    color: MyTheme.accent_color,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.phone_ucf,
                    style: const TextStyle(
                        color: MyTheme.white, fontWeight: FontWeight.w600),
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          autofocus: false,
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
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.password_ucf,
                    style: const TextStyle(
                        color: MyTheme.white, fontWeight: FontWeight.w600),
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
                          controller: _passwordController,
                          autofocus: false,
                          obscureText: !_passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: Validator.validatePassword,
                          decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "• • • • • • • •",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _passwordVisible = !_passwordVisible;
                                  },
                                );
                              },
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: MyTheme.accent_color,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .password_must_contain_at_least_8_characters,
                        style: const TextStyle(
                            color: MyTheme.white, fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    height: 45,
                    child: Btn.minWidthFixHeight(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: MyTheme.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0))),
                        child: Text(
                          AppLocalizations.of(context)!.sign_up_ucf,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            onPressSignUp();
                          }
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(
                        AppLocalizations.of(context)!.already_have_an_account,
                        style: const TextStyle(
                            color: MyTheme.font_grey, fontSize: 12),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Text(
                          AppLocalizations.of(context)!.log_in,
                          style: const TextStyle(
                              color: MyTheme.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
