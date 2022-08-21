import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/login_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/models/login_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/input_feedback_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/sample_form_external_feedback_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/sample_form_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/sample_form_external_feedback_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/sample_form_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class FormCoordinator extends Coordinator {
  late View widget;
  bool showExternalFeedback = false;

  @override
  void end() {
    // TODO: implement end
  }

  @override
  View<ViewModel> move(NavigationIdentifier to, BuildContext context) {
    View view = RootCoordinator().start();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => view));
    return view;
  }

  @override
  View<ViewModel> start() {
    if (showExternalFeedback) {
      LoginModelContract loginModelContract = LoginModelImpl();
      var viewModel = SampleFormViewModelImpl(this, loginModelContract);
      widget = SampleFormView(
        viewModel,
      );
      return widget;
    } else {
      LoginModelContract loginModelContract = LoginModelImpl();
      var viewModel = SampleFormExternalFeedbackViewModelImpl(
        this,
        loginModelContract,
        InputFeedbackViewModelImpl(this),
        InputFeedbackViewModelImpl(this),
      );
      widget = SampleFormExternalFeedbackView(
        viewModel,


      );
      return widget;
    }
  }
}
