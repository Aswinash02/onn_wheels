import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/controllers/checkout_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/checkout_repository.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:onnwheels/views/main_page/main_page.dart';
import 'package:onnwheels/views/order_details/components/order_page_card.dart';
import 'package:onnwheels/views/order_details/order_details_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'components/google_map_widget.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key,
      required this.imageUrl,
      required this.startTime,
      required this.endTime,
      required this.station,
      required this.totalPayableAmount,
      required this.lat,
      required this.long,
      required this.name,
      required this.id});

  final String imageUrl;
  final String startTime;
  final String endTime;
  final String station;
  final String totalPayableAmount;
  final String lat;
  final String long;
  final String name;
  final int id;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _razorpay = Razorpay();
  late Map<String, dynamic> paymentData;
  String apiKey = AppConfig.razorPayKey;
  String apiSecret = AppConfig.razorPaySecret;
  final CheckoutController checkoutController = Get.put(CheckoutController());
  final BikeDetailsController bikeDetailsController =
      Get.put(BikeDetailsController());

  @override
  void initState() {
    checkoutController.fetchUserName();
    checkoutController.fetchGstData(widget.totalPayableAmount);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBars().customAppBar(
        textColor: MyTheme.black,
        backgroundColor: MyTheme.white,
        title: "Checkout",
        setLeading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: MyTheme.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://onnwheels.com/storage/app/public/product/${widget.imageUrl}"),
                  ),
                ),
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.startTime),
                  Text(" To "),
                  Text(widget.endTime),
                ],
              ),
              Text(
                widget.station,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              MyMapWidget(
                latitude: double.tryParse(widget.lat)!, // Example latitude
                longitude: double.tryParse(widget.long)!, // Example longitude
              ),
              GetBuilder<CheckoutController>(
                builder: (checkoutController) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child:  Column(
                          children: [
                            keyValueWidget(
                              firstText: 'Booking Fee',
                              lastText: "\u20B9 ${widget.totalPayableAmount}",
                              fontWeight: FontWeight.w700,
                              fontWeight2: FontWeight.w700,
                              fontSize: 14,
                              fontSize2: 14,
                            ),
                            Obx(
                              () => keyValueWidget(
                                firstText: 'GST 9%',
                                lastText: "\u20B9 ${checkoutController.gstValue.value}",
                                // "\u20B9 ${checkoutController.getGstValueFromTotal(int.parse(widget.totalPayableAmount))}",
                                fontWeight: FontWeight.w500,
                                fontWeight2: FontWeight.w500,
                                fontSize: 16,
                                fontSize2: 16,
                              ),
                            ),
                            Obx(
                              () => keyValueWidget(
                                firstText: 'SGST 9%',
                                lastText:
                                    "\u20B9 ${checkoutController.gstValue2.value}",
                                // "\u20B9 ${checkoutController.getGstValueFromTotal(int.parse(widget.totalPayableAmount))}",
                                fontWeight: FontWeight.w500,
                                fontWeight2: FontWeight.w500,
                                fontSize: 16,
                                fontSize2: 16,
                              ),
                            ),
                             keyValueWidget(
                                  firstText: 'Total Payable Amount',
                                  lastText:
                                      "\u20B9 ${checkoutController.calculateNinePercent(int.tryParse(widget.totalPayableAmount)!)}",
                                  fontWeight: FontWeight.bold,
                                  fontWeight2: FontWeight.bold,
                                  fontSize: 16,
                                  fontSize2: 16,
                                ),

                          ],
                        ),

                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () {
                    paymentData = {
                      'amount': checkoutController.calculateNinePercent(
                              int.tryParse(widget.totalPayableAmount)!) *
                          100,
                      'currency': 'INR',
                      'receipt': 'order_receipt',
                      'payment_capture': '1',
                    };
                    initiatePayment();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0XFFF89520)),
                    child: Center(
                      child: CustomText(
                        text: "Make Payment",
                        color: MyTheme.black,
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget keyValueWidget(
      {String? firstText,
      String? lastText,
      FontWeight? fontWeight,
      FontWeight? fontWeight2,
      double? fontSize,
      double? fontSize2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText!,
          style: TextStyle(
              color: MyTheme.black,
              fontSize: fontSize!,
              fontWeight: fontWeight),
        ),
        Text(
          lastText!,
          style: TextStyle(
              color: MyTheme.black,
              fontSize: fontSize2,
              fontWeight: fontWeight2),
        )
      ],
    );
  }

  createOrder(String status) {
    var getOrderResponse = CheckoutRepository().getCheckoutResponse(
        checkoutController.userId.value,
        checkoutController.userName.value,
        checkoutController.userPhone.value,
        checkoutController.userEmail.value,
        widget.station,
        widget.long,
        widget.lat,
        bikeDetailsController.storeId.value,
        checkoutController
            .calculateNinePercent(int.parse(widget.totalPayableAmount)),
        // (int.parse(widget.totalPayableAmount) +
        //     int.parse(checkoutController.gst.toString()) +
        //     int.parse(checkoutController.sgst.toString())),
        int.parse(widget.totalPayableAmount),
        status,
        checkoutController.orderId.value,
        widget.id,
        0.0,
        widget.startTime,
        widget.endTime);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    createOrder("paid");
    Get.off(
      () => OrderCardListView(),
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    createOrder("unpaid");
    Get.offAll(() => MainPage());
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // debugPrint(response.walletName);
    // pay_by_wallet();
  }

  Future<void> initiatePayment() async {
    String apiUrl = 'https://api.razorpay.com/v1/orders';
    // Make the API request to create an order
    http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
      },
      body: jsonEncode(paymentData),
    );
    print("razorpay response body==============>${response.body}");

    if (response.statusCode == 200) {
      // Parse the response to get the order ID
      var responseData = jsonDecode(response.body);
      print("response Razorpay=========>${response.body}");
      checkoutController.orderId.value = responseData['id'];
      // Set up the payment options
      var options = {
        'key': apiKey,
        'amount': paymentData['amount'],
        'name': AppConfig.app_name,
        'order_id': checkoutController.orderId.value,
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {
          'contact': '9025075398',
          'email': 'chandrunair44@gmail.com'
        },
        'external': {
          'wallets': ['paytm'] // optional, for adding support for wallets
        }
      };

      // Open the Razorpay payment form
      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      // Handle error response
      debugPrint('Error creating order: ${response.body}');
    }
  }
}
