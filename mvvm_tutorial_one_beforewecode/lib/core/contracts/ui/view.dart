import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract class View<V extends ViewModel> extends StatefulWidget {
  final V viewModel;

  @protected
  Widget buildWithViewModel(BuildContext context, V viewModel);

  const View(this.viewModel, Key key) : super(key: key);

  @override
  State<View> createState() {
    return ViewState<V>();
  }

  Future<void> handleRefresh() async {
    return await viewModel.loadData();
  }

  void dispose() {}
}

class ViewState<V extends ViewModel> extends State<View> {
  late V viewModel;
  List<StreamSubscription> subscriptions = [];

  @override
  void initState() {
    viewModel = widget.viewModel as V;
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
