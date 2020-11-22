import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';

abstract class SheetManagerContract {
  Future<String> create(String accessToken);
  Future<bool> insertRow(InserRowForm form, String accessToken);
  String getURL();
}
