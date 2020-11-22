import 'dart:async';

import 'package:FeebackTask/Common/Service/Implementation/AuthenticationManager.dart';
import 'package:FeebackTask/Common/Service/Implementation/SheetManager.dart';
import 'package:FeebackTask/Common/Service/Implementation/SheetRowsResponse.dart';
import 'package:FeebackTask/Row%20List/Data/row_card_cell_view_model.dart';
import 'package:FeebackTask/Row%20List/UI/Bloc/row_list_screen_event.dart';
import 'package:FeebackTask/Row%20List/UI/Bloc/row_list_screen_state.dart';
import 'package:bloc/bloc.dart';

class RowListScreenBloc extends Bloc<RowListScreenEvent, RowListScreenState> {
  AuthenticationManager authenticationManager = AuthenticationManager();
  SheetManager sheetManager = SheetManager();
  SheetRowsResponse response;

  RowListScreenBloc(RowListScreenState initialState) : super(initialState);

  @override
  Stream<RowListScreenState> mapEventToState(RowListScreenEvent event) async* {
    String accessToken = authenticationManager.getUserAccessToken();
    if (event is GetRowsRowListScreenEvent) {
      yield ShowLoadingRowListScreenState();
      response = await sheetManager.getRows(accessToken);
      var values = response.values ??= [];
      var cellsViewModels = values.map((e) => RowCardCellViewModel(
          name: e[0], phone: e[1], modelNumber: e[2], date: e[3], email: e[4]));
      var sheetUrl = sheetManager.getURL();
      yield ShowRowsRowListScreenState(cellsViewModels.toList(), sheetUrl);
    } else if (event is DeleteRowRowListScreenEvent) {
      yield ShowLoadingRowListScreenState();
      await sheetManager.deleteRow(accessToken, event.index);
      response = await sheetManager.getRows(accessToken);
      var values = response.values ??= [];
      var cellsViewModels = values.map((e) => RowCardCellViewModel(
          name: e[0], phone: e[1], modelNumber: e[2], date: e[3], email: e[4]));
      var sheetUrl = sheetManager.getURL();
      yield ShowRowsRowListScreenState(cellsViewModels.toList(), sheetUrl);
    }
  }
}
