import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/customs/box_decorations.dart';
import 'package:onnwheels/models/category_models.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/categories/category_products.dart';

class CategoryMiniCard extends StatefulWidget {
  CategoryResponse product;

  CategoryMiniCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _CategoryMiniCardState createState() => _CategoryMiniCardState();
}

class _CategoryMiniCardState extends State<CategoryMiniCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CategoryProducts(categoryId: widget.product.id!));
      },
      child: Container(
        width: 145,
        decoration: BoxDecorations.buildBoxDecoration_2(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6), bottom: Radius.zero),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image:
                            "https://onnwheels.com/storage/app/public/category/${widget.product.image!}",
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
                        fontSize: 16,
                        height: 1.2,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
