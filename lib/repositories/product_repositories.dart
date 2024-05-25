import '../helpers/api_helpers.dart';
import '../models/all_bike_response.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class ProductRepository {
  Future<AllBikeResponse> getAllProducts({int page=1}) async {
    String url = ("${AppConfig.BASE_URL}/items/get-all?page=$page");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "App-Language": app_language.$!,
        "moduleId": "1"
      },
    );
    print("get All Bike response=======>${response.body}");

    return allBikeResponseFromJson(response.body);
  }
}