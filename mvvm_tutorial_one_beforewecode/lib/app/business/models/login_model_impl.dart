import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';

class LoginModelImpl extends LoginModelContract {
  String username = "";
  String password = "";

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Stream<LoginResponseModel> get response => throw UnimplementedError();

  @override
  Future<bool> submitLogin() {
    return Future.value(false);
  }

  @override
  void updatePassword(String updatedPassword) {
    password = updatedPassword;
  }

  @override
  bool updateUsername(String updatedUsername) {
    if (updatedUsername == username) {
      return false;
    }
    username = updatedUsername;
    return true;
  }

  @override
  bool login() {
    return username == "123" && password == "easyasabc";
  }

  @override
  String getUserName() {
    return username;
  }
}
