import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/juego/jueguito.dart';
import 'package:flutter_application_1/ui/widget/avatar.dart';
import 'package:flutter_application_1/ui/widget/cajatexto.dart';
import 'package:flutter_application_1/ui/widget/snowani.dart';
import 'package:flutter_application_1/audio/controladorauido.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController txtUser = TextEditingController();
  final TextEditingController txtPassw = TextEditingController();

  //Controlador de Audio
  final AudioController audioController = AudioController();

  //CONtroles de Audio
  @override
  void initState() {
    super.initState();
    // inicializa
    audioController.init();
  }

  @override
  void dispose() {
    audioController.dispose();
    super.dispose();
  }
  //==================

  void validar() {
    String user = txtUser.text.trim();
    String pass = txtPassw.text.trim();

    if (user == 'admin' && pass == '1234') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyJueguito()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Usuario o contraseña inválido"), backgroundColor: Colors.red, duration: Duration(seconds: 2)));
    }
  }

  //actualiza musica
  void toggleMusic() async {
    await audioController.toggleMusic();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double tamPantalla = MediaQuery.of(context).size.width;
    double padTamHor = tamPantalla * 0.10;
    double padTamVer = tamPantalla * 0.03;

    return Scaffold(
      backgroundColor: Colors.blueGrey,

      body: Stack(
        children: [
          IgnorePointer(
            ignoring: true,
            child: SnowAnimation(snowflakeCount: 50, snowflakeColor: Colors.white.withValues(alpha: 0.8), child: Container()),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MiAvatar(),
                const Text(
                  "SAYO TIC TAC TOE",
                  style: TextStyle(color: Colors.white70, fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const Text(
                  "Alvaro Jose V.B",
                  style: TextStyle(color: Colors.white70, fontSize: 14, fontStyle: FontStyle.italic),
                ),
                MisTextos(padTamHor: padTamHor, padTamVer: padTamVer, passw: false, texto: 'Ingrese el Usuario', controlador: txtUser),
                MisTextos(padTamHor: padTamHor, padTamVer: padTamVer, passw: true, texto: 'Ingrese Contraseña', controlador: txtPassw),

                const Text(
                  "Usuario: admin  -  Contraseña: 1234",
                  style: TextStyle(color: Colors.white70, fontSize: 14, fontStyle: FontStyle.italic),
                ),

                //Validar
                ElevatedButton(
                  onPressed: validar,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(180, 55), backgroundColor: Colors.white.withValues(alpha: 0.3), foregroundColor: Colors.blueGrey, shadowColor: Colors.transparent),
                  child: const Text('Ingresar'),
                ),

                //musica
                IconButton(iconSize: 40, color: audioController.isMusicPlaying ? Colors.blueAccent : Colors.grey, icon: Icon(audioController.isMusicPlaying ? CupertinoIcons.pause_circle_fill : CupertinoIcons.play_circle_fill), onPressed: toggleMusic),

                const Text(
                  "Boton Experimental - clic para musica \nNo funciona si inicias el juego y regresas",
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
