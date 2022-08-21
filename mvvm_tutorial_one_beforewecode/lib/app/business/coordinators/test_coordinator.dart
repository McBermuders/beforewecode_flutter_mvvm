//interfaces/abstract classes
//concrete implementations
//flutter
import 'package:flutter/material.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_app_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/simple_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/test_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

class TestCoordinator extends Coordinator {
  final clientURL =
      'https://aftercode.s3.us-east-2.amazonaws.com/prepublish.json';

  @override
  void end() {}

  @override
  View start() {
    var viewModel = SimpleViewModelImpl(this);
    View view = TestView(
      viewModel: viewModel,
    );
    return view;
  }

  @override
  View move(NavigationIdentifier to, BuildContext context) {
    switch (to) {
      case NavigationAppIdentifiers.root:
        View widget = RootCoordinator().start();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
        return widget;
      default:
        throw UnimplementedError();
    }
  }
}
