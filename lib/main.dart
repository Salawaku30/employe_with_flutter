import 'package:employee/core.dart';
import 'package:employee/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBRKZ4BYzm3cK02b8_H2pPR6NvVzqaFp3c",
          appId: "1:709533050259:android:642b244d5aefbaca8b3466",
          messagingSenderId: "709533050259",
          projectId: "employee-f7b3b"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Home(),
    );
  }
}
