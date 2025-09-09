import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/app.dart';
import 'package:flutter_application_1/audio/controladorauido.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioController().init();
  runApp(const MyApp());
}