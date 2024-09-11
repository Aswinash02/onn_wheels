import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        foregroundColor: Colors.black,
        title: CustomText(
          text: 'About Us',
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Unleash your journey: The Drivewise Advantage",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                    "Immerse yourself in a world of possibilities with our extensive range of vehicles. From sleek sedans to rugged SUVs and luxurious convertibles, we have the perfect wheels to match your style, preferences, and the demands of your adventure.",
                maxLines: 20,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: "Beyond Rentals, Building Memories",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                    "We are more than just a car rental service. We strive to be your travel companion, providing recommendations, tips, and local insights to help you create unforgettable memories. Count on us to make your journey not only comfortable but also enriching and unforgettable.",
                maxLines: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: "Our Services",
                  maxLines: 3,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Bike Hire",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                    "We pride ourselves in always going the extra mile for our customers.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Bike Sales",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                    "we sale the best luxury Bikes across the world at a competitive price.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Hire a driver",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                    "You want to travel and fell confortable , our drivers are available.",
                maxLines: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
