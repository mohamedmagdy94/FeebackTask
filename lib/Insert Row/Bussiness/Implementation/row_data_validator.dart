import 'package:FeebackTask/Insert%20Row/Bussiness/Contract/validate_row_date_contract.dart';
import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';

class RowDataValidator implements ValidateRowDataContract {
  InserRowForm form;

  @override
  bool validate(InserRowForm form) {
    this.form = form;
    if (form.emailAddress == "") {
      return false;
    } else if (form.mobileNumber == "") {
      return false;
    } else if (form.modelNumber == "") {
      return false;
    } else if (form.purchaseDate == "") {
      return false;
    } else if (form.emailAddress == "") {
      return false;
    } else {
      return true;
    }
  }
}
