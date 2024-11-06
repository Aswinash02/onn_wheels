import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:onnwheels/simmer/category_shimmer.dart';
import 'package:onnwheels/utils/image_directory.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../customs/mini_product_card.dart';
import '../../../helpers/shimmer_helper.dart';
import '../../../mytheme.dart';

class CustomWidget {
  static buildCustomGridView(context, productList, loadingState) {
    return loadingState
        ? MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            itemCount: 10,
            shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 20.0, bottom: 10, left: 2, right: 2),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 180,
                  width: 100,
                  decoration: BoxDecoration(
                      color: MyTheme.white,
                      borderRadius: BorderRadius.circular(8)),
                ),
              );
            },
          )
        : productList.isEmpty
            ? Center(
                child: CustomText(
                  text: "No Vehicle Found",
                ),
              )
            : MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                itemCount: productList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 10, left: 2, right: 2),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MiniProductCard(
                    product: productList[index],
                  );
                },
              );
  }

  static buildSearchListProduct(context, productList) {
    return Container(
      height: productList.length > 0 ? 205 : 0,
      padding: EdgeInsets.symmetric(vertical: 5),
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
