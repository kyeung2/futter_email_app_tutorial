import 'package:emailapp/ContactManager.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final ContactManager data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static ContactManager of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // sine we will never replace this widget. Immutable + streams approach
    return false;
  }
}
