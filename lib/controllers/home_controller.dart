import 'package:get/get.dart';
import 'package:onnwheels/customs/toastcomponent.dart';
import 'package:onnwheels/models/all_station_detail_model.dart';
import 'package:onnwheels/models/filter_bikes_model.dart';
import 'package:onnwheels/repositories/product_repositories.dart';
import 'package:onnwheels/utils/shared_preference.dart';

import '../models/all_bike_response.dart';

class HomeController extends GetxController {
  List<BikeData> allBikeProducts = [];
  Set<int> productIds = {};
  var searchBikeProducts = <BikeData>[].obs;
  RxBool loadingState = false.obs;
  RxBool filterLoadingState = false.obs;
  List<BikeData> _filterBikeList = [];

  var userName = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  var userId = "".obs;
  var dateValue1 = "".obs;
  var dateValue2 = "".obs;

  var loading = false.obs;
  String? _selectedHourPrice;
  String? _selectedDayPrice;
  String? _selectedWeekPrice;
  String? _selectedMonthPrice;
  String? _selectedBrand;
  String? _selectedFuelType;
  String? _selectedAttributeType;
  String? _selectedTransmissionType;
  String? _selectedPackage;

  Stations? _selectedStation;
  StationData? selectedHomeFilterStation;
  RxBool _isFilter = false.obs;

  List<String> _hourPriceList = [];
  List<String> _dayPriceList = [];
  List<String> _weekPriceList = [];
  List<String> _monthPriceList = [];
  List<String> _brandList = [];
  List<Stations> _stationList = [];
  List<StationData> _homeFilterStationList = [];
  List<String> _fuelTypeList = ["Petrol", "Diesel", "EV"];
  List<String> _attributeTypeList = ["fuel_type", "transmission_type"];
  List<String> _transmissionTypeList = ["Automatic", "Manual"];

  String? get selectedHourPrice => _selectedHourPrice;

  String? get selectedPackage => _selectedPackage;

  String? get selectedDayPrice => _selectedDayPrice;

  String? get selectedWeekPrice => _selectedWeekPrice;

  String? get selectedMonthPrice => _selectedMonthPrice;

  String? get selectedBrand => _selectedBrand;

  String? get selectedFuelType => _selectedFuelType;

  String? get selectedAttributeType => _selectedAttributeType;

  Stations? get selectedStation => _selectedStation;


  RxBool get isFilter => _isFilter;

  String? get selectedTransmissionType => _selectedTransmissionType;

  List<String> get hourPriceList => _hourPriceList;

  List<String> get dayPriceList => _dayPriceList;

  List<String> get weekPriceList => _weekPriceList;

  List<String> get monthPriceList => _monthPriceList;

  List<String> get brandList => _brandList;

  List<String> get fuelTypeList => _fuelTypeList;

  List<String> get attributeTypeList => _attributeTypeList;

  List<String> get transmissionTypeList => _transmissionTypeList;

  List<Stations> get stationList => _stationList;

  List<StationData> get homeFilterStationList => _homeFilterStationList;

  List<BikeData> get filterBikeList => _filterBikeList;

  Future<void> fetchFilterDropDownData() async {
    _hourPriceList.clear();
    _dayPriceList.clear();
    _weekPriceList.clear();
    _monthPriceList.clear();
    _brandList.clear();
    _stationList.clear();
// isLoadingData.value = true;
    FilterBikesModel response =
        await ProductRepository().fetchFilterDropDownData();
    if (response.hourPrices != null) {
      _hourPriceList.addAll(response.hourPrices!);
    }
    if (response.dayPrices != null) {
      _dayPriceList.addAll(response.dayPrices!);
    }
    if (response.weekPrices != null) {
      _weekPriceList.addAll(response.weekPrices!);
    }
    if (response.monthPrices != null) {
      _monthPriceList.addAll(response.monthPrices!);
    }
    if (response.brands != null) {
      _brandList.addAll(response.brands!);
    }
    if (response.stations != null) {
      _stationList.addAll(response.stations!);
    }
// isLoadingData.value = false;
  }

