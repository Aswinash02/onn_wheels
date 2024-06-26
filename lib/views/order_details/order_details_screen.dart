import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/all_orders_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  final AllOrdersController allOrdersController =
      Get.put(AllOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: "Order Details",
          color: MyTheme.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.red,
              ),
              SizedBox(
                height: 15,
              ),
              CustomText(
                text: 'KTM Duke 390',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: '₹1500',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: 'Scheduled',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  Spacer(),
                  CustomText(
                    text: '6:30 pm',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image(
                      image: AssetImage('assets/calendar.png'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomText(
                    text: 'June 24, 2024',
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Store : sai',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              mapButton(),
              SizedBox(
                height: 15,
              ),
              invoiceButton(),
              SizedBox(
                height: 10,
              ),
              detailsRow1(
                  title: 'Status', value: 'Pending', color: Colors.teal.shade100),
              detailsRow(title: 'Payment Menthod', value: 'asdfghbvcdfg'),
              detailsRow(title: 'Reference Code', value: '₹26'),
              detailsRow1(
                  title: 'Order Type', value: 'Delivered', color: Colors.teal.shade100),
              detailsRow1(
                  title: 'Payment Status', value: 'Paid', color: Colors.green.shade200),
              Divider(
                thickness: 2,
              ),
              detailsRow(title: 'Item Price', value: '₹26'),
              detailsRow(title: 'Subtotal', value: '₹26'),
              detailsRow(title: 'Discount', value: '₹26'),
              detailsRow(title: 'Coupon Discount', value: '₹26'),
              detailsRow(title: 'Vat / Tax', value: '₹26'),
              detailsRow(title: 'Delivery Fee', value: '₹26'),
              Divider(
                thickness: 2,
              ),
              detailsRow(title: 'Delivery Man Tips', value: '₹26'),
              detailsRow(title: 'Additional Charge', value: '₹26'),
              detailsRow(title: 'Total', value: '₹26'),
              detailsRow(title: 'Due Amount ', value: '₹26'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget mapButton() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    child: Center(
      child: CustomText(
        text: 'Show Location On Map',
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    decoration: BoxDecoration(
        color: Colors.teal.shade300, borderRadius: BorderRadius.circular(10)),
  );
}

Widget invoiceButton() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10),
    child: Center(
      child: CustomText(
        text: 'Print Invoice',
        color: Colors.teal.shade300,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Colors.teal.shade300,
        )),
  );
}

Widget detailsRow({required String title, required String value}) {
  return Row(
    children: [
      Expanded(
        child: SizedBox(
          child: CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomText(
          text: ':',
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      Expanded(
          child: SizedBox(
        child: Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            text: value,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ))
    ],
  );
}

Widget detailsRow1(
    {required String title, required String value, required Color color}) {
  return Row(
    children: [
      Expanded(
        child: SizedBox(
          child: CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomText(
          text: ':',
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      Expanded(
          child: Row(
        children: [
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(5)),
            child: CustomText(
              text: value,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ))
    ],
  );
}
