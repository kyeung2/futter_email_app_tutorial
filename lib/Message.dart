import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'Message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;

  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  static Future<List<Message>> browse({status = "important"}) async {
    // final content = await rootBundle.loadString('data/messages.json');

    String url = status == 'important'
        ? "http://www.mocky.io/v2/5ce3e6773100007800742a1b"
        : 'http://www.mocky.io/v2/5cd413ce350000df2d7a52e5';

    http.Response response = await http.get(url);

    await Future.delayed(Duration(seconds: 1));

    List collection = json.decode(response.body);
    List<Message> _messages =
        collection.map((json) => Message.fromJson(json)).toList();

    return _messages;
  }
}
