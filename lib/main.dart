import 'package:chat_app/pages/auth/ui/sign_in_page.dart';

import 'package:chat_app/pages/home/ui/home_page.dart';
import 'package:chat_app/utils/preference_utils.dart';

import 'package:flutter/material.dart';

Widget defualt = const SignInPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // share preferences
  await PreferenceUtils.init();
  final token = PreferenceUtils.getString("token");
  if (token.isNotEmpty) {
    defualt = const HomePage();
  } else {
    defualt = const SignInPage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: defualt,
    );
  }
}
