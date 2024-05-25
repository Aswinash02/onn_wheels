import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onnwheels/repositories/product_repositories.dart';

import '../models/all_bike_response.dart';

class HomeController extends GetxController{

  var allBikeProducts = <Product>[].obs;

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

  getAllProductsHome({int page=1}) async {
    var allProductsResponse = await ProductRepository().getAllProducts(page: page);
    print("All Product Response=======${allProductsResponse.product![0].name}");
    allBikeProducts.addAll(allProductsResponse.product!);
    update();
  }
}