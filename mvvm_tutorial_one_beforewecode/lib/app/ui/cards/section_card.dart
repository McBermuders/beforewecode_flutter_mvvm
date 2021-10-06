import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';

class SectionCard implements Card {
  SectionCard(
      {required this.title,
        required this.subtitle,
        required this.description,
        required this.imageUrl});

  var title = "null";
  var subtitle = "null";
  var description = "null";
  var imageUrl = "'https://prepublish.us/images/prepublishapp1.png";
}