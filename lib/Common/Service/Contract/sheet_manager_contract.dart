import 'package:FeebackTask/Common/Service/Implementation/SheetRowsResponse.dart';
import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';

abstract class SheetManagerContract {
  Future<String> create(String accessToken);
  Future<bool> insertRow(InserRowForm form, String accessToken);
  Future<SheetRowsResponse> getRows(String accessToken);
  Future<bool> deleteRow(String accessToken, int index);
  String getURL();
}
