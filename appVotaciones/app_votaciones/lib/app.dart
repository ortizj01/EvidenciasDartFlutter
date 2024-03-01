import 'package:flutter/material.dart';

class AppVotaciones extends StatefulWidget {
  const AppVotaciones({super.key});

  @override
  State<AppVotaciones> createState() => _AppVOtacionesState();
}

int candidato1 = 0;
int candidato2 = 0;
int candidato3 = 0;
int totalVotos = 0;
double porcentaje1 = 0;
double porcentaje2 = 0;
double porcentaje3 = 0;

class _AppVOtacionesState extends State<AppVotaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'App Votaciones',
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Votos C1: $candidato1 | Porcentaje: $porcentaje1'),
            Text('Votos C2: $candidato2 | Porcentaje: $porcentaje2'),
            Text('Votos C3: $candidato3 | Porcentaje: $porcentaje3')
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                  child: FloatingActionButton(
                backgroundColor: Colors.amber,
                child: const Text('Candidato 1'),
                onPressed: () {
                  candidato1++;
                  porcentaje1 = (candidato1 / totalVotos) * 100;
                  setState(() {});
                },
              )),
              Expanded(
                  child: FloatingActionButton(
                backgroundColor: Colors.amber,
                child: const Text('Candidato 2'),
                onPressed: () {
                  candidato2++;
                  porcentaje2 = (candidato2 / totalVotos) * 100;
                  setState(() {});
                },
              )),
              Expanded(
                  child: FloatingActionButton(
                backgroundColor: Colors.amber,
                child: const Text('Candidato 3'),
                onPressed: () {
                  candidato3++;
                  porcentaje3 = (candidato3 / totalVotos) * 100;
                  setState(() {});
                },
              )),
            ],
          ),
        ),
      ),

      // floatingActionButton: Row(
      //   children: [
      //     FloatingActionButton(
      //         backgroundColor: Colors.amber,
      //         child: const Text('Votar1'),
      //         onPressed: () {
      //           candidato1++;
      //           setState(() {});
      //         }),
      //     Expanded(
      //         child: FloatingActionButton(
      //       child: const Text('Votar2'),
      //       onPressed: () {
      //         candidato2++;
      //         setState(() {});
      //       },
      //     ))
      //   ],
      // ),
    );
  }
}
