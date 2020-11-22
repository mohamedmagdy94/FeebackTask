import 'package:flutter/material.dart';
import '../Constant/app_constants.dart' as AppConstants;

class FeebackTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  Icon icon;

  FeebackTextField({this.hint, this.controller, this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.FEEBACK_PRIMARY_COLOR),
        ),
        prefixIcon: (icon),
      ),
      controller: controller,
    );
  }
}
