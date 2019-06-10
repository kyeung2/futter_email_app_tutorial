
import 'package:emailapp/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactListBuilder extends StatelessWidget {
  final Function builder;
  final Stream stream;

  const ContactListBuilder({this.builder, this.stream});

  @override
  Widget build(BuildContext context) {
    // he forgot to do this in the episode, will be interesting to see how he resolves this.
    return StreamBuilder<List<Contact>>(
      stream: stream,
      builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        switch (snapshot.connectionState) {
          // stats of data
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            List<Contact> contacts = snapshot.data;
            return builder(context, contacts);
        }
      },
    );
  }
}
