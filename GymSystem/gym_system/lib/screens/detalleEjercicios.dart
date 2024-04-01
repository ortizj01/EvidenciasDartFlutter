import 'package:flutter/material.dart';
import 'package:gym_system/screens/listar_ejercicios.dart';

class DetallesEjercicioScreen extends StatelessWidget {
  final Ejercicio ejercicio;

  const DetallesEjercicioScreen({super.key, required this.ejercicio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Ejercicio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${ejercicio.nombreEjercicio}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Repeticiones: ${ejercicio.repeticionesEjercicio}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Descripción: ${ejercicio.descripcionEjercicio}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
