import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/viewmodels/view_model.dart';

abstract class TheView<V extends ViewModel> extends StatefulWidget {
  final V viewModel;

  @protected
  Widget buildWithViewModel(BuildContext context, V viewModel);

  const TheView(this.viewModel, Key key) : super(key: key);

  @override
  State<TheView> createState() {
    return TheViewState<V>();
  }

  Future<void> handleRefresh() async {
    return await viewModel.loadData();
  }

  void dispose() {}
}

class TheViewState<V extends ViewModel> extends State<TheView> {
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
