import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: TabBar(
      controller: tabController,
      unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
      labelStyle: Theme.of(context).textTheme.bodyLarge,
      indicatorSize: TabBarIndicatorSize.label,
      dividerHeight: 0,
      indicatorWeight: 4,
      indicator: UnderlineTabIndicator(
        // Adds a line under the selected tab
        borderSide: BorderSide(
          width: 3.5, // Thickness of the line
          color: Theme.of(context).colorScheme.primary, // Color of the line
        ),
        insets: EdgeInsets.symmetric(horizontal: -8), // Padding of the line
      ),
      tabs: [Text("Chats"), Text("Groups"), Text("Calls")],
    ),
  );
}
