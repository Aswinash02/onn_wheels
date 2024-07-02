import 'package:get/get.dart';
import 'package:onnwheels/repositories/category_repository.dart';

class CategoryController extends GetxController {
  var categoryList = [].obs;
  var isLoadingData = false.obs;
  // var categoryProducts = [].obs;

  @override
  void onInit() {
    fetchCategoryList();
    super.onInit();
  }

  @override
  void onClose() {
    categoryList.clear();
    super.onClose();
  }

  fetchCategoryList() async {
    isLoadingData.value = true;
    var categoryResponse = await CategoryRepository().getCategories();
    categoryList.addAll(categoryResponse);
    isLoadingData.value = false;
  }



}
