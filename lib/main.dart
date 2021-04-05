import 'package:flutter/material.dart';
import 'package:usefullpayment/ui/widget/tab_bar_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBarWidget(),
    );
  }
}