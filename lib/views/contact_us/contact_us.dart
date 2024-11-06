import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/contact_us_controller.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/contact_repository.dart';
import 'package:onnwheels/repositories/verification_repositories.dart';
import 'package:onnwheels/views/auth/components/input_decorations.dart';
import 'package:onnwheels/views/contact_us/components/card_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helpers/validator_helper.dart';
import '../bikedetails/components/text_widget.dart';

class ContactUsPage extends StatefulWidget {
  ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  ContactUsController controller = Get.put(ContactUsController());

  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _subjectController = TextEditingController();

  TextEditingController _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  clearData() {
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
  }

  sendMessage() async {
    var contactResponse = await ContactRepository().getContactResponse(
        _nameController.text,
        _emailController.text,
        _subjectController.text,
        _messageController.text);
    ToastComponent.showDialog(contactResponse.message,
        gravity: Toast.center, duration: Toast.lengthLong);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getGeneralDetails();
  }

  Future<void> _onRefresh() async {
    await controller.getGeneralDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.contact_us_ucf,
          backgroundColor: MyTheme.white,
          textColor: MyTheme.black),
      body: RefreshIndicator(
        color: MyTheme.accent_color,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => GestureDetector(
                        onTap: controller.generalDetail.value.phone == null
                            ? null
                            : () {
                                controller.launchPhone();
                              },
                        child: controller.loadingState.value
                            ? buildShimmerCard()
                            : CardWidget(
                                imageDirectory: "assets/contact_call.png",
                                mainText: "Call Us",
                                subText: controller.generalDetail.value.phone
                                    .toString()),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.generalDetail.value.email == null
                            ? null
                            : () async {
                                controller.launchEmail();
                              },
                        child: controller.loadingState.value
                            ? buildShimmerCard()
                            : CardWidget(
                                imageDirectory: "assets/contact_mail.png",
                                mainText: "Email",
                                subText: controller.generalDetail.value.email ??
                                    '...'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(
                      () => controller.loadingState.value
                          ? buildShimmerCard()
                          : CardWidget(
                              imageDirectory: "assets/contact_location.png",
                              mainText: "Address",
                              subText: controller.generalDetail.value.address ??
                                  '...'),
                    ),
                    Obx(
                      () => controller.loadingState.value
                          ? buildShimmerCard()
                          : CardWidget(
                              imageDirectory: "assets/contact_time.png",
                              mainText: "Time",
                              subText:
                                  "${controller.generalDetail.value.openingTime} - ${controller.generalDetail.value.closingTime}"),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              AppLocalizations.of(context)!.name_ucf,
                              style: const TextStyle(
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              // height: 45,
                              child: TextFormField(
                                controller: _nameController,
                                autofocus: false,
                                cursorColor: MyTheme.orange,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[a-z A-Z]'))
                                ],
                                decoration:
                                    InputDecorations.buildInputDecoration_1(
                                        hint_text: "Your Name"),
                                validator: Validator.validateName,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              AppLocalizations.of(context)!.email_ucf,
                              style: const TextStyle(
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              // height: 45,
                              child: TextFormField(
                                controller: _emailController,
                                autofocus: false,
                                cursorColor: MyTheme.orange,
                                decoration:
                                    InputDecorations.buildInputDecoration_1(
                                        hint_text: "Your Email"),
                                validator: Validator.validateEmail,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              AppLocalizations.of(context)!.subject_ucf,
                              style: const TextStyle(
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              // height: 45,
                              child: TextFormField(
                                controller: _subjectController,
                                autofocus: false,
                                cursorColor: MyTheme.orange,
                                decoration:
                                    InputDecorations.buildInputDecoration_1(
                                        hint_text: "Subject"),
                                validator: Validator.validateSubject,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              AppLocalizations.of(context)!.message_ucf,
                              style: const TextStyle(
                                  color: MyTheme.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SizedBox(
                              child: TextFormField(
                                controller: _messageController,
                                autofocus: false,
                                maxLines: 5,
                                cursorColor: MyTheme.orange,
                                decoration: InputDecoration(
                                    hintText: "Message",
                                    filled: true,
                                    fillColor: MyTheme.white,
                                    hintStyle: const TextStyle(
                                        fontSize: 12.0,
                                        color: MyTheme.textfield_grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.textfield_grey,
                                          width: 0.2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6.0),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.accent_color,
                                          width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6.0),
                                      ),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.brick_red, width: 1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6.0),
                                      ),
                                    ),
                                    focusedErrorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: MyTheme.brick_red, width: 2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6.0),
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10)),
                                validator: Validator.validateMessage,
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyTheme.accent_color),
                              child: Center(
                                child: CustomText(
                                  text: "Send Message",
                                  color: MyTheme.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                sendMessage();
                                clearData();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(15)),
        height: 110,
        width: 160,
      ),
    );
  }
}
