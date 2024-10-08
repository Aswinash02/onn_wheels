import 'package:get/get.dart';
import 'package:onnwheels/repositories/category_repository.dart';

class CategoryController extends GetxController {
  var categoryList = [].obs;
  var isLoadingData = false.obs;

  fetchCategoryList() async {
    isLoadingData.value = true;
    categoryList.clear();
    var categoryResponse = await CategoryRepository().getCategories();
    categoryList.addAll(categoryResponse);
    isLoadingData.value = false;
  }



}
