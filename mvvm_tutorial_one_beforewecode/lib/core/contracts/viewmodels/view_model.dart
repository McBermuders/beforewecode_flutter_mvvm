import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';

abstract interface class ViewModel {
  Coordinator get coordinator;

  Stream<ViewModel> get datasourceChanged;

  void dispose();

  Future<void> loadData();
}
