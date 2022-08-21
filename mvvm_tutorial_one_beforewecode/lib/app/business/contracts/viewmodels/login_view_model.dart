import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

import 'input_feedback_view_model.dart';

abstract class LoginViewModel extends ViewModel {
  LoginViewModel(
      Coordinator coordinator, this.loginModelContract)
      : super(coordinator);
  final LoginModelContract loginModelContract;

  void updateUsername(String updatedUsername);

  void updatePassword(String updatedPassword);

  bool showUpdateUsernameError();

  bool login();

  InputFeedbackViewModel getInputFeedbackViewModel();

  InputFeedbackViewModel getLoginFeedbackViewModel();

  String? validateUsername(String? username);

  String? validatePassword(String? password);
}
