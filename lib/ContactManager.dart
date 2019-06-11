import 'dart:async';
import 'dart:core';

import 'package:emailapp/model/Contact.dart';
import 'package:emailapp/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';
class ContactManager {

  Stream<List<Contact>> browse$({query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  final BehaviorSubject<int> _contactCounter = BehaviorSubject<int>();

  Stream<int> get count$ => _contactCounter.stream;

  ContactManager() {
    // listing to the first stream. Put the length value into second stream via the StreamController
    browse$().listen((list) => _contactCounter.add(list.length));
  }
}
