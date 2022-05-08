import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/input_feedback_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/input_feedback_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/input_feedback_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class InputFeedbackCoordinator extends Coordinator {
  final InputFeedbackViewModel? viewModel;

  InputFeedbackCoordinator(this.viewModel);

  @override
  void end() {
    // TODO: implement end
  }

  @override
  View<ViewModel> move(NavigationIdentifier to, BuildContext context) {
    return RootCoordinator().start();
  }

  @override
  View<ViewModel> start() {
    return InputFeedbackView(viewModel ?? InputFeedbackViewModelImpl(this),
        Key("Feedback${hashCode.toString()}"));
  }
}
