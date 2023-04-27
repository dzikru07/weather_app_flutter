// To parse this JSON data, do
//
//     final wilayahModels = wilayahModelsFromJson(jsonString);

import 'dart:convert';

WilayahModels wilayahModelsFromJson(String str) =>
    WilayahModels.fromJson(json.decode(str));

String wilayahModelsToJson(WilayahModels data) => json.encode(data.toJson());

class WilayahModels {
  String id;
  String propinsi;
  String kota;
  String kecamatan;
  String lat;
  String lon;

  WilayahModels({
    required this.id,
    required this.propinsi,
    required this.kota,
    required this.kecamatan,
    required this.lat,
    required this.lon,
  });

  factory WilayahModels.fromJson(Map<String, dynamic> json) => WilayahModels(
        id: json["id"],
        propinsi: json["propinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propinsi": propinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "lat": lat,
        "lon": lon,
      };
}
