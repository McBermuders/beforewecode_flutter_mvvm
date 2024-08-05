import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/tutorial_model_contract.dart';
import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/tutorial_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';

class SelectedSectionModel {
  int selectedSection = 0;
  int lastSelectedSection = 0;
}

class TutorialViewModelImpl extends TutorialViewModel {
  final TutorialModelContract tutorialModel;
  final List<List<Card>> cards = [];
  final SelectedSectionModel selectedSection = SelectedSectionModel();
  final datasourceChangedStreamController =
      StreamController<TutorialViewModel>.broadcast();
  final selectedSectionChangedController = StreamController<int>.broadcast();

  @override
  Stream<TutorialViewModel> get datasourceChanged =>
      datasourceChangedStreamController.stream;

  @override
  Stream<int> get selectedSectionChanged =>
      selectedSectionChangedController.stream;

  TutorialViewModelImpl(
      {required Coordinator coordinator, required this.tutorialModel})
      : super(coordinator) {
    tutorialModel.response.listen((responseModel) {
      cards.clear();
      for (final sectionOfCardList in responseModel.sections) {
        cards.add(sectionOfCardList);
      }
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
    SectionCard sectionCard = cards[section][0] as SectionCard;
    return sectionCard;
  }

  @override
  void sectionSelected(int section) {
    if (selectedSection.selectedSection == section) {
      return;
    }
    selectedSection.selectedSection = section;
    selectedSectionChangedController.sink.add(section);
  }

  @override
  int setSelectedSection(int selectedSection) {
    this.selectedSection.lastSelectedSection =
        this.selectedSection.selectedSection;
    this.selectedSection.selectedSection = selectedSection;
    return this.selectedSection.selectedSection;
  }

  @override
  int getSelectedSection() {
    return selectedSection.selectedSection;
  }

  @override
  int getLastSelectedSection() {
    return selectedSection.lastSelectedSection;
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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
