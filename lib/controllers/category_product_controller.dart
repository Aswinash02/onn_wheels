import 'package:get/get.dart';
import 'package:onnwheels/repositories/category_repository.dart';

class CategoryProductController extends GetxController{

  var isLoadingData = false.obs;
  var categoryProducts = [].obs;
  Future<void> fetchCategoryProductList({required int categoryId}) async {
    isLoadingData.value = true;
    var categoryResponse = await CategoryRepository().fetchCategoryProducts(categoryId: categoryId);
    if (categoryResponse.products?.data != null) {
      categoryProducts.addAll(categoryResponse.products!.data!);
    }
    isLoadingData.value = false;
  }
}