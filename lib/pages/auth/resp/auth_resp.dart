import 'dart:convert';

import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/utils/preference_utils.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthResp {
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    const uri = 'https://chat-server-7pyb.onrender.com/user/register';
    try {
      print('Sign Up');
      final response = await http.post(
        Uri.parse(uri),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final UserModel user = UserModel.fromJson(jsonDecode(response.body));
        print(user.token);
        // saving token for share preference
        PreferenceUtils.setString("token", user.token);
        return user;
      } else {
        print('Failed to sign up: ${response.statusCode}');
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$LOCAL/user/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final UserModel user = UserModel.fromJson(jsonDecode(response.body));
        // saving token for share preference
        PreferenceUtils.setString("token", user.token);
        PreferenceUtils.setString("id", user.id);
        return user;
      } else {
        // print('Failed to sign In: ${response.statusCode}');
        throw Exception('Failed to sign In');
      }
    } catch (e) {
      //print(e.toString());
      rethrow;
    }
  }
}
