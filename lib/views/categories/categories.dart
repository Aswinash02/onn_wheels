import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/category_controller.dart';
import 'package:onnwheels/mytheme.dart';
import 'package:onnwheels/simmer/category_shimmer.dart';
import 'package:onnwheels/views/bikedetails/components/text_widget.dart';
import 'package:onnwheels/views/categories/components/category_card.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    initCall();
  }

  Future<void> initCall() async {
    await categoryController.fetchCategoryList();
  }

  Future<void> _onRefresh() async {
    await categoryController.fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.categories_ucf,
          backgroundColor: MyTheme.white,
          textColor: MyTheme.black),
      body: Obx(
        () => categoryController.isLoadingData.value
            ? CategorySimmer()
            : RefreshIndicator(
                color: MyTheme.accent_color,
                onRefresh: _onRefresh,
                child: categoryController.categoryList.isEmpty
                    ? Center(
                        child: CustomText(
                          text: "No Category Found",
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            childAspectRatio : 0.9,
                            crossAxisSpacing: 10),
                        itemCount: categoryController.categoryList.length,
                        itemBuilder: (context, index) {
                          return CategoryMiniCard(
                            product: categoryController.categoryList[index],
                          );
                        },
                        physics: const AlwaysScrollableScrollPhysics(),
                      ),
              ),
      ),
    );
  }
}
