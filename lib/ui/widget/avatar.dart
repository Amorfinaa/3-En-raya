
import 'package:flutter/material.dart';

class MiAvatar extends StatelessWidget {
  const MiAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return CircleAvatar(
        radius: 50, // Tamaño del círculo
        backgroundImage: AssetImage("assets/images/blup.PNG"),
      );
  }
}