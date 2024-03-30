import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/input_feedback_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';

class InputFeedbackView extends TheView<InputFeedbackViewModel> {
  const InputFeedbackView(InputFeedbackViewModel viewModel, Key key)
      : super(viewModel, key);

  @override
  Widget buildWithViewModel(
      BuildContext context, InputFeedbackViewModel viewModel) {
    return viewModel.showFeedback()
        ? Text(viewModel.getFeedback())
        : Container();
  }
}
