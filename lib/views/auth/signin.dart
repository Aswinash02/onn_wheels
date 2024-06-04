import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onnwheels/helpers/auth_helper.dart';
import 'package:onnwheels/models/login_response_model.dart';
import 'package:onnwheels/views/auth/password_forgot.dart';
import 'package:onnwheels/views/auth/phone_login.dart';
import 'package:onnwheels/views/auth/signup.dart';
import '../../customs/auth_ui.dart';
import '../../helpers/validator_helper.dart';
import '../../mytheme.dart';
import '../../repositories/auth_repositories.dart';
import '../../utils/app_config.dart';
import '../../utils/btn_elements.dart';
import '../../utils/shared_value.dart';
import 'components/input_decorations.dart';
import 'package:crypto/crypto.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _login_by = "email"; //phone or email
  String initialCountry = 'US';

  // PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
  var countries_code = <String?>[];

  String? _phone = "";
  bool _passwordVisible = false;

  //controllers
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

  onPressedLogin() async {
    // Loading.show(context);
    var email = _emailController.text.toString();
    var password = _passwordController.text.toString();
    LoginResponse loginResponse = await AuthRepository().getLoginResponse(
        _login_by == 'email' ? email : _phone, password,);
    // Loading.close();
    AuthHelper().setUserData(loginResponse);
  }

  // onPressedFacebookLogin() async {
  //   try {
  //     final facebookLogin = await FacebookAuth.instance
  //         .login(loginBehavior: LoginBehavior.webOnly);
  //
  //     if (facebookLogin.status == LoginStatus.success) {
  //       // get the user data
  //       // by default we get the userId, email,name and picture
  //       final userData = await FacebookAuth.instance.getUserData();
  //       var loginResponse = await AuthRepository().getSocialLoginResponse(
  //           "facebook",
  //           userData['name'].toString(),
  //           userData['email'].toString(),
  //           userData['id'].toString(),
  //           access_token: facebookLogin.accessToken!.token);
  //       print("..........................${loginResponse.toString()}");
  //       if (loginResponse.result == false) {
  //         ToastComponent.showDialog(loginResponse.message!,
  //             gravity: Toast.center, duration: Toast.lengthLong);
  //       } else {
  //         ToastComponent.showDialog(loginResponse.message!,
  //             gravity: Toast.center, duration: Toast.lengthLong);
  //
  //         AuthHelper().setUserData(loginResponse);
  //         Navigator.push(context, MaterialPageRoute(builder: (context) {
  //           return MainPage();
  //         }));
  //         FacebookAuth.instance.logOut();
  //       }
  //       // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
  //     } else {
  //       print("....Facebook auth Failed.........");
  //       print(facebookLogin.status);
  //       print(facebookLogin.message);
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //     // TODO
  //   }
  // }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    final _screen_height = MediaQuery.of(context).size.height;
    final _screen_width = MediaQuery.of(context).size.width;
    return AuthScreen.buildScreen(
      context,
      "${AppLocalizations.of(context)!.login_to} ${AppConfig.app_name}",
      buildBody(context, _screen_width),
    );
  }

  Widget buildBody(BuildContext context, double _screen_width) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
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
                                  _login_by = "phone";
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!
                                    .or_login_with_a_phone,
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
                  padding: const EdgeInsets.only(bottom: 4.0, top: 4.0),
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
                          decoration: InputDecorations.buildInputDecoration_1(
                            hint_text: "password",
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
                                color: MyTheme.black,
                                size: 20,
                              ),
                            ),
                          ),
                          validator: Validator.validatePassword,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return PasswordForget();
                              }));
                        },
                        child: Text(
                          AppLocalizations.of(context)!
                              .login_screen_forgot_password,
                          style: const TextStyle(
                              color: MyTheme.black,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: MyTheme.textfield_grey, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0))),
                    child: Btn.minWidthFixHeight(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 50,
                      color: MyTheme.black,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))),
                      child: Text(
                        AppLocalizations.of(context)!.login_screen_log_in,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          onPressedLogin();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Processing Data')));
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: MyTheme.textfield_grey, width: 1),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12.0))),
                    child: Btn.minWidthFixHeight(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 50,
                      color: MyTheme.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(6.0))),
                      child: Text(
                        AppLocalizations.of(context)!.or_login_with_otp,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PhoneLogin();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: allow_google_login.$ || allow_facebook_login.$,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.login_screen_login_with,
                      style: const TextStyle(
                          color: MyTheme.font_grey, fontSize: 12),
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: allow_google_login.$,
                          child: InkWell(
                            onTap: () {
                              // onPressedGoogleLogin();
                            },
                            child: SizedBox(
                              width: 28,
                              child: Image.asset("assets/google_logo.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Visibility(
                            visible: allow_facebook_login.$,
                            child: InkWell(
                              onTap: () {
                                // onPressedFacebookLogin();
                              },
                              child: SizedBox(
                                width: 28,
                                child: Image.asset("assets/facebook_logo.png"),
                              ),
                            ),
                          ),
                        ),
                        if (allow_twitter_login.$)
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: InkWell(
                              onTap: () {
                                // onPressedTwitterLogin();
                              },
                              child: SizedBox(
                                width: 28,
                                child: Image.asset("assets/twitter_logo.png"),
                              ),
                            ),
                          ),
                        /* if (Platform.isIOS)
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            // visible: true,
                            child: A(
                              onTap: () async {
                                signInWithApple();
                              },
                              child: Container(
                                width: 28,
                                child: Image.asset("assets/apple_logo.png"),
                              ),
                            ),
                          ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                child: Center(
                    child: Text(
                  AppLocalizations.of(context)!
                      .login_screen_or_create_new_account,
                  style:
                      const TextStyle(color: MyTheme.font_grey, fontSize: 12),
                )),
              ),
              TextButton(
                onPressed: () {
                  // Your action here
                  Get.to(() => Registration());
                },
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(AppLocalizations.of(context)!.sign_up_ucf),
              )
            ],
          ),
        ],
      ),
    );
  }
}
