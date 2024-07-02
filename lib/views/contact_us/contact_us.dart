import 'package:flutter/material.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/contact_repository.dart';
import 'package:onnwheels/repositories/verification_repositories.dart';
import 'package:onnwheels/views/auth/components/input_decorations.dart';
import 'package:onnwheels/views/contact_us/components/card_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:toast/toast.dart';

import '../../helpers/validator_helper.dart';
import '../bikedetails/components/text_widget.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.contact_us_ucf,
          backgroundColor: MyTheme.white,
          textColor: MyTheme.black),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardWidget(
                      imageDirectory: "assets/contact_call.png",
                      mainText: "Call Us",
                      subText: "8550049900"),
                  CardWidget(
                      imageDirectory: "assets/contact_mail.png",
                      mainText: "Email",
                      subText: "info@onnwheels.com")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CardWidget(
                      imageDirectory: "assets/contact_location.png",
                      mainText: "Address",
                      subText:
                          "No 31, 20th L Cross, Ejipura, Near IOC Koramangala, Bangalore - 50047"),
                  CardWidget(
                      imageDirectory: "assets/contact_time.png",
                      mainText: "Time",
                      subText: "6.00am - 6.00pm")
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
                            // height: 45,
                            child: TextFormField(
                              controller: _messageController,
                              autofocus: false,
                              maxLines: 5,
                              decoration:
                                  InputDecorations.buildInputDecoration_1(
                                      hint_text: "Messages"),
                              validator: Validator.validateMessage,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0XFF000080)),
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
    );
  }
}
