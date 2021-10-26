//interfaces/abstract classes
//concrete implementations
//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/models/tutorial_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/tutorial_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/service/impl/http_get_call_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/dynamic_list_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

import 'form_coordinator.dart';

class DetailCoordinator extends Coordinator {
  final clientURL =
      'https://prepublishbasket.s3.us-east-2.amazonaws.com/beforewecode/beforewecode.json';

  late Widget widget;

  @override
  void end() {}

  @override
  void restart() {}

  @override
  View start() {
    final getData = HttpGetCallImpl(
      clientURL: clientURL,
    );
    final tutorialModel = TutorialModelImpl(getData: getData);
    var viewModel =
        TutorialViewModelImpl(coordinator: this, tutorialModel: tutorialModel);
    var quizWidget = DynamicListView(
      viewModel,
    );
    widget = quizWidget;
    return quizWidget;
  }

  @override
  View move(int to, BuildContext context) {
    switch (to) {
      case 0:
        FormCoordinator formCoordinator = FormCoordinator();
        formCoordinator.showExternalFeedback = true;
        View widget = formCoordinator.start();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget));
        return widget;
      default:
        throw UnimplementedError();
    }
  }
}
