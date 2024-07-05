import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/simple_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/regular_text_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/widgets/listtiles/text_tile.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';

class TestView extends TheView<SimpleViewModel> implements TickerProvider {
  const TestView({required SimpleViewModel viewModel})
      : super(viewModel, const Key("TestView"));

  @override
  Widget buildWithViewModel(BuildContext context, SimpleViewModel viewModel) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 15,
                backgroundColor: Colors.grey,
                title: Center(
                  child: GestureDetector(
                    onTap: () {
                      handleRefresh();
                    },
                    child: SizedBox(
                      height: 60,
                      child: Image.asset("assets/logocode.png"),
                    ),
                  ),
                ),
                floating: true,
                pinned: true,
                snap: true,
              ),
            ];
          },
          body: viewModel.cardCount() == 0
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : getList(viewModel)),
    );
  }

  Widget getList(SimpleViewModel viewModel) {
    final item = ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(18),
      itemCount: viewModel.cardCount(),
      itemBuilder: (BuildContext context, int index) {
        var widthFactor = min(500 / MediaQuery.of(context).size.width, 1.0);
        RegularTextCard card =
            viewModel.getCardAtIndex(index) as RegularTextCard;
        return TextTile(
          key: Key("TextTile$index"),
          textCard: card,
          widthFactor: widthFactor,
        );
      },
    );
    var r = RefreshIndicator(
      onRefresh: handleRefresh,
      child: item,
    );
    return r;
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
