import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract interface class SampleFormViewModel implements ViewModel {
  LoginModelContract get loginModelContract;

  void updateUsername(String updatedUsername);

  void updatePassword(String updatedPassword);

  String? validateUsername(String? username);

  String? validatePassword(String? password);

  bool login();

  bool showUpdateUsernameError();

  bool showUpdateLoginError();
}
