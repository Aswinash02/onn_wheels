import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/auth/components/input_decorations.dart';
import 'package:onnwheels/views/contact_us/components/card_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helpers/validator_helper.dart';
import '../bikedetails/components/text_widget.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
                      subText: "No 31, 20th L Cross, Ejipura, Near IOC Koramangala, Bangalore - 50047"),
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
                            // controller: _nameController,
                            autofocus: false,
                            decoration: InputDecorations.buildInputDecoration_1(
                                hint_text: "Your Name"),
                            // validator: Validator.validateName,
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
                            // controller: _nameController,
                            autofocus: false,
                            decoration: InputDecorations.buildInputDecoration_1(
                                hint_text: "Your Email"),
                            // validator: Validator.validateName,
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
                            // controller: _nameController,
                            autofocus: false,
                            decoration: InputDecorations.buildInputDecoration_1(
                                hint_text: "Subject"),
                            // validator: Validator.validateName,
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
                            // controller: _nameController,
                            autofocus: false,
                            maxLines: 5,
                            decoration: InputDecorations.buildInputDecoration_1(
                                hint_text: "Messages"),
                            // validator: Validator.validateName,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0XFF000080)),
                        child: Center(
                          child: CustomText(
                            text: "Send Message",
                            color: MyTheme.white,
                            fontSize: MediaQuery.of(context).size.width / 20,
                          ),
                        ),
                      ),
                    ],
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
