import 'dart:async';

import 'package:flutter/material.dart';

const tituloBtnIniciar = 'INICIAR';
const tituloBtnParar = 'PARAR';
const tituloBtnResetar = 'RESETAR';

const assetLogo = 'assets/images/cronometro.png';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int seconds = 0;
  bool isPause = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Inicializa uma funcao a ser executada periodicamente monitorando o cronometro
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Se não esta pausado incrementa os segundos
      if (!isPause) {
        setState(() {
          seconds++;
        });
      }
    });
  }

  @override
  void dispose() {
    // Desalocao recurso
    timer.cancel();
    super.dispose();
  }

  void initialize() {
    setState(() {
      isPause = false;
    });
  }

  void pause() {
    setState(() {
      isPause = true;
    });
  }

  void reset() {
    setState(() {
      isPause = true;
      seconds = 0;
    });
  }

  String getCronometer() {
    final sec = (seconds % 60).round();
    final min = (seconds / 60).floor();
    final hours = (seconds / 3600).round();

    return '${hours.toString().padLeft(2, '0')}'
        ':${min.toString().padLeft(2, '0')}'
        ':${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cronometro'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  assetLogo,
                  width: MediaQuery.of(context).size.width * 0.50,
                ),
              ),
              Text(
                getCronometer(),
                style: const TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 44,
                  letterSpacing: 2,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: initialize,
                    label: const Text(tituloBtnIniciar),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.pause),
                    onPressed: pause,
                    label: const Text(tituloBtnParar),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.reset_tv),
                    onPressed: reset,
                    label: const Text(tituloBtnResetar),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
