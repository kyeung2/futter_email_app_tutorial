import 'package:emailapp/model/Contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactService {
  static String _url = "http://fip.zaiste.net/contacts";

  static Future<List<Contact>> browse({filter}) async {
    http.Response response = await http.get("$_url?q=$filter");
    String content = response.body;
    await Future.delayed(Duration(seconds: 2));
    List collection = json.decode(content);
    Iterable<Contact> _contacts = collection.map((_) => Contact.fromJson(_));

    return _contacts.toList();
  }
}