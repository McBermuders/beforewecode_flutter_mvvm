import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

abstract class ProjectNavigator {
  ProjectNavigator();

  View move(int to, BuildContext context);
}