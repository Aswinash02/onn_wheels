import 'dart:convert';
import 'package:onnwheels/models/all_station_detail_model.dart';
import 'package:onnwheels/models/bike_details_model.dart';
import 'package:onnwheels/models/filter_bikes_model.dart';
import '../helpers/api_helpers.dart';
import '../models/all_bike_response.dart';
import '../utils/app_config.dart';
import '../utils/shared_value.dart';

class ProductRepository {
  Future<AllBikeResponse> getAllProducts({int page = 1}) async {
    String url = ("${AppConfig.BASE_URL}/items/get-all");
    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "App-Language": app_language.$!,
        "moduleId": "1"
      },
    );

    return allBikeResponseFromJson(response.body);
  }

  Future<BikeDetailsResponse> getProductDetails({int? id}) async {
    String url = ("${AppConfig.BASE_URL}/items/details/$id");

    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "moduleId": "1",
        "zoneId": "2"
      },
    );
    print('body ----------- > ${response.body}');
    return bikeDetailsResponseFromJson(response.body);
  }

  Future<AllBikeResponse> filterProductDateTime(
      {String? startDate,
      String? startTime,
      String? endDate,
      String? endTime,
      String? stationId}) async {
    String url = ("${AppConfig.BASE_URL}/items/vehicle-availability-search");
    var post_body = jsonEncode({
      "start_date": "$startDate  $startTime",
      "end_date": "$endDate $endTime",
      "station": stationId
    });
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "moduleId": "1",
          "zoneId": "[1]"
        },
        body: post_body);

    return allBikeResponseFromJson(response.body);
  }

  Future<AllBikeResponse> getFilterBikes({
    String? package,
    String? fuelType,
    String? transmissionType,
    String? brand,
    int? stationId,
  }) async {
    String url = ("${AppConfig.BASE_URL}/items/filter-bikes");
    var post_body = jsonEncode({
      "package": package,
      "fuel_type": fuelType,
      "transmission_type": transmissionType,
      "brand": brand,
      "station_id": stationId
    });
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "moduleId": "1",
          "zoneId": "[1]"
        },
        body: post_body);

    return allBikeResponseFromJson(response.body);
  }

  Future<AllStationDetailModel> getAllStation({int? id}) async {
    String url = ("${AppConfig.BASE_URL}/items/get-all-stations");

    final response = await ApiHelper.get(
      url: url,
      headers: {
        "Content-Type": "application/json",
        "moduleId": "1",
        "zoneId": "2"
      },
    );
    return AllStationDetailModel.fromJson(jsonDecode(response.body));
  }

  Future<FilterBikesModel> fetchFilterDropDownData() async {
    try {
      String url = ("${AppConfig.BASE_URL}/items/dropdown-data");
      final response = await ApiHelper.get(
        url: url,
        headers: {
          "Content-Type": "application/json",
          "moduleId": "1",
          "zoneId": '[2]'
        },
      );

      return FilterBikesModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
