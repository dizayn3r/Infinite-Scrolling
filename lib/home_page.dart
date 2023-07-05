import 'package:flutter/material.dart';
import 'package:infinite_scrolling/product_screen.dart';

import 'gridview.dart';
import 'listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Infinite Scrolling"),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.grid_on_rounded),
              ),
              Tab(
                icon: Icon(Icons.list_rounded),
              ),
              Tab(
                icon: Icon(Icons.post_add_rounded),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InfiniteGridView(),
            InfiniteListView(),
            ProductScreen(),
          ],
        ),
      ),
    );
  }
}
