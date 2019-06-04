import 'package:emailapp/ContactManager.dart';
import 'package:emailapp/Provider.dart';
import 'package:emailapp/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactListBuilder extends StatelessWidget {
  final String query;
  final Function builder;

  const ContactListBuilder({this.query, this.builder});

  @override
  Widget build(BuildContext context) {
    ContactManager manager = Provider.of(context);

    // he forgot to do this in the episode, will be interesting to see how he resolves this.
    bool hasQuery = query != null && query.isNotEmpty;
    return StreamBuilder<List<Contact>>(
      stream: hasQuery
          ? manager.filteredCollection(query: query)
          : manager.contactListView,
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
