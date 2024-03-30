import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';
typedef NavigationIdentifier = int;
abstract class NavigationIdentifiers {
  static const NavigationIdentifier none = 0;
}

abstract class ProjectNavigator {
  ProjectNavigator();

  TheView move(NavigationIdentifier to, BuildContext context);
}
