import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract interface class InputFeedbackViewModel implements ViewModel {
  String getFeedback();

  bool showFeedback();

  void setFeedback(String feedback);

  void setShowFeedback(bool showFeedback);
}
