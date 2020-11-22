import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';
import 'package:equatable/equatable.dart';

class RowListScreenEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class GetRowsRowListScreenEvent extends RowListScreenEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class DeleteRowRowListScreenEvent extends RowListScreenEvent {
  final int index;
  DeleteRowRowListScreenEvent(this.index);
}
