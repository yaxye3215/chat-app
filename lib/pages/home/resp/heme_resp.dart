import 'dart:convert';

import 'package:chat_app/models/contacts.dart';
import 'package:chat_app/utils/preference_utils.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class HomeResponse {
  Future<List<Contacts>> getUsers() async {
    try {
      // Retrieve the token
      String? token = PreferenceUtils.getString("token");
      if (token.isEmpty) {
        throw Exception('Token is null or empty');
      }
      final response = await http.get(
        Uri.parse("$LOCAL/user/allcontacts"),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    //  print(response.body);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        List<dynamic> contacts = json.decode(response.body);
    //    print('Number of users: ${contacts.length}');
        return contacts.map((i) => Contacts.fromJson(i)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
   //   print('Error: $e');
      rethrow;
    }
  }
}
