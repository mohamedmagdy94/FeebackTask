import 'dart:async';

import 'package:FeebackTask/Common/Service/Implementation/AuthenticationManager.dart';
import 'package:FeebackTask/Common/Service/Implementation/SheetManager.dart';
import 'package:FeebackTask/Insert%20Row/Bussiness/Contract/validate_row_date_contract.dart';
import 'package:FeebackTask/Insert%20Row/Bussiness/Implementation/row_data_validator.dart';
import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';
import 'package:FeebackTask/Insert%20Row/UI/Bloc/insert_row_screen_bloc_event.dart';
import 'package:FeebackTask/Insert%20Row/UI/Bloc/insert_row_screen_bloc_state.dart';
import 'package:bloc/bloc.dart';

class InsertRowScreenBloc
    extends Bloc<InsertRowBlocScreenEvent, InsertRowScreenState> {
  InserRowForm form = InserRowForm(
      name: "",
      mobileNumber: "",
      modelNumber: "",
      purchaseDate: "",
      emailAddress: "");
  ValidateRowDataContract dataValidator = new RowDataValidator();
  AuthenticationManager authenticationManager = AuthenticationManager();
  SheetManager sheetManager = SheetManager();

  InsertRowScreenBloc(InsertRowScreenState initialState) : super(initialState);

  @override
  Stream<InsertRowScreenState> mapEventToState(
      InsertRowBlocScreenEvent event) async* {
    if (event is SaveDataRowInsertRowScreenEvent) {
      this.form = event.form;
      var dataValidationResult = dataValidator.validate(form);
      if (dataValidationResult) {
        if (authenticationManager.isUserLoggedIn()) {
          yield SavingDataInsertRowScreenState();
          String accessToken = authenticationManager.getUserAccessToken();
          await sheetManager.create(accessToken);
          await sheetManager.insertRow(this.form, accessToken);
          yield DataSavedInsertRowScreenState();
        } else {
          yield SignInUserInsertRowScreenState();
        }
      } else {
        yield DataSaveErrorInsertRowScreenState("Data is not correct");
      }
    } else if (event is UserSignedInWithGoogleInsertRowScreenEvent) {
      authenticationManager.autheticateUser(event.accessToken);
      yield SavingDataInsertRowScreenState();
      String accessToken = authenticationManager.getUserAccessToken();
      await sheetManager.create(accessToken);
      await sheetManager.insertRow(this.form, accessToken);
      yield DataSavedInsertRowScreenState();
    } else if (event is ErrorAppearedToUserInsertRowScreenEvent) {
      yield InseringtDataInsertRowScreenState();
    }
  }
}
