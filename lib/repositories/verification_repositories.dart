import 'dart:convert';

import '../helpers/api_helpers.dart';
import '../models/pan_verify_models.dart';
import '../utils/app_config.dart';

class VerificationRepository {
  Future<PanResponse> panVerificationPost({String? panNumber}) async {
    String url = ("${AppConfig.BASE_URL}/verification/pan-verify");
    var post_body = jsonEncode({
      "pan_number": "$panNumber",
      "purpose": 1,
      "purpose_desc": "onboarding"
    });
    final response = await ApiHelper.post(
        url: url,
        headers: {
          "Content-Type": "application/json",
        },
        body: post_body);
    print("get All pan Data response=======>${response.body}");

    return panResponseFromJson(response.body);
  }
}
