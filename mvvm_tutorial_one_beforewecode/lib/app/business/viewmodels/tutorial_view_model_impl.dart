import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/tutorial_model_contract.dart';
import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/tutorial_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';

class TutorialViewModelImpl implements TutorialViewModel {
  final TutorialModelContract tutorialModel;
  var cards = [];
  int selectedSection = 0;
  int lastSelectedSection = 0;
  final datasourceChangedStreamController =
      StreamController<TutorialViewModel>.broadcast();
  final selectedSectionChangedController = StreamController<int>.broadcast();

  @override
  Stream<TutorialViewModel> get datasourceChanged =>
      datasourceChangedStreamController.stream;

  @override
  Stream<int> get selectedSectionChanged =>
      selectedSectionChangedController.stream;

  @override
  Coordinator coordinator;

  TutorialViewModelImpl(
      {required this.coordinator, required this.tutorialModel}) {
    tutorialModel.response.listen((responseModel) {
      cards = responseModel.informations;
      datasourceChangedStreamController.sink.add(this);
    });
  }

  @override
  int cardCount(int section) {
    if (section >= cards.length) {
      return 0;
    }
    return cards[section].length;
  }

  @override
  int sectionCount() {
    return cards.length;
  }

  @override
  Card getCardAtIndex(int section, int index) {
    return cards[section][index];
  }

  @override
  SectionCard infoForSection(int section) {
    SectionCard sectionCard = cards[section][0];
    return sectionCard;
  }

  @override
  void sectionSelected(int section) {
    if (selectedSection == section) {
      return;
    }
    selectedSection = section;
    selectedSectionChangedController.sink.add(section);
  }

  @override
  int setSelectedSection(int selectedSection) {
    lastSelectedSection = this.selectedSection;
    this.selectedSection = selectedSection;
    return this.selectedSection;
  }

  @override
  int getSelectedSection() {
    return selectedSection;
  }

  @override
  int getLastSelectedSection() {
    return lastSelectedSection;
  }

  @override
  void dispose() {
    coordinator.end();
    tutorialModel.dispose();
    datasourceChangedStreamController.close();
    selectedSectionChangedController.close();
  }

  @override
  Future<void> loadData() async {
    await tutorialModel.loadData();
    return;
  }
}
