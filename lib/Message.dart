import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

part 'Message.g.dart';

@JsonSerializable()
class Message {
  final String subject;
  final String body;
  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  static Future<List<Message>> browse() async {
    // final content = await rootBundle.loadString('data/messages.json');
    http.Response response =
    await http.get('http://www.mocky.io/v2/5cd413ce350000df2d7a52e5');

    await Future.delayed(Duration(seconds: 3));

    List collection = json.decode(response.body);
    List<Message> _messages =
    collection.map((json) => Message.fromJson(json)).toList();

    return _messages;
  }
}