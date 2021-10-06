import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/input_feedback_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class InputFeedbackViewModelImpl extends InputFeedbackViewModel {
  @override
  InputFeedbackViewModelImpl(Coordinator coordinator) : super(coordinator);

  final datasourceChangedStreamController =
      StreamController<InputFeedbackViewModel>.broadcast();
  String feedback = "a";
  bool shouldShowFeedback = false;

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
  String getFeedback() {
    return feedback;
  }

  @override
  bool showFeedback() {
    return shouldShowFeedback;
  }

  @override
  void setFeedback(String feedback) {
    this.feedback = feedback;
  }

  @override
  void setShowFeedback(bool showFeedback) {
    if (shouldShowFeedback != showFeedback) {
      shouldShowFeedback = showFeedback;
      datasourceChangedStreamController.sink.add(this);
    }
  }
}
