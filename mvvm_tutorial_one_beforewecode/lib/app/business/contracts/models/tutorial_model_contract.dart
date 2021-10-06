abstract class TutorialModelContract {
  Stream<TutorialResponseModel> get response;
  Future<void> loadData();
  void dispose();
}


enum TutorialResponseStatus{
  succeed,
  noDataReceived,
  networkError,
  loading
}

class TutorialResponseModel {
  final TutorialResponseStatus status;
  final List informations;

  TutorialResponseModel({required this.status, required this.informations});
}

