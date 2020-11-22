import 'dart:convert';

SheetRowsResponse sheetRowsResponseFromJson(String str) =>
    SheetRowsResponse.fromJson(json.decode(str));

String sheetRowsResponseToJson(SheetRowsResponse data) =>
    json.encode(data.toJson());

class SheetRowsResponse {
  SheetRowsResponse({
    this.range,
    this.majorDimension,
    this.values,
  });

  String range;
  String majorDimension;
  List<List<String>> values;

  factory SheetRowsResponse.fromJson(Map<String, dynamic> json) =>
      SheetRowsResponse(
        range: json["range"],
        majorDimension: json["majorDimension"],
        values: List<List<String>>.from(
            json["values"].map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "range": range,
        "majorDimension": majorDimension,
        "values": List<dynamic>.from(
            values.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
