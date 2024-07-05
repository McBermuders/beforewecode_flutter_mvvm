import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class UITabsDatasourceInterface {
  double calculateSize(int selectedTab, List<bool> expandedSections);

  Widget itemBuilderForTabBar(int primarySectionCounter, BuildContext context);

  String expandableTabSectionTitle(
      int primarySectionIndex, int sectionIndexIndex);

  Widget itemBuilderForExpandable(int primarySectionCounter,
      int expandableTilesCounter, int listIndex, BuildContext context);

  int getPrimaryCount();

  int getSectionsCount(int primarySection);

  int getSectionContentCount(int primarySection, int sectionIndex);
}

abstract class UITabsDelegateInterface {}

class UITabController extends StatelessWidget implements TickerProvider {
  final UITabsDatasourceInterface uiTabsImplement;
  final UITabsDelegateInterface? uiTabsDelegateInterface;

  const UITabController(
      {required this.uiTabsImplement,
      this.uiTabsDelegateInterface,
      required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(
        vsync: this,
        length: uiTabsImplement.getPrimaryCount(),
        initialIndex: 0);
    return DefaultTabController(
      length: tabController.length,
      child: UITabs(
        tabController: tabController,
        uiTabsImplement: uiTabsImplement,
      ),
    );
  }

  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }
}

class UITabs extends StatefulWidget {
  final TabController tabController;
  final UITabsDatasourceInterface uiTabsImplement;

  const UITabs(
      {Key? key, required this.tabController, required this.uiTabsImplement})
      : super(key: key);

  @override
  UITabsState createState() => UITabsState();
}

class UITabsState extends State<UITabs> {
  late int selectedTab;
  late final List<List<bool>> expandedStateForSection;
  late final TabController tabController;
  late final UITabsDatasourceInterface uiTabsImplement;

  UITabsState();

  @override
  initState() {
    super.initState();
    tabController = widget.tabController;
    uiTabsImplement = widget.uiTabsImplement;
    expandedStateForSection = [];
    final primaryCount = uiTabsImplement.getPrimaryCount();
    for (int primarySections = 0;
        primarySections < primaryCount;
        primarySections++) {
      expandedStateForSection.add([]);
      final sections = uiTabsImplement.getSectionsCount(primarySections);
      for (int sectionIndex = 0; sectionIndex < sections; sectionIndex++) {
        expandedStateForSection[primarySections].add(sectionIndex == 0);
      }
    }
    selectedTab = tabController.index;
    tabController.animation?.addListener(tabControllerListener);
  }

  @override
  dispose() {
    tabController.animation?.removeListener(tabControllerListener);
    tabController.dispose();
    super.dispose();
  }

  void tabControllerListener() {
    int currentSelectedTab = tabController.index;
    if (tabController.offset > 0.0 &&
        currentSelectedTab + 1 <= expandedStateForSection.length - 1) {
      double h = uiTabsImplement.calculateSize(
          currentSelectedTab, expandedStateForSection[currentSelectedTab]);
      double h1 = uiTabsImplement.calculateSize(currentSelectedTab + 1,
          expandedStateForSection[currentSelectedTab + 1]);
      if (h < h1) {
        setState(() {
          selectedTab = currentSelectedTab + 1;
        });
      }
    } else if (tabController.offset < 0.0 && currentSelectedTab - 1 >= 0) {
      double h = uiTabsImplement.calculateSize(
          currentSelectedTab, expandedStateForSection[currentSelectedTab]);
      double h1 = uiTabsImplement.calculateSize(currentSelectedTab - 1,
          expandedStateForSection[currentSelectedTab - 1]);
      if (h < h1) {
        setState(() {
          selectedTab = currentSelectedTab - 1;
        });
      }
    } else if (tabController.offset == 0.0) {
      setState(() {
        selectedTab = currentSelectedTab;
      });
    }
  }

