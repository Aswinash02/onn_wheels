var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@TheWheels.com " + this_year; //this shows in the splash screen
  static String app_name = "TheWheels";

  static String razorPayKey = 'rzp_test_zc8jGjJQG6oyYw';
  static String razorPaySecret = 'mXL8TIhBaTCYv0NNevMAPm3U';

  static String purchase_code =
      ""; //enter your purchase code for the app from codecanyon
  static String system_key =
      ""; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;

  //configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "thewheels.app"; //localhost

  //do not configure these below
  static const String API_ENDPATH = "api/v1";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";
  @override
  String toString() {
    return super.toString();
  }
}