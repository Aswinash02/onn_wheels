import 'dart:convert';

gstResponse gstResponseFromJson(String str) => gstResponse.fromJson(json.decode(str));

String gstResponseToJson(gstResponse data) => json.encode(data.toJson());
class gstResponse {
  String? gst;
  String? sgst;

  gstResponse({this.gst, this.sgst});

  gstResponse.fromJson(Map<String, dynamic> json) {
    gst = json['gst'];
    sgst = json['sgst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gst'] = this.gst;
    data['sgst'] = this.sgst;
    return data;
  }
}
