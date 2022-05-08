import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/tutorial_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_code_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/widgets/listtiles/header_with_optional_image_tile.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/widgets/listtiles/text_tile.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/view.dart';
import '../cards/regular_text_card.dart';

//flutter
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

//dart
import 'dart:math';

class DynamicListView extends View<TutorialViewModel> {
  const DynamicListView(TutorialViewModel viewModel)
      : super(viewModel, const Key("TutorialView"));

  @override
  Widget buildWithViewModel(BuildContext context, TutorialViewModel viewModel) {
    return DynamicListViewScreen(viewModel, handleRefresh);
  }
}

typedef HandleRefresh = Future<void> Function();

class DynamicListViewScreen extends StatefulWidget {
  final TutorialViewModel viewModel;
  final HandleRefresh handleRefresh;

  const DynamicListViewScreen(this.viewModel, this.handleRefresh)
      : super(key: const Key("TutorialViewScreen"));

  @override
  State<StatefulWidget> createState() => DynamicListViewScreenState();
}

class DynamicListViewScreenState extends State<DynamicListViewScreen>
    implements TickerProvider {
  late TabController tabController;
  late final HandleRefresh handleRefresh;
  late final TutorialViewModel viewModel;

  DynamicListViewScreenState();

  @override
  void initState() {
    handleRefresh = widget.handleRefresh;
    viewModel = widget.viewModel;
    tabController = TabController(
        vsync: this,
        length: viewModel.sectionCount() == 0 ? 1 : viewModel.sectionCount(),
        initialIndex: viewModel.getSelectedSection());
    tabController.addListener(_handleTabChange);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DynamicListViewScreen oldWidget) {
    if (tabController.length != viewModel.sectionCount()) {
      setState(() {
        tabController.dispose();
        tabController = TabController(
            vsync: this,
            length:
                viewModel.sectionCount() == 0 ? 1 : viewModel.sectionCount(),
            initialIndex: viewModel.getSelectedSection());
        tabController.addListener(_handleTabChange);
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }

  void _handleTabChange() {
    viewModel.setSelectedSection(tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    var tabs = <Tab>[];
    var widgets = <Widget>[];
    var sectionCount = viewModel.sectionCount();

    if (sectionCount == 0) {
      tabs.add(const Tab(
        text: "",
      ));
      widgets.add(const Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      for (int i = 0; i < sectionCount; i++) {
        tabs.add(Tab(
          text: viewModel.infoForSection(i).title,
        ));
      }

      for (int i = 0; i < sectionCount; i++) {
        var c = ScrollController(keepScrollOffset: false);
        widgets.add(getList(i, c, tabController));
      }
    }

    return DefaultTabController(
      key: const Key("TutorialViewDefaultTabController"),
      length: tabs.length,
      child: Scaffold(
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
                bottom: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  controller: tabController,
                  isScrollable: true,
                  tabs: tabs,
                ),
              ),
            ];
          },
          body: Container(
            decoration: const BoxDecoration(color: Colors.black12),
            child: TabBarView(
              children: widgets,
              controller: tabController,
            ),
          ),
        ),
      ),
    );
  }

  Widget getList(int section, ScrollController c, TabController tabController) {
    final item = ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(18),
      itemCount: viewModel.cardCount(section),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          SectionCard sectionCard =
              viewModel.getCardAtIndex(section, index) as SectionCard;
          return HeaderWithOptionalImageTile(
            navigator: viewModel.coordinator,
            imageURL: sectionCard.imageUrl,
            key: Key("HeaderWithOptionalImageTile$section-$index"),
            navigationIdentifier: NavigationCodeIdentifiers.form,
          );
        }
        var widthFactor = min(500 / MediaQuery.of(context).size.width, 1.0);
        RegularTextCard card =
            viewModel.getCardAtIndex(section, index) as RegularTextCard;
        return TextTile(
          key: Key("TextTile$section-$index"),
          textCard: card,
          widthFactor: widthFactor,
        );
      },
    );
    var r = RefreshIndicator(onRefresh: handleRefresh, child: item);
    return r;
  }
}
