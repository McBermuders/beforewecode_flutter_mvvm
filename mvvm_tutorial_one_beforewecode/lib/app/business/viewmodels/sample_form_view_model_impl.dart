import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/sample_form_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class SampleFormViewModelImpl extends SampleFormViewModel {
  SampleFormViewModelImpl(
      Coordinator coordinator, LoginModelContract loginModelContract)
      : super(coordinator, loginModelContract);
  final datasourceChangedStreamController =
      StreamController<SampleFormViewModel>.broadcast();
  bool showUsernameValidationError = false;
  bool showLoginError = false;

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
    showUsernameValidationError =
        !loginModelContract.updateUsername(updatedUsername);
    datasourceChangedStreamController.sink.add(this);
  }

  @override
  bool showUpdateUsernameError() {
    return showUsernameValidationError;
  }

  @override
  bool showUpdateLoginError() {
    return showLoginError;
  }

  @override
  bool login() {
    bool loginSucceed = loginModelContract.login();
    showLoginError = !loginSucceed;
    datasourceChangedStreamController.sink.add(this);
    return loginSucceed;
  }
}
