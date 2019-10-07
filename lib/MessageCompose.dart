import 'package:emailapp/Message.dart';
import 'package:emailapp/Provider.dart';
import 'package:emailapp/manager/MessageFormManager.dart';
import 'package:flutter/material.dart';
import 'package:rxform/rxform.dart';

class MessageCompose extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MessageFormManager manager = Provider.of(context).fetch(MessageFormManager);
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose New Message"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  title: RxTextField(
                      subscribe: manager.email$,
                      dispatch: manager.setEmail,
                      decoration: InputDecoration(
                        labelText: 'TO',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ))),
              ListTile(
                  title: RxTextField(
                subscribe: manager.subject$,
                dispatch: manager.setSubject,
                decoration: InputDecoration(
                  labelText: 'SUBJECT',
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
              Divider(),
              ListTile(
                title: RxTextField(
                  dispatch: manager.setBody,
                  decoration: InputDecoration(
                      labelText: 'BODY',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                  maxLines: 8,
                ),
              ),
              ListTile(
                  title: StreamBuilder<Object>(
                stream: manager.isFormValid$,
                builder: (context, snapshot) {
                  return RaisedButton(
                    child: Text("SEND"),
                    onPressed: () {
                      if (snapshot.hasData) {
                        Message message = manager.submit();
                        Navigator.pop(context, message);
                      }
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
