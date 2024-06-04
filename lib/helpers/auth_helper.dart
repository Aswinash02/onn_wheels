
import 'package:onnwheels/models/login_response_model.dart';

import '../utils/shared_value.dart';

class AuthHelper {
  setUserData(LoginResponse loginResponse) {
      if (loginResponse.token != '') {
          is_logged_in.$ = true;
          is_logged_in.save();
          access_token.$ = loginResponse.token;
          access_token.save();
          user_id.$ = loginResponse.user?.id;
          user_id.save();
          user_name.$ = loginResponse.user?.fName;
          user_name.save();
          user_email.$ = loginResponse.user?.email ?? "";
          user_email.save();
          user_phone.$ = loginResponse.user?.phone ?? "";
          user_phone.save();
      }
  }
  }

  clearUserData() {
    // SystemConfig.systemUser= null;
      is_logged_in.$ = false;
      is_logged_in.save();
      access_token.$ = "";
      access_token.save();
      user_id.$ = 0;
      user_id.save();
      user_name.$ = "";
      user_name.save();
      user_email.$ = "";
      user_email.save();
      user_phone.$ = "";
      user_phone.save();
      avatar_original.$ = "";
      avatar_original.save();
  }


  // fetch_and_set() async {
  //   var userByTokenResponse = await AuthRepository().getUserByTokenResponse();
  //   if (userByTokenResponse.result == true) {
  //     setUserData(userByTokenResponse);
  //   }else{
  //     clearUserData();
  //   }
  // }
// }
