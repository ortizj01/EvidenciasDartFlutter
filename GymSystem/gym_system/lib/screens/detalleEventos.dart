import 'package:flutter/material.dart';
import 'package:gym_system/screens/listar_eventos.dart';

class DetallesEvento extends StatelessWidget {
  final Evento evento;

  const DetallesEvento({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Evento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Servicio: ${evento.serviciosAgenda}'),
            Text('Fecha de Inicio: ${evento.fechaInicio}'),
            Text('Fecha de Fin: ${evento.fechaFin}'),
            Text('Hora de Inicio: ${evento.horaInicio}'),
            Text('Hora de Fin: ${evento.horaFin}'),
            Text('Empleado: ${evento.nombreEmpleado}'),
            Text('Descripción: ${evento.descripcionAgenda}'),
          ],
        ),
      ),
    );
  }
}
