import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/sample_form_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class ValidationModel {
  bool showUsernameValidationError = false;
  bool showLoginError = false;
}

class SampleFormViewModelImpl implements SampleFormViewModel {
  @override
  final Coordinator coordinator;
  @override
  final LoginModelContract loginModelContract;

  SampleFormViewModelImpl(
      {required this.coordinator, required this.loginModelContract});

  final datasourceChangedStreamController =
      StreamController<SampleFormViewModel>.broadcast();
  final ValidationModel validationModel = ValidationModel();

  @override
  Stream<ViewModel> get datasourceChanged =>
      datasourceChangedStreamController.stream;

  @override
  void dispose() {
    datasourceChangedStreamController.close();
  }

  @override
  Future<void> loadData() async {
    // TODO: implement loadData
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
    datasourceChangedStreamController.sink.add(this);
  }

  @override
  bool showUpdateUsernameError() {
    return validationModel.showUsernameValidationError;
  }

  @override
  bool showUpdateLoginError() {
    return validationModel.showLoginError;
  }

  @override
  bool login() {
    bool loginSucceed = loginModelContract.login();
    validationModel.showLoginError = !loginSucceed;
    datasourceChangedStreamController.sink.add(this);
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
      return "you need at least 3 characters";
    }
    return null;
  }
}
