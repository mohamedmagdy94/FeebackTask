import 'dart:async';

import 'package:FeebackTask/Common/Widget/feeback_app_bar_widget.dart';
import 'package:FeebackTask/Common/Widget/feeback_text_field_widget.dart';
import 'package:FeebackTask/Insert%20Row/Data/insert_row_form.dart';
import 'package:FeebackTask/Insert%20Row/UI/Bloc/insert_row_screen_bloc.dart';
import 'package:FeebackTask/Insert%20Row/UI/Bloc/insert_row_screen_bloc_event.dart';
import 'package:FeebackTask/Insert%20Row/UI/Bloc/insert_row_screen_bloc_state.dart';
import 'package:FeebackTask/Row%20List/UI/Screen/row_list_screeen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../Common/Constant/app_constants.dart' as AppConstants;
import 'package:fluttertoast/fluttertoast.dart';

class InsertRowScreen extends StatelessWidget {
  TextEditingController nameTextEditController = TextEditingController();
  TextEditingController mobileNumberTextEditController =
      TextEditingController();
  TextEditingController modelNumberTextEditController = TextEditingController();
  TextEditingController purchaseDateTextEditController =
      TextEditingController();
  TextEditingController emailAddressEditController = TextEditingController();
  InsertRowScreenBloc _bloc;
  BuildContext pageContext;

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<InsertRowScreenBloc>(context);
    this.pageContext = context;
    return renderScreen(context);
  }

  Widget renderScreen(BuildContext context) {
    return BlocBuilder<InsertRowScreenBloc, InsertRowScreenState>(
        builder: (context, state) {
      print("State : ${state}");
      if (state is InseringtDataInsertRowScreenState) {
        return buildScreen(context);
      } else if (state is SignInUserInsertRowScreenState) {
        _signInUser();
        return buildScreen(context);
      } else if (state is SavingDataInsertRowScreenState) {
        return buildLoadingScreen();
      } else if (state is DataSavedInsertRowScreenState) {
        _afterDataSaved();
        return buildScreen(context);
      } else if (state is DataSaveErrorInsertRowScreenState) {
        Fluttertoast.showToast(
            msg: state.errorMessage,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _bloc.add(ErrorAppearedToUserInsertRowScreenEvent());
        return buildScreen(context);
      }
    });
  }

  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: FeebackAppBarWidget(),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        height: MediaQuery.of(context).size.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 64,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: FeebackTextField(
                  hint: "Name",
                  controller: nameTextEditController,
                  icon: Icon(
                    Icons.account_box,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: FeebackTextField(
                  hint: "Mobile Number",
                  controller: mobileNumberTextEditController,
                  icon: Icon(
                    Icons.phone,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: FeebackTextField(
                  hint: "Model Number",
                  controller: modelNumberTextEditController,
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: FeebackTextField(
                  hint: "Purchase Date",
                  controller: purchaseDateTextEditController,
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: FeebackTextField(
                  hint: "Email Address",
                  controller: emailAddressEditController,
                  icon: Icon(
                    Icons.assignment_ind,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                  color: AppConstants.FEEBACK_SECONDARY_COLOR,
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(128, 12, 128, 12),
                  onPressed: () {
                    print("Insert Row And Block");
                    this._insertRow();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoadingScreen() {
    return Scaffold(
      appBar: FeebackAppBarWidget(),
      body: Center(
          child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                  AppConstants.FEEBACK_SECONDARY_COLOR))),
    );
  }

  _insertRow() {
    InserRowForm form = new InserRowForm(
        name: nameTextEditController.text,
        mobileNumber: mobileNumberTextEditController.text,
        modelNumber: modelNumberTextEditController.text,
        purchaseDate: purchaseDateTextEditController.text,
        emailAddress: emailAddressEditController.text);
    _bloc.add(SaveDataRowInsertRowScreenEvent(form));
  }

  _signInUser() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId: AppConstants.GOOGLE_API_CLIENT_ID,
      scopes: [
        "https://www.googleapis.com/auth/spreadsheets",
      ],
    );
    try {
      await _googleSignIn.signOut();
      var result = await _googleSignIn.signIn();
      var authentication = await result.authentication;
      _bloc.add(UserSignedInWithGoogleInsertRowScreenEvent(
          authentication.accessToken));
    } catch (error) {
      print(error);
    }
  }

  _afterDataSaved() {
    Timer(Duration(seconds: 0), () {
      _bloc.add(ErrorAppearedToUserInsertRowScreenEvent());
      Navigator.push(
        this.pageContext,
        new MaterialPageRoute(builder: (context) => RowListScreen()),
      );
    });
  }
}
