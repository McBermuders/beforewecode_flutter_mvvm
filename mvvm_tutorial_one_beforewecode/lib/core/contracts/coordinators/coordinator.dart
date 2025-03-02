import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/project_navigator.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';

abstract interface class Coordinator implements ProjectNavigator {
  Coordinator();

  TheView start();

  void end();
}
