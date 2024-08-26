import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/main_page/main_page.dart';

class KycSubmitScreen extends StatelessWidget {
  const KycSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Center(
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/Successmark.png"),
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 10),
                const CustomText(
                  text: "KYC Submitted",
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
                const SizedBox(height: 40),
                const CustomText(
                  text: "Thanks for submitting your document we’ll "
                      "verify it and complete your KYC as soon as possible",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFF000080),
                    ),
                    child: Center(
                      child: CustomText(
                        text: "Back To Home",
                        color: MyTheme.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
