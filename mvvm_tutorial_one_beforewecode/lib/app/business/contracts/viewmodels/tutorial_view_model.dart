import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract interface class TutorialViewModel implements ViewModel {
  Card getCardAtIndex(int section, int index);

  int cardCount(int section);

  int sectionCount();

  int getSelectedSection();

  void sectionSelected(int section);

  SectionCard infoForSection(int section);

  Stream<int> get selectedSectionChanged;

  int setSelectedSection(int selectedSection);

  int getLastSelectedSection();
}
