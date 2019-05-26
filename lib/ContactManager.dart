import 'dart:async';
import 'dart:core';

List<String> CONTACTS = ["User 1", "User 2", "User 3", "User 4"];

class ContactManager {
  // async* makes a stream out of thin air
  Stream<List<String>> get contactListNow async* {
    for (var i = 0; i < CONTACTS.length; i++) {
      await Future.delayed(Duration(seconds: 1));
      // yield puts something on the stream
      yield CONTACTS.sublist(0, i + 1);
    }
  }

  final StreamController<int> _contactCounter = StreamController<int>();
  Stream<int> get contactCounter => _contactCounter.stream;

  ContactManager() {
    // listing to the first stream. Put the length value into second stream via the StreamController
    contactListNow.listen((list) => _contactCounter.add(list.length));
  }
}
