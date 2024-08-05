import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/input_feedback_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/login_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class LoginModel {
  bool showUsernameValidationError = false;
}

class LoginViewModelImpl extends LoginViewModel {
  LoginViewModelImpl(
      Coordinator coordinator,
      LoginModelContract loginModelContract,
      this.inputFeedbackViewModel,
      this.loginFeedbackViewModel)
      : super(coordinator, loginModelContract);
  final datasourceChangedStreamController =
      StreamController<LoginViewModel>.broadcast();
  final InputFeedbackViewModel inputFeedbackViewModel;
  final InputFeedbackViewModel loginFeedbackViewModel;

  final LoginModel validationModel = LoginModel();

  @override
  Stream<ViewModel> get datasourceChanged =>
      datasourceChangedStreamController.stream;

  @override
  void dispose() {
    datasourceChangedStreamController.close();
  }

  @override
  Future<void> loadData() async {
    return;
  }

  @override
  void updatePassword(String updatedPassword) {
    loginModelContract.updatePassword(updatedPassword);
  }

  @override
  void updateUsername(String updatedUsername) {
    validationModel.showUsernameValidationError =
        !loginModelContract.updateUsername(updatedUsername);
    inputFeedbackViewModel.setFeedback("only numbers allowed");
    inputFeedbackViewModel.setShowFeedback(
        validationModel.showUsernameValidationError);
  }

  @override
  bool showUpdateUsernameError() {
    return validationModel.showUsernameValidationError;
  }

  @override
  InputFeedbackViewModel getInputFeedbackViewModel() {
    return inputFeedbackViewModel;
  }

  @override
  InputFeedbackViewModel getLoginFeedbackViewModel() {
    return loginFeedbackViewModel;
  }

  @override
  bool login() {
    final loginSucceed = loginModelContract.login();
    loginFeedbackViewModel.setFeedback("invalid input: try 123 and easyasabc");
    loginFeedbackViewModel.setShowFeedback(!loginSucceed);
    return loginSucceed;
  }

  @override
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "password is required";
    }
    if (password.length < 8) {
      return "you need at least 8 characters";
    }
    return null;
  }

  @override
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "username is required just numbers allowed";
    }
    if (username.length < 3) {
      return "you need at least 3 characters just numbers allowed";
    }
    return null;
  }

  @override
  List<Object?> get props => [validationModel];
}
