import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/category_product_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/category_shimmer.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';

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
    categoryController.fetchCategoryProductList(categoryId: widget.categoryId);
    super.initState();
  }

  Future<void> _onRefresh() async {
    await categoryController.fetchCategoryProductList(
        categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: "Vehicles",
          backgroundColor: MyTheme.white,
          setLeading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, color: MyTheme.black),
          ),
          textColor: MyTheme.black),
      body: RefreshIndicator(
        color: MyTheme.accent_color,
        onRefresh: _onRefresh,
        child: Obx(() {
          if (categoryController.isLoadingData.value) {
            return CategorySimmer();
          } else if (categoryController.categoryProducts.isEmpty) {
            return Center(child: Text('No Vehicles Found.'));
          } else {
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              itemCount: categoryController.categoryProducts.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MiniProductCardCategory(
                  product: categoryController.categoryProducts[index],
                );
              },
            );
          }
        }),
      ),
    );
  }
}
