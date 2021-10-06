import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract class InputFeedbackViewModel extends ViewModel {
  InputFeedbackViewModel(Coordinator coordinator):super(coordinator);
  String getFeedback();
  bool showFeedback();
  void setFeedback(String feedback);
  void setShowFeedback(bool showFeedback);
}