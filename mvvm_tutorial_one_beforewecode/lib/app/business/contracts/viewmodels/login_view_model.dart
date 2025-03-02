import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

import 'input_feedback_view_model.dart';

abstract interface class LoginViewModel implements ViewModel {
  LoginModelContract get loginModelContract;

  InputFeedbackViewModel get inputFeedbackViewModel;

  void updateUsername(String updatedUsername);

  void updatePassword(String updatedPassword);

  bool showUpdateUsernameError();

  bool login();

  String? validateUsername(String? username);

  String? validatePassword(String? password);
}
