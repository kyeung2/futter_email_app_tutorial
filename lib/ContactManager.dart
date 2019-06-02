import 'dart:async';
import 'dart:core';

import 'package:emailapp/model/Contact.dart';
import 'package:emailapp/service/ContactService.dart';

class ContactManager {
  // async* makes a stream out of thin air
  Stream<List<Contact>> get contactListView =>
      Stream.fromFuture(ContactService.browse());

  Stream<List<Contact>> filteredCollection({query}) =>
      Stream.fromFuture(ContactService.browse(query: query));

  final StreamController<int> _contactCounter = StreamController<int>();

  Stream<int> get contactCounter => _contactCounter.stream;

  ContactManager() {
    // listing to the first stream. Put the length value into second stream via the StreamController
    contactListView.listen((list) => _contactCounter.add(list.length));
  }
}
