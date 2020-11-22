import 'dart:async';

import 'package:FeebackTask/Common/Service/Contract/sheet_manager_contract.dart';
import 'package:FeebackTask/Common/Service/Implementation/SheetRespone.dart';
import 'package:FeebackTask/Common/Service/Implementation/SheetRowsResponse.dart';
import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';

import 'package:http/http.dart' as http;
import '../../Constant/api_constants.dart' as ApiContsant;
import 'dart:convert';

class SheetManager implements SheetManagerContract {
  String _sheetId = "";
  String _sheetURL = "";
  int _insertedRowsNumber = 0;

  static final SheetManager _singleton = SheetManager._internal();

  factory SheetManager() {
    return _singleton;
  }

  SheetManager._internal();

  @override
  Future<String> create(String accessToken) async {
    if (_sheetId != "") {
      return Future.value(_sheetId);
    } else {
      var response = await http.post(
          '${ApiContsant.GOOGLE_APLE_BASE_URL}spreadsheets',
          headers: <String, String>{'Authorization': 'Bearer ${accessToken}'});
      print("Create REsponse : ${response.body}");
      var jsonDic = json.decode(response.body);
      var model = SheetResponse.fromJson(jsonDic);
      _sheetId = model.spreadsheetId;
      _sheetURL = model.spreadsheetUrl;
      return Future.value(_sheetId);
    }
  }

  @override
  String getURL() {
    // TODO: implement getURL
    return _sheetURL;
  }

  @override
  Future<bool> insertRow(InserRowForm form, String accessToken) async {
    // TODO: implement insertRow

    var url = _constructInsertUrl();
    var body =
        '{"values":[["${form.name}","${form.mobileNumber}","${form.modelNumber}","${form.purchaseDate}","${form.emailAddress}"]]}';

    var response = await http.put(url,
        headers: <String, String>{
          'Authorization': 'Bearer ${accessToken}',
          "Content-Type": "application/json"
        },
        body: body);
    if (response.statusCode == 200) {
      _insertedRowsNumber++;
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  String _constructInsertUrl() {
    var url =
        "${ApiContsant.GOOGLE_APLE_BASE_URL}spreadsheets/${_sheetId}/values/Sheet1!A${_insertedRowsNumber + 1}?valueInputOption=RAW";
    return url;
  }

  @override
  Future<SheetRowsResponse> getRows(String accessToken) async {
    // TODO: implement getRows
    var url = _constructGetRowsUrl();

    var response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${accessToken}',
      },
    );
    print("Get Response : ${response.body}");
    var jsonDic = json.decode(response.body);
    var model = SheetRowsResponse.fromJson(jsonDic);
    _insertedRowsNumber = model.values.length;
    return Future.value(model);
  }

  String _constructGetRowsUrl() {
    var url =
        "${ApiContsant.GOOGLE_APLE_BASE_URL}spreadsheets/${_sheetId}/values/Sheet1!A1:E${_insertedRowsNumber + 1}";
    return url;
  }

  @override
  Future<bool> deleteRow(String accessToken, int index) async {
    // TODO: implement deleteRow
    if (_insertedRowsNumber == 0) {
      return Future.value(false);
    } else {
      var url = _constructDeleteRowUrl();
      var body =
          '{"requests": [{"deleteDimension": {"range": {"sheetId": 0,"dimension": "ROWS","startIndex": ${index - 1},"endIndex": ${index}}}}],}';
      var response = await http.post(url,
          headers: <String, String>{
            'Authorization': 'Bearer ${accessToken}',
            "Content-Type": "application/json"
          },
          body: body);
      if (response.statusCode == 200) {
        this._insertedRowsNumber--;
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  String _constructDeleteRowUrl() {
    var url =
        "${ApiContsant.GOOGLE_APLE_BASE_URL}spreadsheets/${_sheetId}:batchUpdate";
    return url;
  }
}
