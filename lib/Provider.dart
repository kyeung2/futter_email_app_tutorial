import 'package:emailapp/Overseer.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  // generics/parameterised types
  // Dart types are reification, carries on at runtime.
  // Java type erasure, parameterised at runtime doesn't have it.
  final Overseer data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static Overseer of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).data;
  }


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // sine we will never replace this widget. Immutable + streams approach
    return false;
  }
}
