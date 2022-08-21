abstract class LoginModelContract {
  Stream<LoginResponseModel> get response;
  Future<bool> submitLogin();
  void updatePassword(String updatedPassword);
  bool updateUsername(String updatedUsername);
  bool login();
  String getUserName();
  void dispose();
}


enum LoginResponseStatus{
  succeed,
  noDataReceived,
  networkError,
  loading
}

class LoginResponseModel {
  final LoginResponseStatus status;
  final List informations;

  LoginResponseModel({required this.status, required this.informations});
}

