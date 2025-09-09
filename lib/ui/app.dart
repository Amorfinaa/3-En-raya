
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/login/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayo 3 En Raya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}