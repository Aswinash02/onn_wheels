import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:onnwheels/controllers/category_controller.dart';
import 'package:onnwheels/helpers/shimmer_helper.dart';
import 'package:onnwheels/views/categories/components/category_card.dart';
import 'package:onnwheels/views/main_page/components/custom_appbar.dart';
import '../../mytheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().customAppBar(
          title: AppLocalizations.of(context)!.categories_ucf,
          backgroundColor: MyTheme.white,
          textColor: MyTheme.black),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Obx(() {
                        if(categoryController.categoryList.length == 0){
                          return SingleChildScrollView(
                            child: ShimmerHelper().buildProductGridShimmer(),
                          );
                        }else if(categoryController.categoryList.length > 0){
                          return MasonryGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            itemCount: categoryController.categoryList.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                top: 20.0, bottom: 10, left: 2, right: 2),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CategoryMiniCard(
                                product: categoryController.categoryList[index],
                              );
                            },
                          );
                        }else{
                          return Center(
                            child: Text("No Categories Available"),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
