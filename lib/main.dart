import 'package:flutter/material.dart';
import 'package:projet_testosterone/screens/last_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projet Testostérone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LastPage(
        nameUser: "Sinami Amine",
      ),
    );
  }
}
