import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/views/bikedetails/bike_details.dart';

import '../models/all_bike_response.dart';
import '../mytheme.dart';
import 'box_decorations.dart';

class MiniProductCard extends StatefulWidget {
  Product product;

  MiniProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _MiniProductCardState createState() => _MiniProductCardState();
}

class _MiniProductCardState extends State<MiniProductCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  aspectRatio: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6), bottom: Radius.zero),
                      // child: FadeInImage.assetNetwork(
                      //   placeholder: 'assets/placeholder.png',
                      //   image: widget.image!,
                      //   fit: BoxFit.cover,
                      // ),
                      child: Image.network(
                        "https://onnwheels.com/storage/app/public/product/${widget.product.image!}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 6),
                  child: Text(
                    widget.product.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        color: MyTheme.font_grey,
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Icon(Icons.star,size: 12,color: MyTheme.medium_grey,),
                          SizedBox(width: 5,),
                          Text(
                            widget.product.ratingCount!.toString(),
                            maxLines: 1,
                            style: TextStyle(
                                color: MyTheme.medium_grey_50,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        "\u{20B9} ${widget.product.price!}",
                        maxLines: 1,
                        style: const TextStyle(
                            color: MyTheme.accent_color,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10.0, top: 2, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: const BoxDecoration(
                            color: MyTheme.accent_color,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Book Now",
                              style: TextStyle(color: MyTheme.white),
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
                      )
                    ],
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
