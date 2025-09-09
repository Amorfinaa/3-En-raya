import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widget/avatar.dart';

class MyPagina extends StatefulWidget {
  const MyPagina({super.key});

  @override
  State<MyPagina> createState() => _MyPaginaState();
}

class _MyPaginaState extends State<MyPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mi App Movil'),
        ),
        body:  Center(
          child: Column(
            children: [
              MiAvatar(),
              Text('Hola Mundo...'),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Regresar'))
            ],
          ),
        ),
      );
  }
}