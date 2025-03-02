import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract interface class SimpleViewModel implements ViewModel {
  Card getCardAtIndex(int index);

  int cardCount();
}
