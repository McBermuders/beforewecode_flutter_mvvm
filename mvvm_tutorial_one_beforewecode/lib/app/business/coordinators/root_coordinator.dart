//interfaces/abstract classes
//concrete implementations

//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/detail_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/detail_tutorial_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/tutorial_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

class RootCoordinator extends Coordinator {
  @override
  void end() {}

  @override
  void restart() {}

  @override
  View start() {
    var viewModel = DetailTutorialViewModelImpl(coordinator: this);
    final view = TutorialView(
      viewModel,
    );
    return view;
  }

  @override
  View move(int to, BuildContext context) {
    switch (to) {
      case 0:
        View widget = DetailCoordinator().start();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
        return widget;
      default:
        throw UnimplementedError();
    }
  }
}
