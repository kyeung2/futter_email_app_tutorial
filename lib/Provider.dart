import 'package:emailapp/ContactManager.dart';
import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  // generics/parameterised types
  // Dart types are reification, carries on at runtime.
  // Java type erasure, parameterised at runtime doesn't have it.
  final T data;

  Provider({Key key, Widget child, this.data}) : super(key: key, child: child);

  static T of<T>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    return (context.inheritFromWidgetOfExactType(type) as Provider).data;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // sine we will never replace this widget. Immutable + streams approach
    return false;
  }
}
