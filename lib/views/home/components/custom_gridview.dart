import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onnwheels/utils/image_directory.dart';
import '../../../customs/mini_product_card.dart';
import '../../../helpers/shimmer_helper.dart';
import '../../../mytheme.dart';

class CustomWidget {
  static buildCustomGridView(context, productList) {
    if (productList.length == 0) {
      return SingleChildScrollView(
        child: ShimmerHelper().buildProductGridShimmer(),
      );
    } else if (productList.length > 0) {
      return
          // Obx(
          //         () =>
          MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        itemCount: productList.length,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 10, left: 2, right: 2),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return MiniProductCard(
            product: productList[index],
          );
        },
      );
      // );
    } else {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.no_product_is_available,
            style: const TextStyle(color: MyTheme.font_grey),
          ),
        ),
      );
    }
  }

  static buildSearchListProduct(context, productList) {
    return Container(
      height: productList.length > 0 ? 205 : 0,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(2),
      child: ListView.separated(
        itemCount: productList.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: 10,
        ),
        itemBuilder: (context, index) {
          final product = productList[index];
          return MiniProductCard(
            product: product,
          );
        },
      ),
    );
  }
}
