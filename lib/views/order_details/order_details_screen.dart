import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/order_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/bike_details_simmer.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final OrderController orderController = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderController.getOrderDetails(orderId: widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: CustomText(
          text: '${widget.orderId}',
          color: MyTheme.black,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => orderController.loadingState.value
            ? CustomSimmer()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://onnwheels.com/storage/app/public/product/${orderController.order.value.items?.first.image}'))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text:
                            orderController.order.value.items?.first.itemName ??
                                '',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: orderController.order.value.orderAmount != null
                            ? "\u20B9 ${orderController.order.value.orderAmount}"
                            : "\u20B9 0",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      detailsRow(
                          title: 'Quantity',
                          value:
                              "${orderController.order.value.items?.first.quantity}"),
                      detailsRow1(
                          title: 'Order Status',
                          value: orderController.order.value.orderStatus ?? '',
                          color: Colors.teal.shade100),
                      detailsRow1(
                          title: 'Payment Status',
                          value: "${orderController.order.value.paymentStatus}",
                          color: Colors.green.shade200),
                      detailsRow(
                          title: 'CreatedAt',
                          value: "${orderController.order.value.createdAt}",
                          valueFontSize: 14),detailsRow(
                          title: 'Pickup Date',
                          value: "${orderController.order.value.items!.first.fromDate}",
                          valueFontSize: 14),detailsRow(
                          title: 'Drop Date',
                          value: "${orderController.order.value.items!.first.toDate}",
                          valueFontSize: 14),
                      detailsRow(
                        title: 'Item Price',
                        value: orderController
                                    .order.value.items?.first.unitPrice !=
                                null
                            ? "\u20B9 ${orderController.order.value.items?.first.unitPrice}"
                            : "\u20B9 0",
                      ),
                      detailsRow(
                          title:
                              'GST (${orderController.order.value.gst}%) ',
                          value:
                              "\u20B9 ${orderController.order.value.items?.first.gstAmount}"),
                      detailsRow(
                          title: 'SGST (${orderController.order.value.sgst}%) ',
                          value:
                              "\u20B9 ${orderController.order.value.items?.first.sgstAmount}"),
                      detailsRow(
                        title: 'Helmet Price',
                        value: "\u20B9 ${orderController.order.value.items!.first.helmetPrice}",
                      ),
                      detailsRow(
                        title: 'Discount',
                        value: orderController.order.value.items!.first.discount !=
                            null
                            ? "\u20B9 ${orderController.order.value.items!.first.discount}"
                            : "\u20B9 0",
                      ),
                      detailsRow(
                        title: 'Total Price',
                        value: orderController.order.value.items?.first.price !=
                                null
                            ? "\u20B9 ${orderController.order.value.items?.first.price}"
                            : "\u20B9 0",
                      ),
                    ],
                  ),
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

Widget detailsRow(
    {required String title, required String value, double? valueFontSize}) {
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
          child: FittedBox(
            child: CustomText(
              text: value,
              fontWeight: FontWeight.w600,
              fontSize: valueFontSize ?? 15,
            ),
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
