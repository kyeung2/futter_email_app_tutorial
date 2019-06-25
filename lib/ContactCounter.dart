import 'package:emailapp/manager/ContactManager.dart';
import 'package:emailapp/Observer.dart';
import 'package:emailapp/Provider.dart';
import 'package:flutter/material.dart';

class ContactCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of(context).fetch(ContactManager);
    return Chip(
      label: Observer<int>(
        stream: manager.count$,
        onSuccess: (BuildContext context, int data)
          => Text(
            // ?? means "if null"
            (data ?? 0).toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
      ),
      backgroundColor: Colors.red,
    );
  }
}
