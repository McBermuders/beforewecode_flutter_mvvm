//interfaces/abstract classes
//external packages
import 'dart:async';
import 'dart:convert';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/models/tutorial_model_contract.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/contracts/card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/information_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/regular_text_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/service/http_get_call.dart';

class TutorialModelImpl extends TutorialModelContract {
  @override
  Stream<TutorialResponseModel> get response =>
      datasourceChangedStreamController.stream;

  bool isLoadingContent = false;
  final datasourceChangedStreamController =
      StreamController<TutorialResponseModel>.broadcast();
  final HttpGetCall getData;

  TutorialModelImpl({required this.getData}) {
    getData.setOnErrorListener((error) => () {
          networkUpdateFailed(error);
        });
  }

  @override
  Future<void> loadData() async {
    if (isLoadingContent) {
      return;
    }
    isLoadingContent = true;
    final value = await getData.startRequest();
    update(value);
    return;
  }

  void networkUpdateFailed(Object onError) {
    TutorialResponseModel responseModel = TutorialResponseModel(
        status: TutorialResponseStatus.networkError, informations: []);
    datasourceChangedStreamController.sink.add(responseModel);
    isLoadingContent = false;
  }

  void update(String value) {
    parseInformation(value);
  }

  void parseInformation(String responseBody) {
    if (responseBody.isEmpty) {
      isLoadingContent = false;
      TutorialResponseModel responseModel = TutorialResponseModel(
          status: TutorialResponseStatus.noDataReceived, informations: []);
      datasourceChangedStreamController.sink.add(responseModel);
      return;
    }
    var cards = [];
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Information> information =
        parsed.map<Information>((json) => Information.fromJson(json)).toList();
    for (int sectionIndex = 0;
        sectionIndex < information.length;
        sectionIndex++) {
      cards.add(<Card>[]);
      cards[sectionIndex].insert(
          0,
          SectionCard(
              title: information[sectionIndex].title,
              subtitle: "",
              description: information[sectionIndex].description,
              imageUrl: information[sectionIndex].imageURL));
      var children = information[sectionIndex].children;
      if (children != null && children.isNotEmpty) {
        for (int index = 0; index < children.length; index++) {
          if (children[index].title.isNotEmpty) {
            var card = RegularTextCard(children[index].title,true);
            cards[sectionIndex].add(card);
          }
          if (children[index].description.isNotEmpty) {
            var card = RegularTextCard(children[index].description, false);
            cards[sectionIndex].add(card);
          }
        }
      }
    }
    TutorialResponseModel responseModel = TutorialResponseModel(
        status: TutorialResponseStatus.succeed, informations: cards);
    datasourceChangedStreamController.sink.add(responseModel);
    isLoadingContent = false;
  }

  @override
  void dispose() {
    datasourceChangedStreamController.close();
  }
}
