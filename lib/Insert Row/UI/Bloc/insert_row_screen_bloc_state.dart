import 'package:equatable/equatable.dart';

class InsertRowScreenState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InseringtDataInsertRowScreenState extends InsertRowScreenState {
  InseringtDataInsertRowScreenState() : super();
}

class SignInUserInsertRowScreenState extends InsertRowScreenState {
  SignInUserInsertRowScreenState() : super();
}

class SavingDataInsertRowScreenState extends InsertRowScreenState {
  SavingDataInsertRowScreenState() : super();
}

class DataSavedInsertRowScreenState extends InsertRowScreenState {
  DataSavedInsertRowScreenState() : super();
}

class DataSaveErrorInsertRowScreenState extends InsertRowScreenState {
  final String errorMessage;
  DataSaveErrorInsertRowScreenState(this.errorMessage);
}
