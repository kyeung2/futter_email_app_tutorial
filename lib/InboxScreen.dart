import 'package:emailapp/MessageList.dart';
import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {},
          )
        ],
        bottom: TabBar(
          tabs: <Widget>[Tab(text: "Important"), Tab(text: "Other")],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          MessageList(status: "important"),
          MessageList(status: "other"),
        ],
      ),
    );
  }
}