  void onChangeHourPrice(String? value) {
    _selectedHourPrice = value;
    update();
  }

  void onChangeDailyPrice(String? value) {
    _selectedDayPrice = value;
    update();
  }

  void onChangeWeekPrice(String? value) {
    _selectedWeekPrice = value;
    update();
  }

  void onChangeMonthPrice(String? value) {
    _selectedMonthPrice = value;
    update();
  }

  void onChangeBrand(String? value) {
    _selectedBrand = value;
    update();
  }

  void onChangePackage(String? value) {
    _selectedPackage = value;
    update();
  }

  void onChangeStation(Stations? value) {
    _selectedStation = value;
    update();
  }

  void onChangeHomeFilterStation(StationData? value) {
    selectedHomeFilterStation = value;
    update();
  }

  void onChangeTransmissionType(String? value) {
    _selectedTransmissionType = value;
    update();
  }

  void onChangeFuelType(String? value) {
    _selectedFuelType = value;
    update();
  }

  void onChangeAttributeType(String? value) {
    _selectedAttributeType = value;
    update();
  }

  void clearData({bool? isDefault}) {
    _selectedHourPrice = null;
    _selectedDayPrice = null;
    _selectedWeekPrice = null;
    _selectedMonthPrice = null;
    _selectedBrand = null;
    _selectedFuelType = null;
    _selectedTransmissionType = null;
    _selectedStation = null;
    _selectedAttributeType = null;
    _selectedPackage = null;
    if (isDefault != null && isDefault) {
      _isFilter.value = false;
      _filterBikeList.clear();
      update();
    }
  }

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   getAllProductsHome();
  //   super.onInit();
  // }
  //
  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }

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
    allBikeProducts.clear();
    productIds.clear();
    var allProductsResponse = await ProductRepository().getAllProducts();
    if (allProductsResponse.data != null) {
      for (var product in allProductsResponse.data!) {
        if (!productIds.contains(product.id)) {
          allBikeProducts.add(product);
          productIds.add(product.id!);
        }
      }
    }
    loadingState.value = false;
    update();
  }

  Future<void> fetchUserName() async {
    SharedPreference sharedPreference = SharedPreference();
    userName.value = await sharedPreference.getUserName();
    userId.value = await sharedPreference.getUserId();
    userEmail.value = await sharedPreference.getUserEmail();
    userPhone.value = await sharedPreference.getUserPhoneNo();
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
        stationId: selectedHomeFilterStation!.id.toString());

    Set<int?> productIds =
        searchBikeProducts.map((product) => product.id).toSet();

    searchProductResponse.data!.forEach((product) {
      if (!productIds.contains(product.id)) {
        searchBikeProducts.add(product);
        productIds.add(product.id);
      }
    });
    if (searchBikeProducts.isEmpty) {
      ToastComponent.showDialog("No Vehicle Found");
    }
    loading.value = false;
    update();
  }

  Future<void> getFilterBikes() async {
    filterLoadingState.value = true;
    _filterBikeList.clear();
    AllBikeResponse response = await ProductRepository().getFilterBikes(
      package:
          _selectedPackage != null ? _selectedPackage!.toLowerCase() : null,
      fuelType:
          _selectedFuelType != null ? _selectedFuelType!.toLowerCase() : null,
      transmissionType: _selectedTransmissionType != null
          ? _selectedTransmissionType!.toLowerCase()
          : null,
      brand: _selectedBrand,
      stationId: _selectedStation != null ? _selectedStation!.id : null,
    );
    if (response.data != null) {
      _filterBikeList.addAll(response.data!);
    }
    _isFilter.value = true;
    clearData();
    filterLoadingState.value = false;
    update();
  }

  Future<void> getAllStation() async {
    _homeFilterStationList.clear();
    AllStationDetailModel response = await ProductRepository().getAllStation();
    if (response.data != null) {
      _homeFilterStationList.addAll(response.data!);
    }
    update();
  }
}
