import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';

abstract class NavigationAppIdentifiers implements NavigationIdentifiers {
  static const NavigationIdentifier root = 0;
  static const NavigationIdentifier detail = 1;
  static const NavigationIdentifier form = 2;
}
