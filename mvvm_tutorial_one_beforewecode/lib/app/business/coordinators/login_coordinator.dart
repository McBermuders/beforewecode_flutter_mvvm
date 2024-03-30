import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/models/login_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/input_feedback_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/login_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/login_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class LoginCoordinator extends Coordinator {
  late TheView widget;

  @override
  void end() {
    // TODO: implement end
  }

  @override
  TheView<ViewModel> move(NavigationIdentifier to, BuildContext context) {
    TheView view = RootCoordinator().start();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
    return view;
  }

  @override
  TheView<ViewModel> start() {
    LoginModelContract loginModelContract = LoginModelImpl();
    var viewModel = LoginViewModelImpl(
      this,
      loginModelContract,
      InputFeedbackViewModelImpl(this),
      InputFeedbackViewModelImpl(this),
    );
    widget = LoginView(
      viewModel,
    );
    return widget;
  }
}
