//interfaces/abstract classes
//concrete implementations
//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/root_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/viewmodels/simple_view_model_impl.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/test_view.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

class TestCoordinator extends Coordinator {
  final clientURL =
      'https://prepublishbasket.s3.us-east-2.amazonaws.com/beforewecode/beforewecode.json';

  @override
  void end() {}

  @override
  void restart() {}

  @override
  View start() {
    var viewModel = SimpleViewModelImpl(this);
    View view = TestView(
      viewModel: viewModel,
    );
    return view;
  }

  @override
  View move(int to, BuildContext context) {
    switch (to) {
      case 0:
        View widget = RootCoordinator().start();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
        return widget;
      default:
        throw UnimplementedError();
    }
  }
}
