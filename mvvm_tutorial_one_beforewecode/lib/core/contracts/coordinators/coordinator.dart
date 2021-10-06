import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';

abstract class Coordinator implements ProjectNavigator {
  Coordinator();

  View start();

  void restart();

  void end();
}
