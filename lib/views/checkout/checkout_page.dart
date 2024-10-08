import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/bike_details_controller.dart';
import 'package:onnwheels/controllers/checkout_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/repositories/checkout_repository.dart';
import 'package:onnwheels/simmer/bike_details_simmer.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:onnwheels/views/main_page/main_page.dart';
import 'package:onnwheels/views/order_details/components/order_page_card.dart';
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
      required this.id,
      required this.weekEndPrice,
      required this.kmLimit,
      required this.vehicleNumber,
      required this.discount,
      required this.helmetPrice});

  final String imageUrl;
  final String startTime;
  final String endTime;
  final String station;
  final int totalPayableAmount;
  final String lat;
  final String long;
  final String name;
  final int id;
  final int weekEndPrice;
  final int kmLimit;
  final String vehicleNumber;
  final int discount;
  final int helmetPrice;

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
    print('totalPayableAmount ------ ${widget.totalPayableAmount}');
    checkoutController.fetchUserName();

    checkoutController
        .fetchGstData(widget.totalPayableAmount + widget.helmetPrice);
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
      body: Obx(
        () => checkoutController.loadingState.value
            ? CustomSimmer()
            : Padding(
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
                                "${AppConfig.BASE_URL}/storage/app/public/product/${widget.imageUrl}"),
                          ),
                        ),
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyMapWidget(
                        latitude: double.tryParse(widget.lat)!,
                        longitude: double.tryParse(widget.long)!,
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
                          child: Column(
                            children: [
                              keyValueWidget(
                                firstText: 'Booking Fee',
                                lastText: "\u20B9 ${widget.totalPayableAmount}",
                                fontWeight: FontWeight.w700,
                                fontWeight2: FontWeight.w700,
                                fontSize: 14,
                                fontSize2: 14,
                              ),
                              keyValueWidget(
                                firstText: 'Helmet Fee',
                                lastText: "\u20B9 ${widget.helmetPrice}",
                                fontWeight: FontWeight.w500,
                                fontWeight2: FontWeight.w500,
                                fontSize: 16,
                                fontSize2: 16,
                              ),
                              Obx(
                                () => keyValueWidget(
                                  firstText: 'GST 9%',
                                  lastText:
                                      "\u20B9 ${checkoutController.gstValue.value}",
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
                                  fontWeight: FontWeight.w500,
                                  fontWeight2: FontWeight.w500,
                                  fontSize: 16,
                                  fontSize2: 16,
                                ),
                              ),
                              keyValueWidget(
                                firstText: 'Discount',
                                lastText: "\u20B9 ${widget.discount}",
                                fontWeight: FontWeight.w500,
                                fontWeight2: FontWeight.w500,
                                fontSize: 16,
                                fontSize2: 16,
                              ),
                              keyValueWidget(
                                firstText: 'Total Payable Amount',
                                lastText:
                                    "\u20B9 ${checkoutController.calculateNinePercent(widget.totalPayableAmount + widget.helmetPrice) - widget.discount}",
                                fontWeight: FontWeight.bold,
                                fontWeight2: FontWeight.bold,
                                fontSize: 16,
                                fontSize2: 16,
                              ),
                            ],
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () async {
                            paymentData = {
                              'amount':
                                  (checkoutController.calculateNinePercent(
                                              widget.totalPayableAmount +
                                                  widget.helmetPrice) -
                                          widget.discount) *
                                      100,
                              'currency': 'INR',
                              'receipt': 'order_receipt',
                              'payment_capture': '1',
                            };
                            await initiatePayment();
                            Get.find<BikeDetailsController>().clearData();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyTheme.accent_color),
                            child: Center(
                              child: CustomText(
                                text: "Make Payment",
                                color: MyTheme.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                              ),
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

  createOrder(String status) async {
    await CheckoutRepository().getCheckoutResponse(
        userId: checkoutController.userId.value,
        userName: checkoutController.userName.value,
        phone: checkoutController.userPhone.value,
        email: checkoutController.userEmail.value,
        address: widget.station,
        long: widget.long,
        lat: widget.lat,
        store_id: bikeDetailsController.storeId.value,
        amount: checkoutController.calculateNinePercent(
                widget.totalPayableAmount + widget.helmetPrice) -
            widget.discount,
        unitAmount: widget.totalPayableAmount,
        status: status,
        transactionReference: checkoutController.orderId.value,
        item_id: widget.id,
        distance: 0.0,
        startDate: widget.startTime,
        endDate: widget.endTime,
        weekEndPrice: widget.weekEndPrice,
        kmLimit: widget.kmLimit,
        vehicleNumber: widget.vehicleNumber,
        discount: widget.discount,
        helmetPrice: widget.helmetPrice);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print('response Success data ${response.data}');
    print('response Success orderId ${response.orderId}');
    print('response Success paymentId ${response.paymentId}');
    print('response Success signature ${response.signature}');
    createOrder("paid");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OrderCardListView()));
  }

  void handlePaymentError(PaymentFailureResponse response) {
    print('response Error code ${response.code}');
    print('response Error message ${response.message}');
    print('response Error error ${response.error}');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // debugPrint(response.walletName);
    // pay_by_wallet();
  }

  Future<void> initiatePayment() async {
    String apiUrl = 'https://api.razorpay.com/v1/orders';

    try {
      http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
        },
        body: jsonEncode(paymentData),
      );

      print("Razorpay response body: ${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Parsed Razorpay response: $responseData");
        checkoutController.orderId.value = responseData['id'];
        var options = {
          'key': apiKey,
          'amount': paymentData['amount'],
          'name': AppConfig.app_name,
          'order_id': checkoutController.orderId.value,
          'retry': {'enabled': true, 'max_count': 1},
          'send_sms_hash': true,
          'prefill': {
            'contact': '9025075398',
            'email': 'chandrunair44@gmail.com',
          },
          'external': {
            'wallets': ['paytm']
          },
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint('Error opening Razorpay: $e');
        }
      } else {
        debugPrint('Error creating Razorpay order: ${response.body}');
      }
    } catch (e) {
      debugPrint('Exception during payment initiation: $e');
    }
  }
}
