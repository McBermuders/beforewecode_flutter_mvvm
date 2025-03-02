import 'dart:async';

import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/tutorial_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/regular_text_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';

class LoadingModel {
  bool isLoadingContent = false;
}

class SelectedSectionModel {
  int selectedSection = 0;
  int lastSelectedSection = 0;
}

class DetailTutorialViewModelImpl implements TutorialViewModel {
  final List<List<Card>> cards = [];
  final LoadingModel loadingModel = LoadingModel();
  final SelectedSectionModel selectedSection = SelectedSectionModel();
  @override
  final Coordinator coordinator;

  final datasourceChangedStreamController =
      StreamController<TutorialViewModel>.broadcast();
  final selectedSectionChangedController = StreamController<int>.broadcast();

  @override
  Stream<TutorialViewModel> get datasourceChanged =>
      datasourceChangedStreamController.stream;

  @override
  Stream<int> get selectedSectionChanged =>
      selectedSectionChangedController.stream;

  DetailTutorialViewModelImpl({required this.coordinator});

  @override
  Future<void> loadData() {
    return loadDataMockData();
  }

  Future<void> loadDataMockData() async {
    if (loadingModel.isLoadingContent) {
      return;
    }
    loadingModel.isLoadingContent = true;
    cards.clear();
    await Future.delayed(
      const Duration(seconds: 0),
      () => 'www.beforewecode.com',
    );

    for (int sectionIndex = 0; sectionIndex < 10; sectionIndex++) {
      cards.add(<Card>[]);
      cards[sectionIndex].insert(
          0,
          SectionCard(
              title: "Title Section " + sectionIndex.toString(),
              subtitle: "",
              description: "Title Section " + sectionIndex.toString(),
              imageUrl: ""));

      for (int index = 0; index < 10; index++) {
        if (index % 2 == 0) {
          var card = RegularTextCard(
              "Title " +
                  index.toString() +
                  " in Section " +
                  sectionIndex.toString(),
              true);
          cards[sectionIndex].add(card);
        } else {
          var card = RegularTextCard(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. " +
                  index.toString(),
              false);
          cards[sectionIndex].add(card);
        }
      }
      datasourceChangedStreamController.sink.add(this);
      loadingModel.isLoadingContent = false;
    }
    return;
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
  getLastSelectedSection() {
    return selectedSection.lastSelectedSection;
  }

  @override
  void dispose() {
    coordinator.end();
    datasourceChangedStreamController.close();
    selectedSectionChangedController.close();
  }
}
