import 'package:mvvm_tutorial_one_beforewecode/core/contracts/coordinators/coordinator.dart';

abstract class ViewModel {
  ViewModel(this.coordinator);
  final Coordinator coordinator;
  Stream<ViewModel> get datasourceChanged;
  void dispose();
  Future<void> loadData();
}