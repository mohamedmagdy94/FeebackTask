import 'package:FeebackTask/Row%20List/Data/row_card_cell_view_model.dart';
import 'package:flutter/material.dart';
import '../../../Common/Constant/app_constants.dart' as AppConstants;

class FeebackRowCardWidget extends StatelessWidget {
  RowCardCellViewModel viewModel;
  Function deleteCallback;

  FeebackRowCardWidget({this.viewModel, this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Container(
            padding: EdgeInsets.only(top: 42, left: 16),
            width: MediaQuery.of(context).size.width * 0.98,
            height: 220,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_box,
                      color: AppConstants.FEEBACK_SECONDARY_COLOR,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      viewModel.name ??= "",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.phone,
                      color: AppConstants.FEEBACK_SECONDARY_COLOR,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      viewModel.phone ??= "",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: AppConstants.FEEBACK_SECONDARY_COLOR,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      viewModel.email ??= "",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment,
                      color: AppConstants.FEEBACK_SECONDARY_COLOR,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      viewModel.modelNumber ??= "",
                      style: TextStyle(color: Colors.grey, fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16, left: 8),
          child: Container(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 24.0,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  viewModel.date ??= "",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: AppConstants.FEEBACK_SECONDARY_COLOR,
                border: Border.all(
                  color: AppConstants.FEEBACK_SECONDARY_COLOR,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            width: 140,
            height: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 230, right: 16),
          child: Align(
              alignment: Alignment.topRight,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
                color: Colors.red,
                textColor: Colors.red,
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                onPressed: () {
                  deleteCallback();
                },
                child: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 32.0,
                ),
              )),
        )
      ],
    );
  }
}
