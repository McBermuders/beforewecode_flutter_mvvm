import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/models/login_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/input_feedback_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/login_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/sample_form_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/features/login/views/login_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/sample_form_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class FormCoordinator implements Coordinator {
  late TheView widget;
  bool showExternalFeedback = true;

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
    if (showExternalFeedback) {
      LoginModelContract loginModelContract = LoginModelImpl();
      var viewModel = SampleFormViewModelImpl(
          coordinator: this, loginModelContract: loginModelContract);
      widget = SampleFormView(
        viewModel,
      );
      return widget;
    } else {
      LoginModelContract loginModelContract = LoginModelImpl();
      var viewModel = LoginViewModelImpl(
        InputFeedbackViewModelImpl(coordinator: this),
        InputFeedbackViewModelImpl(coordinator: this),
        coordinator: this,
        loginModelContract: loginModelContract,
      );
      widget = LoginView(
        viewModel,
      );
      return widget;
    }
  }
}
