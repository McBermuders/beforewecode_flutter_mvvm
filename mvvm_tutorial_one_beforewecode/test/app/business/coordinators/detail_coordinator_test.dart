


// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_test/flutter_test.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/detail_coordinator.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/views/dynamic_list_view.dart';

void main() {
  test('start type', () async {
    final coordinator = DetailCoordinator();
    expect(coordinator.start() is DynamicListView,true);
    expect(coordinator.start(),coordinator.widget);
  });

}
