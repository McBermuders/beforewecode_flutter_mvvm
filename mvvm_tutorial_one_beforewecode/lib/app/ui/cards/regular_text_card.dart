import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';

class RegularTextCard implements Card {
  final String title;
  final bool bold;

  RegularTextCard(this.title, this.bold);
}