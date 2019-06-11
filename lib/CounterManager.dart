import 'package:rxdart/rxdart.dart';

class CounterManager {
  BehaviorSubject<int> _counter = BehaviorSubject<int>.seeded(0);

  // convention to have a $ at the end for a stream
  Stream<int> get counter$ => _counter.stream;

  int get _current => _counter.value;

  void increment() => _counter.add(_current + 1);

  void decrement() => _counter.add(_current - 1);
}
