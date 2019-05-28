import 'package:emailapp/model/Contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactService {
  static String url = "https://jsonplaceholder.typicode.com/users";

  static Future browse() async {
    http.Response response = await http.get(url);


    await Future.delayed(Duration(seconds: 3));
    String content = response.body;
    List collection = json.decode(content);
    List<Contact> _contacts =
        collection.map((json) => Contact.fromJson(json)).toList();

    return _contacts;
  }
}



// > dart lib/service/ContactService.dart
//void main() async {
//  List result = await ContactService.browse();
//  print(result);
//}
