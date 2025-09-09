import 'package:flutter/material.dart';

class MisTextos extends StatelessWidget {
  const MisTextos({super.key, required this.padTamHor, required this.padTamVer, required this.passw, required this.texto, required this.controlador});

  final double padTamHor;
  final double padTamVer;
  final bool passw;
  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padTamHor, vertical: 4.0),

      child: TextField(
        controller: controlador,
        obscureText: passw,

        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: texto,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.3),
          border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
