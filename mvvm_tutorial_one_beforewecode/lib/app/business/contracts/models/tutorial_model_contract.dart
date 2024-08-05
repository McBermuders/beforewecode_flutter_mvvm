import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';

abstract class TutorialModelContract {
  Stream<TutorialResponseModel> get response;

  Future<void> loadData();

  void dispose();
}

enum TutorialResponseStatus { succeed, noDataReceived, networkError, loading }

class TutorialResponseModel {
  final TutorialResponseStatus status;
  final List<List<Card>> sections;

  TutorialResponseModel({required this.status, required this.sections});
}
