import 'package:FeebackTask/Row%20List/Data/row_card_cell_view_model.dart';
import 'package:equatable/equatable.dart';

class RowListScreenState extends Equatable {
  @override
  List<Object> get props => null;
}

class ShowLoadingRowListScreenState extends RowListScreenState {
  ShowLoadingRowListScreenState() : super();
}

class ShowRowsRowListScreenState extends ShowLoadingRowListScreenState {
  final List<RowCardCellViewModel> cells;
  final String sheetURL;
  ShowRowsRowListScreenState(this.cells, this.sheetURL);
  @override
  List<Object> get props => [cells, sheetURL];
}
