import 'dart:async';
import 'dart:core';

import 'package:emailapp/Observer.dart';
import 'package:emailapp/model/Contact.dart';
import 'package:emailapp/service/ContactService.dart';
import 'package:rxdart/rxdart.dart';

class ContactManager {
  /**
   * RX extentions
   * Stream = dart, Observable is the RX abstraction, same thing
   *
   * StreamController = dart. different subjects
   */

  // stream controller = subjects in RX

  // PublishSubject: can subscribe to streams multiple times, a regular StreamController only once.
  final PublishSubject<String> _filterSubject = PublishSubject<String>();

  // BehaviorSubject: small memory, can remember last seen value. No waiting!
  final PublishSubject<int> _countSubject = PublishSubject<int>();
  final PublishSubject<List<Contact>> _collectionSubject =
      PublishSubject<List<Contact>>();

  // 1. manager only receives data through this sink
  Sink<String> get inFilter => _filterSubject.sink;

  // 2. exposes stream 1 to provide data
  Observable<List<Contact>> get browse$ => _collectionSubject.stream;

  // 3. exposes stream 2 to provide data
  Observable<int> get count$ => _countSubject.stream;

  ContactManager() {
    _filterSubject
        // back pressure mechanism to slow down the number of events going to the ContactService.
        .debounceTime(Duration(milliseconds: 500))
        // ensures that the ordering of the operations are applied and returned in the correct order
        // async* == stream generator
        .switchMap((filter) async* {
      yield await ContactService.browse(filter: filter);
    }).listen((contacts) async {
      // react to the stream/sink but initiating a browse then adding to another
      // stream _collectionSubject
      _collectionSubject.add(contacts);
    });

    // [1 2,4]

    // listing to the first stream. Put the length value into second stream via the StreamController
    _collectionSubject.listen((list) => _countSubject.add(list.length));
  }

  void dispose() {
    _countSubject.close();
    _filterSubject.close();
  }
}
