abstract class AuthenticationManagerContract {
  autheticateUser(String accessToken);
  String getUserAccessToken();
  bool isUserLoggedIn();
}
