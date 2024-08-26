import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/customs/box_decorations.dart';
import 'package:onnwheels/models/category_product_models.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/bikedetails/bike_details.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';

class MiniProductCardCategory extends StatefulWidget {
  final Products product;

  MiniProductCardCategory({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _MiniProductCardCategoryState createState() =>
      _MiniProductCardCategoryState();
}

class _MiniProductCardCategoryState extends State<MiniProductCardCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('image path --------- ${widget.product.imagePath}');
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
                          image: "${widget.product.imagePath ?? ''}",
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
                    child: Text(
                      widget.product.model ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          color: MyTheme.font_grey,
                          fontSize: 12,
                          height: 1.2,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Center(
                          child: CustomText(
                            text: "Book Now",
                            color: MyTheme.white,
                            fontSize: 12,
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
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
