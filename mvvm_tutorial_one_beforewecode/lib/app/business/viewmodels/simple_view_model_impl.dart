import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/simple_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/regular_text_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

class CardCounter {
  int cardCounter = 0;
}

class SimpleViewModelImpl implements SimpleViewModel {
  @override
  final Coordinator coordinator;

  final CardCounter cardCounter = CardCounter();
  final datasourceChangedStreamController =
      StreamController<SimpleViewModelImpl>.broadcast();

  SimpleViewModelImpl({required this.coordinator});

  @override
  Stream<ViewModel> get datasourceChanged =>
      datasourceChangedStreamController.stream;

  @override
  void dispose() {
    datasourceChangedStreamController.close();
  }

  @override
  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    cardCounter.cardCounter = cardCounter.cardCounter + 1;
    datasourceChangedStreamController.sink.add(this);
  }

  @override
  int cardCount() {
    return cardCounter.cardCounter;
  }

  @override
  RegularTextCard getCardAtIndex(index) {
    var reg = RegularTextCard("Test $index", false);
    return reg;
  }
}
