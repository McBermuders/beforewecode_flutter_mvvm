import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract class SimpleViewModel extends ViewModel {
  SimpleViewModel(Coordinator coordinator) : super(coordinator);

  Card getCardAtIndex(int index);

  int cardCount();
}
