import 'package:get/get.dart';
import 'package:onnwheels/models/filter_bikes_model.dart';
import 'package:onnwheels/repositories/category_repository.dart';

class CategoryProductController extends GetxController {
  var isLoadingData = false.obs;
  var categoryProducts = [].obs;

  Future<void> fetchCategoryProductList({required int categoryId}) async {
    isLoadingData.value = true;
    var categoryResponse = await CategoryRepository()
        .fetchCategoryProducts(categoryId: categoryId);
    if (categoryResponse.products != null) {
      categoryProducts.addAll(categoryResponse.products!);
    }
    isLoadingData.value = false;
  }
}
