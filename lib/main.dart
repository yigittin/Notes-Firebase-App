import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Notes',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
          scaffoldBackgroundColor: Color(0xff070706),
        ),
        home: LoginPage());
  }
}
