import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract class TheView<V extends ViewModel> extends StatefulWidget {
  final V _viewModel;

  @protected
  Widget buildWithViewModel(BuildContext context, V viewModel);

  const TheView(this._viewModel, Key key) : super(key: key);

  @override
  State<TheView> createState() {
    return TheViewState<V>();
  }

  Future<void> handleRefresh() async {
    return await _viewModel.loadData();
  }

  void dispose() {}
}

class TheViewState<V extends ViewModel> extends State<TheView> {
  late V viewModel;
  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    viewModel = widget._viewModel as V;
    StreamSubscription<ViewModel> _streamDatasourceChanged;
    _streamDatasourceChanged = viewModel.datasourceChanged.listen((viewModel) {
      setState(() {});
    });
    subscriptions.add(_streamDatasourceChanged);
    viewModel.loadData();
    super.initState();
  }

  @override
  void dispose() {
    for (var subscription in subscriptions) {
      subscription.cancel();
    }
    widget.dispose();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildWithViewModel(context, viewModel);
  }
}

class ViewModelProvider<V extends ViewModel> extends InheritedWidget {
  final V viewModel;

  const ViewModelProvider(
      {super.key, required super.child, required this.viewModel});

  @override
  bool updateShouldNotify(ViewModelProvider oldWidget) {
    return oldWidget.viewModel != oldWidget.viewModel;
  }

  static ViewModelProvider<V>? maybeOf<V extends ViewModel>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ViewModelProvider<V>>();
  }

  static ViewModelProvider<V> of<V extends ViewModel>(BuildContext context) {
    final ViewModelProvider<V>? result = maybeOf<V>(context);
    assert(result != null, 'No ViewModelProvider ${V.runtimeType} found in context');
    return result!;
  }
}
