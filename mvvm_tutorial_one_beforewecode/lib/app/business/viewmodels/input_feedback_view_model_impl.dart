import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/input_feedback_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class FeedBackModel {
  String feedback = "a";
  bool shouldShowFeedback = false;
}

class InputFeedbackViewModelImpl extends InputFeedbackViewModel {
  @override
  InputFeedbackViewModelImpl(Coordinator coordinator) : super(coordinator);

  final datasourceChangedStreamController =
      StreamController<InputFeedbackViewModel>.broadcast();
  final FeedBackModel feedback = FeedBackModel();

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
    return feedback.feedback;
  }

  @override
  bool showFeedback() {
    return feedback.shouldShowFeedback;
  }

  @override
  void setFeedback(String feedback) {
    this.feedback.feedback = feedback;
  }

  @override
  void setShowFeedback(bool showFeedback) {
    if (feedback.shouldShowFeedback != showFeedback) {
      feedback.shouldShowFeedback = showFeedback;
      datasourceChangedStreamController.sink.add(this);
    }
  }

  @override
  List<Object?> get props => [feedback.feedback, feedback.shouldShowFeedback];
}
