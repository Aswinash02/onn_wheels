import 'package:get/get.dart';
import 'package:onnwheels/views/bikedetails/bike_details.dart';
import 'package:onnwheels/views/verification/verification_page.dart';
import 'package:onnwheels/views/zone_areas/zone_list.dart';

class Routes {
  static String mainPage = '/';
  static String verification = '/verification';
  static String zonePage = '/zonePage';
  static String bikeDetails = '/bikeDetails';
  static String subCategory = '/subcategory';
  static String wishlist = '/wishlist';
  static String orders = '/orders';
  static String address = '/address';
  static String accountsPage = '/accountsPage';
  static String productDetails = '/productDetails';
  static String flashDealProducts = '/flashDealProducts';
  static String wallets = '/wallets';
  static String coupons = '/coupons';
  static String brandProducts = '/brandProducts';
  static String allBrands = '/allBrands';
  static String topSellingProducts = '/topSelling';
  static String topSellers = '/topSellers';
  static String couponProducts = '/couponProducts';
  static String login = '/login';
  static String registration = '/registration';
  static String profileEdit = '/profileEdit';
  static String checkout = '/checkout';
  static String shippingInfo = '/shippingInfo';
  static String refundRequest = '/refundRequest';
  static String ordersPage = '/ordersPage';
  static String ordersDetails = '/ordersDetails';
  static String filtersPage = '/filters';
  static String allProducts = '/allProducts';
}

List<GetPage<dynamic>>? getPages = [

  GetPage(
    name: Routes.zonePage,
    page: () => const ZoneAreasPage(),
  ),
  GetPage(
    name: Routes.verification,
    page: () => const VerificationFlowPage(),
  ),
  GetPage(
    name: Routes.bikeDetails,
    page: () => const BikeDetailsPage(id: 0),
  ),
];
