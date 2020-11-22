import 'package:FeebackTask/Common/Service/Contract/authentication_manager_contract.dart';

class AuthenticationManager implements AuthenticationManagerContract {
  String _accessToken = "";

  static final AuthenticationManager _singleton =
      AuthenticationManager._internal();

  factory AuthenticationManager() {
    return _singleton;
  }

  AuthenticationManager._internal();

  @override
  autheticateUser(String accessToken) {
    // TODO: implement autheticateUser
    print("Access Token ${accessToken}");
    _accessToken = accessToken;
  }

  @override
  String getUserAccessToken() {
    // TODO: implement getUserAccessToken
    return _accessToken;
  }

  @override
  bool isUserLoggedIn() {
    // TODO: implement isUserLoggedIn
    if (_accessToken == "") {
      return false;
    } else {
      return true;
    }
  }
}
