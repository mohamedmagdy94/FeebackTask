import 'package:flutter/material.dart';
import '../Constant/app_constants.dart' as AppConstants;

class FeebackAppBarWidget extends StatefulWidget
    implements PreferredSizeWidget {
  FeebackAppBarWidget({Key key})
      : preferredSize = Size.fromHeight(96),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  FeebackAppBarWidgetState createState() => FeebackAppBarWidgetState();
}

class FeebackAppBarWidgetState extends State<FeebackAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(32.0),
      )),
      centerTitle: false,
      title: Container(
        padding: EdgeInsets.only(top: 32),
        alignment: Alignment.center, // This is needed
        child: Image.asset(
          'assets/images/logo_white.png',
          fit: BoxFit.fitWidth,
          width: 88,
          height: 88,
        ),
      ),
      backgroundColor: AppConstants.FEEBACK_PRIMARY_COLOR,
    );
  }
}
