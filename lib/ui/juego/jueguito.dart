import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widget/snowani.dart';
import 'package:flutter_application_1/audio/controladorauido.dart';
import 'package:flutter/cupertino.dart';

class MyJueguito extends StatefulWidget {
  const MyJueguito({super.key});

  @override
  State<MyJueguito> createState() => _MyJueguitoState();
}

class _MyJueguitoState extends State<MyJueguito> {
  String jugador = "X";
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

  void toggleMusic() async {
    await audioController.toggleMusic();
    setState(() {});
  }
  //==================

  //JUEGO===========================

  List<List<String>> tablero = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "],
  ];

  //Estado de jugador
  void actJugador() {
    jugador == 'X' ? jugador = 'O' : jugador = 'X';
    setState(() {});
  }

  void marcarCasilla(int fila, int col) {
    if (tablero[fila][col] == " ") {
      setState(() {
        tablero[fila][col] = jugador;
        verificarGanador();
        actJugador();
      });
    }
  }

  void verificarGanador() {
    String? ganador;

    for (int i = 0; i < 3; i++) {
      if (tablero[i][0] != " " && tablero[i][0] == tablero[i][1] && tablero[i][1] == tablero[i][2]) {
        ganador = tablero[i][0];
      }
      if (tablero[0][i] != " " && tablero[0][i] == tablero[1][i] && tablero[1][i] == tablero[2][i]) {
        ganador = tablero[0][i];
      }
    }

    if (tablero[0][0] != " " && tablero[0][0] == tablero[1][1] && tablero[1][1] == tablero[2][2]) {
      ganador = tablero[0][0];
    }
    if (tablero[0][2] != " " && tablero[0][2] == tablero[1][1] && tablero[1][1] == tablero[2][0]) {
      ganador = tablero[0][2];
    }

    if (ganador != null) {
      mostrarDialogo("¡Ganó $ganador!");
      return;
    }

    bool tableroLleno = true;
    for (var fila in tablero) {
      if (fila.contains(" ")) {
        tableroLleno = false;
        break;
      }
    }
    if (tableroLleno) {
      mostrarDialogo("¡Empate!");
    }
  }

  //modulo de reinicio
  void mostrarDialogo(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              reiniciar();
              Navigator.pop(context);
            },
            child: const Text("Reiniciar"),
          ),
        ],
      ),
    );
  }

  void reiniciar() {
    tablero = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "],
    ];
    jugador = "X";
    setState(() {});
  }

  //============================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(title: const Text('Sayo 3 en Raya')),
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: true,
            child: SnowAnimation(snowflakeCount: 50, snowflakeColor: Colors.white.withValues(alpha: 0.7), child: Container()),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //turnos
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Turno del Jugador: $jugador",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),

                //contenedor- tablero
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => marcarCasilla(0, 0),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[0][0], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                          ElevatedButton(
                            onPressed: () => marcarCasilla(0, 1),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[0][1], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                          ElevatedButton(
                            onPressed: () => marcarCasilla(0, 2),
                            style: ElevatedButton.styleFrom( minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[0][2], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => marcarCasilla(1, 0),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[1][0], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                          ElevatedButton(
                            onPressed: () => marcarCasilla(1, 1),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[1][1], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                          ElevatedButton(
                            onPressed: () => marcarCasilla(1, 2),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[1][2], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => marcarCasilla(2, 0),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[2][0], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                          ElevatedButton(
                            onPressed: () => marcarCasilla(2, 1),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[2][1], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                          ElevatedButton(
                            onPressed: () => marcarCasilla(2, 2),
                            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 80), backgroundColor: Colors.white.withValues(alpha: 0.2), shadowColor: Colors.transparent,),
                            child: Text(tablero[2][2], style: const TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
