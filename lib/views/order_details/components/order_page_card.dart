import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/order_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/order_card_list_view_simmer.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/order_details/order_details_screen.dart';

class OrderCardListView extends StatelessWidget {
  OrderCardListView({super.key});

  final OrderController allOrdersController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.white,
          foregroundColor: Colors.black,
          title: CustomText(
            text: 'My Orders',
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder<OrderController>(builder: (orderController) {
            return orderController.loading.value
                ? OrderCardListViewSimmer()
                : ListView.builder(
                    itemCount: orderController.allOrdersList.length,
                    itemBuilder: (context, index) {
                      final data = orderController.allOrdersList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderDetailsScreen(
                                      orderId: data.orderId!)));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://onnwheels.com/storage/app/public/product/${data.image}'))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: data.itemName ?? '',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      text: "\u20B9 ${data.totalAmount}",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CustomText(
                                      text: "${data.orderId}",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
          }),
        ));
  }
}
