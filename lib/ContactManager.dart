import 'dart:async';
import 'dart:core';

import 'package:emailapp/model/Contact.dart';
import 'package:emailapp/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {

  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();
  final PublishSubject<List<Contact>> _collectionSubject = PublishSubject();


  // 1. manager only receives data through this sink
  Sink<String> get inFilter => _filterSubject.sink;
  // 2. exposes stream 1 to provide data
  Stream<List<Contact>> get browse$ => _collectionSubject.stream;
  // 3. exposes stream 2 to provide data
  Stream<int> get count$ => _countSubject.stream;

  ContactManager() {
    _filterSubject.stream.listen((filter) async {
      // react to the stream/sink but initiating a browse then adding to another
      // stream _collectionSubject
      var contacts = await ContactService.browse(filter: filter);
      _collectionSubject.add(contacts);
    });

    // listing to the first stream. Put the length value into second stream via the StreamController
    _collectionSubject.listen((list) => _countSubject.add(list.length));
  }

  void dispose(){
    _countSubject.close();
    _filterSubject.close();
  }
}
