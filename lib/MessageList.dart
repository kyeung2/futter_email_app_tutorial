import 'package:emailapp/ComposeButton.dart';
import 'package:emailapp/Message.dart';
import 'package:emailapp/MessageCompose.dart';
import 'package:emailapp/MessageDetail.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> messages;

  @override
  void initState() {
    super.initState();
    messages = Message.browse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              var _messages = Message.browse();
              setState(() {
                messages = _messages;
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: messages,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            // stats of data
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              // react to errors
              if (snapshot.hasError) {
                return Text("There was an error: ${snapshot.error}");
              }
              final messages = snapshot.data;
              return ListView.separated(
                itemCount: messages.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (BuildContext context, int index) {
                  Message message = messages[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('KY'),
                      backgroundColor: Color.fromARGB(100, 255, 0, 0),
                    ),
                    title: Text(message.subject),
                    subtitle: Text(
                      message.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => MessageDetail(message.subject, message.body)
                      ));
                    },
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: ComposeButton(),
    );
  }
}
