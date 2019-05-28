import 'package:emailapp/AppDrawer.dart';
import 'package:emailapp/ContactManager.dart';
import 'package:emailapp/model/Contact.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  ContactManager manager = ContactManager();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Contacts"),
            actions: <Widget>[
              Chip(
                label: StreamBuilder<int>(
                  stream: manager.contactCounter,
                  builder: (context, snapshot) {
                    return Text(
                      (snapshot.data ?? 0).toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                backgroundColor: Colors.red,
              ),
              Padding(
                padding: EdgeInsets.only(right: 16),
              )
            ],
          ),
          drawer: AppDrawer(),
          body: StreamBuilder<List<Contact>>(
            stream: manager.contactListNow,
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
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        Contact _contact = contacts[index];
                        return ListTile(
                          title: Text(_contact.name),
                          subtitle: Text(_contact.email),
                          leading: CircleAvatar(),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: contacts.length);
              }
            },
          )),
      length: 2,
    );
  }
}
