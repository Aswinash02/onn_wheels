import 'dart:convert';

import 'package:onnwheels/helpers/api_helpers.dart';
import 'package:onnwheels/models/profile_page_model.dart';
import 'package:onnwheels/utils/app_config.dart';

class ProfileRepository {
  Future<List<ProfilePageModel>> getProfilePageResponse() async {
    String url = ("${AppConfig.BASE_URL}/get-all-pages");
    var response = await ApiHelper.get(
      url: url,
      headers: {"moduleId": '1'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      return jsonData.map((item) => ProfilePageModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load profile page data');
    }
  }
}
