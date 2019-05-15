import 'package:emailapp/ComposeButton.dart';
import 'package:emailapp/Message.dart';
import 'package:emailapp/MessageCompose.dart';
import 'package:emailapp/MessageDetail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

  @override
  State createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> future;
  List<Message> messages;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    future = Message.browse();
    messages = await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              var _messages = await Message.browse();
              setState(() {
                messages = _messages;
              });
            },
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("yeung.kye@pm.me"),
              accountName: Text("Kye Yeung"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://avatars0.githubusercontent.com/u/7465872?s=460&v=4"),
              ),
              otherAccountsPictures: <Widget>[
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Adding new acount"),
                            );
                          });
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.add),
                    ))
              ],
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.inbox),
              title: Text("Inbox"),
              trailing: Chip(
                label: Text("11", style: TextStyle(fontWeight: FontWeight.bold),),
                backgroundColor:  Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.edit),
              title: Text("Draft"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.archive),
              title: Text("Archive"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.paperPlane),
              title: Text("Sent"),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.trash),
              title: Text("Trash"),
            ),
            Divider(),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.cog),
                  title: Text("Settings"),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: future,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MessageDetail(
                                  message.subject, message.body)));
                    },
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: ComposeButton(messages),
    );
  }
}
