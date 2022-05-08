import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';
typedef NavigationIdentifier = int;
abstract class NavigationIdentifiers {
  static const NavigationIdentifier none = 0;
}

abstract class ProjectNavigator {
  ProjectNavigator();

  View move(NavigationIdentifier to, BuildContext context);
}
