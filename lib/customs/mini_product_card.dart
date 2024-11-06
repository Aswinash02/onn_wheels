import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/models/all_bike_response.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/bike_details.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

import 'box_decorations.dart';

class MiniProductCard extends StatefulWidget {
  final BikeData product;

  MiniProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => BikeDetailsPage(
            id: widget.product.id!,
          ),
        );
      },
      child: Container(
        width: 145,
        decoration: BoxDecorations.buildBoxDecoration_2(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6), bottom: Radius.zero),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/placeholder.png',
                          image: widget.product.imagePath ?? '',
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/placeholder.png',
                              fit: BoxFit.fill,
                            );
                          },
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
                  child: Center(
                    child: CustomText(
                      text: widget.product.model ?? '',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: MyTheme.font_grey,
                      maxLines: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Container(
                        width: 80,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: const BoxDecoration(
                          color: MyTheme.accent_color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: const Center(
                          child: CustomText(
                            text: "Book Now",
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(
                          () => BikeDetailsPage(
                            id: widget.product.id!,
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
