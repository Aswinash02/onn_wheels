import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onnwheels/helpers/validator_helper.dart';
import 'package:onnwheels/views/auth/signin.dart';
import '../../customs/auth_ui.dart';
import '../../mytheme.dart';
import '../../repositories/auth_repositories.dart';
import '../../utils/app_config.dart';
import '../../utils/btn_elements.dart';
import '../../utils/shared_value.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../webview/webview.dart';
import 'components/input_decorations.dart';
import 'otp_field.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _register_by = "email"; //phone or email
  String initialCountry = 'US';

  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  var countries_code = <String?>[];

  String? _phone = "";
  bool? _isAgree = false;
  bool _isCaptchaShowing = false;
  String googleRecaptchaKey = "";
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  //controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //on Splash Screen hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    fetch_country();
  }

  fetch_country() async {
    // var data = await AddressRepository().getCountryList();
    // data.countries.forEach((c) => countries_code.add(c.code));
  }

  @override
  void dispose() {
    //before going to other screen show statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  onPressSignUp() async {
    // Loading.show(context);
    //
    var name = _nameController.text.toString();
    var email = _emailController.text.toString();
    var phone = _phoneNumberController.text.toString();
    var password = _passwordController.text.toString();

    var signupResponse = await AuthRepository().getSignupResponse(
      name,
      email,
      phone,
      password,
      // googleRecaptchaKey
    );
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
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 4.0),
                //   child: Text(
                //     AppLocalizations.of(context)!.retype_password_ucf,
                //     style: const TextStyle(
                //         color: MyTheme.white, fontWeight: FontWeight.w600),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 8.0),
                //   child: SizedBox(
                //     // height: 45,
                //     child: TextFormField(
                //       controller: _passwordConfirmController,
                //       autofocus: false,
                //       obscureText: !_confirmPasswordVisible,
                //       enableSuggestions: false,
                //       autocorrect: false,
                //       validator: (value) => Validator.validateConfirmPassword(
                //           _passwordController.text, value),
                //       decoration: InputDecorations.buildInputDecoration_1(
                //         hint_text: "• • • • • • • •",
                //         suffixIcon: IconButton(
                //           onPressed: () {
                //             setState(
                //               () {
                //                 _confirmPasswordVisible =
                //                     !_confirmPasswordVisible;
                //               },
                //             );
                //           },
                //           icon: Icon(
                //             _confirmPasswordVisible
                //                 ? Icons.visibility
                //                 : Icons.visibility_off,
                //             color: MyTheme.accent_color,
                //             size: 20,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                        width: 15,
                        child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            value: _isAgree,
                            onChanged: (newValue) {
                              _isAgree = newValue;
                              setState(() {});
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width - 130,
                          child: RichText(
                              maxLines: 2,
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: MyTheme.font_grey, fontSize: 12),
                                  children: [
                                    const TextSpan(
                                      text: "I agree to the",
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommonWebviewScreen(
                                                        page_name:
                                                            "Terms Conditions",
                                                        url:
                                                            "${AppConfig.RAW_BASE_URL}/mobile-page/terms",
                                                      )));
                                        },
                                      style:
                                          const TextStyle(color: MyTheme.white),
                                      text: " Terms Conditions",
                                    ),
                                    const TextSpan(
                                      text: " &",
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommonWebviewScreen(
                                                        page_name:
                                                            "Privacy Policy",
                                                        url:
                                                            "${AppConfig.RAW_BASE_URL}/mobile-page/privacy-policy",
                                                      )));
                                        },
                                      text: " Privacy Policy",
                                      style:
                                          const TextStyle(color: MyTheme.white),
                                    )
                                  ])),
                        ),
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
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: Text(
                        AppLocalizations.of(context)!.sign_up_ucf,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: _isAgree!
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                onPressSignUp();
                              }
                            }
                          : null,
                    ),
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
