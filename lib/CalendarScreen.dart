import 'package:emailapp/AppDrawer.dart';
import 'package:emailapp/mutable_inheritedWidget/Counter.dart';
import 'package:emailapp/mutable_inheritedWidget/FabButton.dart';
import 'package:emailapp/mutable_inheritedWidget/UglyProvider.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
      ),
      drawer: AppDrawer(),
      body: Counter(),
      floatingActionButton: FabButton(),
    );
  }
}
