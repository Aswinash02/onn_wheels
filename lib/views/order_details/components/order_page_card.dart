import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/order_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/order_card_list_view_simmer.dart';
import 'package:onnwheels/utils/app_config.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/order_details/order_details_screen.dart';

class OrderCardListView extends StatefulWidget {
  OrderCardListView({super.key});

  @override
  State<OrderCardListView> createState() => _OrderCardListViewState();
}

class _OrderCardListViewState extends State<OrderCardListView> {
  final OrderController allOrdersController = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allOrdersController.getAllOrders();
    });
  }

  Future<void> _onRefresh() async {
    allOrdersController.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyTheme.white,
          foregroundColor: Colors.black,
          title: CustomText(
            text: 'My Bookings',
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          color: MyTheme.accent_color,
          onRefresh:_onRefresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GetBuilder<OrderController>(builder: (orderController) {
              return orderController.loading.value
                  ? OrderCardListViewSimmer()
                  : orderController.allOrdersList.isEmpty
                      ? Center(
                          child: CustomText(
                            text: 'No Order Found',
                          ),
                        )
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
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/placeholder.png',
                                          image:
                                              '${AppConfig.BASE_URL}/storage/app/public/product/${data.image}',
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/placeholder.png',
                                              fit: BoxFit.fill,
                                            );
                                          },
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 170,
                                            child: CustomText(
                                              text: data.itemName ?? '',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              maxLines: 2,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          dataRow(
                                              title: "Order Id",
                                              value: "${data.orderId}"),
                                          dataRow(
                                              title: "Price",
                                              value:
                                                  "\u20B9 ${data.totalAmount}"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
            }),
          ),
        ));
  }

  Widget dataRow({required String title, required String value}) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: CustomText(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomText(
            text: ':',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        CustomText(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ],
    );
  }
}
