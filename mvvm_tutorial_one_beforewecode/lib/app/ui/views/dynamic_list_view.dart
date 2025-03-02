//dart
import 'dart:math';

//flutter
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/contracts/viewmodels/tutorial_view_model.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/business/coordinators/navigation_app_identifiers.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/regular_text_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/cards/section_card.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/widgets/listtiles/header_with_optional_image_tile.dart';
import 'package:mvvm_tutorial_one_beforewecode/app/ui/widgets/listtiles/text_tile.dart';
import 'package:mvvm_tutorial_one_beforewecode/core/contracts/ui/the_view.dart';

class DynamicListView extends TheView<TutorialViewModel> {
  const DynamicListView(TutorialViewModel viewModel)
      : super(viewModel, const Key("TutorialView"));

  @override
  Widget buildWithViewModel(BuildContext context, TutorialViewModel viewModel) {
    return ViewModelProvider<TutorialViewModel>(
      viewModel: viewModel,
      child: DynamicListViewScreen(viewModel, handleRefresh),
    );
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
    final tabs = <Tab>[];
    final widgets = <Widget>[];
    final sectionCount = viewModel.sectionCount();

    if (sectionCount == 0) {
      tabs.add(
        const Tab(
          text: "",
        ),
      );
      widgets.add(
        const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      for (int i = 0; i < sectionCount; i++) {
        tabs.add(Tab(
          text: viewModel.infoForSection(i).title,
        ));
      }

      for (int i = 0; i < sectionCount; i++) {
        final scrollController = ScrollController(keepScrollOffset: false);
        widgets.add(getList(i, scrollController, tabController));
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

  Widget getList(int section, ScrollController scrollController,
      TabController tabController) {
    return ListWithRefreshIndicator(
      section: section,
      scrollController: scrollController,
      tabController: tabController,
      handleRefresh: handleRefresh,
    );
  }
}

class ListWithRefreshIndicator extends StatelessWidget {
  final int section;
  final ScrollController scrollController;
  final TabController tabController;
  final HandleRefresh handleRefresh;

  const ListWithRefreshIndicator(
      {super.key,
      required this.section,
      required this.scrollController,
      required this.tabController,
      required this.handleRefresh});

  @override
  Widget build(BuildContext context) {
    final viewModel =
        ViewModelProvider.of<TutorialViewModel>(context).viewModel;
    final item = ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(18),
      itemCount: viewModel.cardCount(section),
      itemBuilder: (BuildContext context, int index) {
        final card = viewModel.getCardAtIndex(section, index);
        if (card is SectionCard) {
          return HeaderWithOptionalImageTile(
            navigator: viewModel.coordinator,
            imageURL: card.imageUrl,
            key: Key("HeaderWithOptionalImageTile$section-$index"),
            navigationIdentifier: NavigationAppIdentifiers.form,
          );
        } else if (card is RegularTextCard) {
          final widthFactor = min(500 / MediaQuery.of(context).size.width, 1.0);
          return TextTile(
            key: Key("TextTile$section-$index"),
            textCard: card,
            widthFactor: widthFactor,
          );
        }
        return Text("Unhandled card type ${card.runtimeType}");
      },
    );
    final refreshIndicator =
        RefreshIndicator(onRefresh: handleRefresh, child: item);
    return refreshIndicator;
  }
}
