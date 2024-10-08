import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.white,
        foregroundColor: Colors.black,
        title: CustomText(
          text: 'FAQ',
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            expandableWidget(
                headerText:
                    'What documents are required at the time of bike pickup?',
                expandedContent:
                    "1) ORIGINAL DRIVING LICENSE needs to submit at time of bike pickup and same will be returned at the time of drop off and Aadhar Card softcopy for the Authentication."
                    "\n\n2) In case if you don’t carry the ORIGINAL DRIVING LICENSE at time of pickup, you have an option to make security deposit of Rs 3000/- which is completely refundable at time of return."),
            SizedBox(height: 10),
            expandableWidget(
                headerText: 'What is the cancellation Policy?',
                expandedContent:
                    "1) Cancellation made due to documents issues – NO QUESTIONS ASKED 90% REFUND WILL BE GIVEN."
                    "\n\n2) Cancellation made before 4 hours - NO QUESTIONS ASKED FULL REFUND"
                    "\n\n3) Cancellation made before 2 hours – 50% ASKED FULL REFUND"
                    "\n\n4) Cancellation made after the booking start time – NO REFUNDS"
                    "\n\n5) Cancellation made after the bike pickup – REFUND WILL BE CALCULATED ON PRO RATA BASED"
                    "\n\n6) In Case no show – NO REFUND  "
                    "\n\n7) Note: (Cancellation refund will be done through the original payment method within 2- 5 working days) "),
            SizedBox(height: 10),
            expandableWidget(
              headerText: 'What is the Damage Policy?',
              expandedContent:
                  "1) The customer has to pay for any damages to, loss of, or theft regardless of the cause or fault, which will be paid at market price."
                  "\n\n2) Insurance will not be claimed for damages that are below repairable within Rs 12,000, charges exceeding amount of 12,000 will be claimed from the insurance for vehicles less than 150 cc."
                  "\n\n3) Damage charges should be paid by customers as per the service center quotation, and inoperative days during the repair period shall be charged accordingly."
                  "\n\n4) If customer is willing repair the vehicle from there end, Yes can repair the vehicle from authorized service center."
                  "\n\n5) It's the customer’s responsibility to make videos and pictures of the vehicle at the time of pickup.",
            ),
            SizedBox(height: 10),
            expandableWidget(
              headerText: 'What are the Delay Charges?',
              expandedContent:
                  "The first 30 minutes is a grace period after 30 mins it will be hourly charges as per the bike tariff.",
            ),
            SizedBox(height: 10),
            expandableWidget(
              headerText: 'What if an Extension is needed?',
              expandedContent:
                  "Do please reach out the customer care to extend or you have option to extend the booking through the applications."
                  "\n\nAfter the drop time, extension will be charges Rs 50 extra. ",
            ),
          ],
        ),
      ),
    );
  }
}

Widget expandableWidget(
    {required String headerText, required String expandedContent}) {
  return ExpandablePanel(
    header: Text(
      headerText,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    collapsed: Text(
      "",
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    expanded: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        expandedContent,
        style: TextStyle(fontSize: 14),
      ),
    ),
    theme: ExpandableThemeData(
        iconColor: MyTheme.accent_color,
        collapseIcon: Icons.keyboard_arrow_up,
        expandIcon: Icons.keyboard_arrow_down,
        iconPadding: EdgeInsets.all(0)),
  );
}