  void onExpansionChangedListener(bool expanded, int index) {
    print("onExpansionChangedListener");
    expandedStateForSection[selectedTab][index] = expanded;

    if (expanded) {
      setState(() {});
    }else {
      Future.delayed(const Duration(milliseconds: 150),(){
       setState(() {});
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabsTabBar = [];
    List<Widget> tabViewContentWidgets = [];
    final primarySections = uiTabsImplement.getPrimaryCount();
    //tab bar buttons
    for (int primarySectionCounter = 0;
        primarySectionCounter < primarySections;
        primarySectionCounter++) {
      tabsTabBar.add(Tab(
        child: uiTabsImplement.itemBuilderForTabBar(
            primarySectionCounter, context),
      ));
      List<Widget> expandableTiles = [];
      final sections = uiTabsImplement.getSectionsCount(primarySectionCounter);
      //section tiles
      for (int sectionIndex = 0; sectionIndex < sections; sectionIndex++) {
        final expandableTabSections = uiTabsImplement.getSectionContentCount(
            primarySectionCounter, sectionIndex);
        List<Widget> tabContentWidget = [];
        for (int expandableTabSectionIndex = 0;
            expandableTabSectionIndex < expandableTabSections;
            expandableTabSectionIndex++) {
          tabContentWidget.add(uiTabsImplement.itemBuilderForExpandable(
              primarySectionCounter,
              sectionIndex,
              expandableTabSectionIndex,
              context));
        }
        expandableTiles.add(_UIExpansionTile(
          title: uiTabsImplement.expandableTabSectionTitle(
              primarySectionCounter, sectionIndex),
          initiallyExpanded: expandedStateForSection[primarySectionCounter]
              [sectionIndex],
          children: tabContentWidget,
          onExpansionChanged: (expanded) {
            onExpansionChangedListener(expanded, sectionIndex);
          },
        ));
      }
      tabViewContentWidgets.add(UIMultiTabContentWidget(
        tabContentWidget: expandableTiles,
        key: Key("$primarySectionCounter"),
      ));
    }

    return IntrinsicHeight(
      child: Column(
        children: [
          TabBar(
            isScrollable: tabsTabBar.length > 2,
            controller: tabController,
            tabs: tabsTabBar,
          ),
          const Divider(
            color: Colors.grey,
            thickness: 0,
            height: 0,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              children: tabViewContentWidgets,
            ),
          ),
        ],
      ),
    );
  }
}

class UIMultiTabContentWidget extends StatelessWidget {
  final List<Widget> tabContentWidget;

  const UIMultiTabContentWidget(
      {required this.tabContentWidget, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: tabContentWidget));
  }
}

class _UIExpansionTile extends StatelessWidget {
  final ValueChanged<bool> onExpansionChanged;
  final bool initiallyExpanded;
  final String title;
  final List<Widget> children;

  const _UIExpansionTile(
      {required this.onExpansionChanged,
      required this.title,
      required this.initiallyExpanded,
      required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,),
        child: ListTileTheme(
          dense: true,
          child: ExpansionTile(
            maintainState: true,
            onExpansionChanged: (expanded) {
              onExpansionChanged(expanded);
            },
            title: Text(
              title,
            ),
            initiallyExpanded: initiallyExpanded,
            children: children,
          ),
        ),
      ),
    );
  }
}

//List Cells
class SectionHeaderCell extends StatelessWidget {
  final String title;

  const SectionHeaderCell({
    required Key key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Container(
            decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0, bottom: 4.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UITabsDatasourceHardcodedImpl implements UITabsDatasourceInterface {
  @override
  double calculateSize(int selectedTab, List<bool> expandedSections) {
    double height = 60;
    for (var element in expandedSections) {
      if (element) {
        height += 200;
      }
      height += 60;
    }
    return height;
  }

  @override
  String expandableTabSectionTitle(
      int primarySectionIndex, int sectionIndexIndex) {
    return "Test Title";
  }

  @override
  int getPrimaryCount() {
    return 8;
  }

  @override
  int getSectionContentCount(int primarySection, int sectionIndex) {
    return 2;
  }

  @override
  int getSectionsCount(int primarySection) {
    return 4;
  }

  @override
  Widget itemBuilderForExpandable(int primarySectionCounter,
      int expandableTilesCounter, int listIndex, BuildContext context) {
    return Container(
      color: listIndex == 0 ? Colors.blue : Colors.red,
      height: 100,
    );
  }

  @override
  Widget itemBuilderForTabBar(int primarySectionCounter, BuildContext context) {
    String title = "Unknown";

    switch (primarySectionCounter) {
      case 0:
        title = "General";
        break;
      case 1:
        title = "News";
        break;
      case 2:
        title = "Sport";
        break;
      case 3:
        title = "Politics";
        break;
      case 4:
        title = "General";
        break;
      case 5:
        title = "News";
        break;
      case 6:
        title = "Sport";
        break;
      case 7:
        title = "Politics";
        break;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
      ),
    );
  }
}
