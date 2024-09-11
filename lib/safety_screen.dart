import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        foregroundColor: Colors.black,
        title: CustomText(
          text: 'Safety',
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Advantages for using two wheeler for safety and health",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text:
                "With safety being the top priority for every individual, it gets riskier to use public transport at the moment with so many concerns regarding the hygiene and safety of such transportation. At the same time social distancing is becoming our number one practise which makes it even more difficult to use any kind of transport. Two wheelers being the most safest for commuting at this point, ONN Bikes is taking every measure to make two wheelers available to the public in a safe manner.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "How ONN is ensuring safety for everyone",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Daily temperature checks for the team",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Operating at minimum capacity to ensure effective social distancing. Our on-ground team is regularly screened for any signs or symptoms of illness, only then are they allowed to continue working. They are provided with all the safety standards and follow all safety procedures.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "All teams using masks at all times",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "With Social distancing being the most, important thing at this moment, we provide our on-ground team with all the safety requirements. All the members are provided with masks to be worn at all times",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Steps our on-ground team is taking to ensure safety",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Daily temperature checks for the entire team",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Our on-ground team is regularly screened for any signs or symptoms of illness, only then are they allowed to continue operations.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "All teams using masks at all times",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "With social distancing being imperative, ONN provides the on-ground team with masks. The teams are directed to wear the masks at all times.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Aarogya Setu app used by all teams",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Our team takes all the safety procedures, every employee uses the Aarogya Setu app to stay updated with the latest information.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Stations are being sanitized daily",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "ONN Stations are being sanitized with disinfectant daily, our team makes sure that the station is safe for customers to visit at all times",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Benefits of choosing ONN",
                maxLines: 2,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Long term bookings",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Customers can avail from flexible subscriptions in the current pandemic. Long term subscriptions available.",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Easy bike sharing",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Share the bike with your friends and family with our exclusive Share Key service at the tap of a button without any additional cost",
                maxLines: 20,
              ),
              SizedBox(height: 10),
              CustomText(
                text: "Variety of bikes",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Ride a different bike every time you book. Choose from a wide variety of bikes available at ONN Bikes. We have a bike for all your commute needs.",
                maxLines: 20,
              ), SizedBox(height: 10),
              CustomText(
                text: "Easy payments and refunds",
                maxLines: 3,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              SizedBox(height: 10),
              CustomText(
                text:
                "Combining tech and mobility, ONN Bikes offers the most efficient platform for all your commute needs. Get access to flexible plans",
                maxLines: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
