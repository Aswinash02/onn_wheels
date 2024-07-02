import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/category_controller.dart';
import 'package:onnwheels/controllers/category_product_controller.dart';
import 'package:onnwheels/customs/mini_product_card.dart';
import 'package:onnwheels/helpers/shimmer_helper.dart';
import 'package:onnwheels/models/category_product_models.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/category_product_card.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  final CategoryProductController categoryController =
      Get.put(CategoryProductController());

  @override
  void initState() {
    // TODO: implement initState
    categoryController.fetchCategoryProductList(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.category_products,
          backgroundColor: MyTheme.white,
          setLeading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: MyTheme.black),
          ),
          textColor: MyTheme.black),
      body: buildProductList(context, categoryController),
    );
  }

  Widget buildProductList(
      BuildContext context, CategoryProductController categoryController) {
    return Obx(() {
      if (categoryController.isLoadingData.value) {
        return ShimmerHelper().buildProductGridShimmer();
      } else if (categoryController.categoryProducts.isEmpty) {
        return Center(child: Text('No products available.'));
      } else {
        return SingleChildScrollView(
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            itemCount: categoryController.categoryProducts.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 10, left: 30, right: 30),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MiniProductCardCategory(
                product: categoryController.categoryProducts[index],
              );
            },
          ),
        );
      }
    });
  }
}
