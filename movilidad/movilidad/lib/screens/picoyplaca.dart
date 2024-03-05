import 'package:flutter/material.dart';

class PicoYPlacaScreen extends StatefulWidget {
  const PicoYPlacaScreen({super.key});

  @override
  State<PicoYPlacaScreen> createState() => _PicoYPlacaScreenState();
}

class _PicoYPlacaScreenState extends State<PicoYPlacaScreen> {
  TextEditingController numPicoYPlaca = TextEditingController();
  String mensaje = '';

  void mostrarPYP() {
    int num = int.parse(numPicoYPlaca.text);
    if (num == 0 || num == 1) {
      mensaje = 'Lunes';
    } else if (num == 2 || num == 3) {
      mensaje = 'Martes';
    } else if (num == 4 || num == 5) {
      mensaje = 'Miercoles';
    } else if (num == 6 || num == 7) {
      mensaje = 'Jueves';
    } else if (num == 8 || num == 9) {
      mensaje = 'Viernes';
    }
    setState(() {
      mensaje;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pico Y Placa'),
      ),
      body: Center(
          child: Container(
        width: 400,
        height: 350,
        color: Colors.grey,
        child: Column(
          children: [
            TextField(
              controller: numPicoYPlaca,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Ultimo numero de placa'),
              maxLength: 1,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: mostrarPYP, child: const Text('Buscar PYP')),
            const SizedBox(
              height: 15,
            ),
            Text('pyp: $mensaje')
          ],
        ),
      )),
    );
  }
}
