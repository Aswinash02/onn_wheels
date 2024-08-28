class FilterBikesModel {
  List<String>? hourPrices;
  List<String>? dayPrices;
  List<String>? weekPrices;
  List<String>? monthPrices;
  List<String>? brands;
  List<Stations>? stations;

  FilterBikesModel(
      {this.hourPrices,
        this.dayPrices,
        this.weekPrices,
        this.monthPrices,
        this.brands,
        this.stations});

  FilterBikesModel.fromJson(Map<String, dynamic> json) {
    hourPrices =
        (json['hourPrices'] as List).map((price) => '\u{20B9} $price').toList();
    dayPrices =
        (json['dayPrices'] as List).map((price) => '\u{20B9} $price').toList();
    weekPrices =
        (json['weekPrices'] as List).map((price) => '\u{20B9} $price').toList();
    monthPrices = (json['monthPrices'] as List)
        .map((price) => '\u{20B9} $price')
        .toList();
    brands = json['brands'].cast<String>();
    brands = json['brands'].cast<String>();
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations!.add(new Stations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hourPrices'] = this.hourPrices;
    data['dayPrices'] = this.dayPrices;
    data['weekPrices'] = this.weekPrices;
    data['monthPrices'] = this.monthPrices;
    data['brands'] = this.brands;
    if (this.stations != null) {
      data['stations'] = this.stations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stations {
  int? id;
  String? name;

  Stations({this.id, this.name});

  Stations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
