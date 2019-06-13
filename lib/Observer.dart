import 'dart:async';

import 'package:flutter/material.dart';

class Observer<T> extends StatelessWidget {
  final Function onError;
  @required
  final Function onSuccess;
  @required
  final Stream<T> stream;
  final Function onWaiting;

  const Observer({this.onError, this.onSuccess, this.stream, this.onWaiting});

  Function get _defaultOnWaiting =>
      (context) => Center(child: CircularProgressIndicator());

  Function get _defaultOnError => (context, error) => Text(error);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasError) {
            var error = snapshot.error;
            return onError != null
                ? onError(context, error)
                : _defaultOnError(context, error);
          }
          if (snapshot.hasData) {
            T data = snapshot.data;
            return onSuccess(context, data);
          } else {
            return onWaiting != null
                ? onWaiting(context)
                : _defaultOnWaiting(context);
          }
        });
  }
}
