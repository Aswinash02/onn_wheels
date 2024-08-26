import 'package:get/get.dart';
import 'package:onnwheels/repositories/product_repositories.dart';

import '../models/all_bike_response.dart';

class HomeController extends GetxController {
  var allBikeProducts = <BikeData>[].obs;
  Set<int> productIds = {};
  var searchBikeProducts = <BikeData>[].obs;
  RxBool loadingState = false.obs;

  var userName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userId = "".obs;
  var dateValue1 = "".obs;
  var dateValue2 = "".obs;

  var loading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getAllProductsHome();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  final List<String> tamilNaduCities = [
    'Chennai',
    'Coimbatore',
    'Madurai',
    'Tiruchirappalli',
    'Salem',
    'Tirunelveli',
    // Add more cities as needed
  ];

  // Selected city
  var selectedCity = 'Chennai'.obs;

  // Function to handle city selection
  void selectCity(String city) {
    selectedCity.value = city;
  }

  getAllProductsHome() async {
    loadingState.value = true;
    var allProductsResponse = await ProductRepository().getAllProducts();

    for (var product in allProductsResponse.data!) {
      if (!productIds.contains(product.id)) {
        allBikeProducts.add(product);
        productIds.add(product.id!);
      }
    }

    loadingState.value = false;
    update();
  }

  getSearchProductsHome({
    String? startDate,
    String? endDate,
    String? startTime,
    String? endTime,
  }) async {
    loading.value = true;
    searchBikeProducts.clear();

    var searchProductResponse = await ProductRepository().filterProductDateTime(
      startDate: startDate,
      endDate: endDate,
      startTime: startTime,
      endTime: endTime,
    );

    print('data ===== ${searchProductResponse.data!}');

    Set<int?> productIds =
        searchBikeProducts.map((product) => product.id).toSet();

    searchProductResponse.data!.forEach((product) {
      if (!productIds.contains(product.id)) {
        searchBikeProducts.add(product);
        productIds.add(product.id);
      }
    });

    print('searchBikeProducts ${searchBikeProducts.length}');
    if (searchBikeProducts.isNotEmpty) {
      print("search products Datas---------.${searchBikeProducts[0].name}");
    }
    loading.value = false;
    update();
  }
}
