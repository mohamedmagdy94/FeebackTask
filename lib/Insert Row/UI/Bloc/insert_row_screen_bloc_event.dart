import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';
import 'package:equatable/equatable.dart';

class InsertRowBlocScreenEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SaveDataRowInsertRowScreenEvent extends InsertRowBlocScreenEvent {
  final InserRowForm form;
  SaveDataRowInsertRowScreenEvent(this.form);
  @override
  // TODO: implement props
  List<Object> get props => [form];
}

class UserSignedInWithGoogleInsertRowScreenEvent
    extends InsertRowBlocScreenEvent {
  final String accessToken;
  UserSignedInWithGoogleInsertRowScreenEvent(this.accessToken);
}

class ErrorAppearedToUserInsertRowScreenEvent extends InsertRowBlocScreenEvent {
}
