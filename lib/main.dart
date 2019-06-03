import 'package:emailapp/App.dart';
import 'package:emailapp/ContactManager.dart';
import 'package:emailapp/Provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(EmailApp());

class EmailApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: ContactManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
        home: App(),
      ),
    );
  }
}
