import 'package:emailapp/model/Contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactService {
  static String url = "https://jsonplaceholder.typicode.com/users";

  static Future<List<Contact>> browse({filter}) async {
    http.Response response = await http.get(url);
    String content = response.body;
    List collection = json.decode(content);
    Iterable<Contact> _contacts = collection.map((_) => Contact.fromJson(_));

    if (filter != null && filter.isNotEmpty) {
      _contacts = _contacts.where((contact) =>
          contact.name.toLowerCase().contains(filter.toString().toLowerCase()));
    }
    return _contacts.toList();
  }
}