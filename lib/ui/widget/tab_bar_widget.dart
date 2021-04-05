import 'package:flutter/material.dart';

import '../view/create_view.dart';
import '../view/scan_view.dart';

class TabBarWidget extends StatelessWidget {
  final String _appBarTitle = "Cafe Scanner";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _tabAppBar(),
        body: _tabBar(),
      ),
    );
  }

  _tabBar() {
    return TabBarView(
      children: [
        ScanView(),
        CreateView(),
      ],
    );
  }

  _tabAppBar() {
    return AppBar(
      bottom: TabBar(
        tabs: <Widget>[
          _tabScanner(),
          _tabCreate(),
        ],
      ),
      title: Text(_appBarTitle),
    );
  }

  _tabCreate() {
    return Tab(
      icon: Icon(Icons.create),
    );
  }

  _tabScanner() {
    return Tab(
      icon: Icon(Icons.scanner),
    );
  }
}
