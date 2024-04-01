import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:gym_system/screens/menu_inferior.dart';
import 'package:http/http.dart' as http;

class Http {
  static String url = "https://apidespliegue.onrender.com/registrarEvento";
  static postEvento(Map evento) async {
    try {
      final res = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(evento));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print('Fallo al insertar datos');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class FormEventos extends StatefulWidget {
  final String token;

  const FormEventos({Key? key, required this.token}) : super(key: key);

  @override
  State<FormEventos> createState() => _FormEventosState();
}

class _FormEventosState extends State<FormEventos> {
  final GlobalKey<FormState> _formEventos = GlobalKey<FormState>();
  String? horaInicioValue;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  String? empleado;
  String? evento;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registra un Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formEventos,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: empleado,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Seleccione un empleado';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    empleado = value;
                    nombreEmpleado = value.toString();
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Juan Ortiz',
                    child: Text('Juan Ortiz'),
                  ),
                  DropdownMenuItem(
                    value: 'Alejandro Builes',
                    child: Text('Alejandro Builes'),
                  ),
                  DropdownMenuItem(
                    value: 'Weimar Lopez',
                    child: Text('Weimar Lopez'),
                  ),
                  DropdownMenuItem(
                    value: 'Johanny',
                    child: Text('Johanny'),
                  ),
                  DropdownMenuItem(
                    value: 'Alexander',
                    child: Text('Alexander'),
                  ),
                ],
                decoration: const InputDecoration(
                  hintText: 'Selecciona un empleado',
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField<String>(
                value: evento,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el servicio';
                  }
                  return null;
                },
                onChanged: (String? value) {
                  setState(() {
                    evento = value;
                    servicioAgenda.text = value.toString();
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Rumba',
                    child: Text('Rumba'),
                  ),
                  DropdownMenuItem(
                    value: 'Yoga',
                    child: Text('Yoga'),
                  ),
                  DropdownMenuItem(
                    value: 'Aerobicos',
                    child: Text('Aerobicos'),
                  ),
                  DropdownMenuItem(
                    value: 'Spinning',
                    child: Text('Spinning'),
                  ),
                  DropdownMenuItem(
                    value: 'CrossFit',
                    child: Text('Crossfit'),
                  ),
                ],
                decoration: const InputDecoration(
                  hintText: 'Selecciona un Evento',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DateTimeFormField(
                decoration: const InputDecoration(hintText: "Fecha Inicio"),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (DateTime? value) {
                  if (value == null) {
                    return 'Ingrese la fecha Inicio';
                  }
                  if (value.isBefore(DateTime.now())) {
                    return 'La fecha Inicio debe ser mayor o igual a la fecha actual';
                  }
                  return null;
                },
                onChanged: (DateTime? value) {
                  fechaInicio = value;
                  fechaInicioController.text = value.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DateTimeFormField(
                decoration: const InputDecoration(hintText: "Fecha Fin"),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (DateTime? value) {
                  if (value == null) {
                    return 'Ingrese la fecha fin';
                  }
                  if (value.isBefore(DateTime.now())) {
                    return 'La fecha fin debe ser mayor o igual a la fecha actual';
                  }
                  return null;
                },
                onChanged: (DateTime? value) {
                  fechaFin = value;
                  fechaFinController.text = value.toString();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Hora Inicio'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la hora inicio';
                  }

                  // Expresión regular para validar el formato de la hora
                  RegExp regExp =
                      RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9] (AM|PM)$');
                  if (!regExp.hasMatch(value)) {
                    return 'Ingrese la hora en formato HH:MM AM/PM';
                  }

                  // Convertir la hora ingresada a un objeto TimeOfDay
                  List<String> parts = value.split(' ');
                  List<String> timeParts = parts[0].split(':');
                  int hour = int.parse(timeParts[0]);
                  int minute = int.parse(timeParts[1]);
                  if (parts[1] == 'PM' && hour != 12) {
                    hour += 12;
                  }
                  TimeOfDay selectedTime =
                      TimeOfDay(hour: hour, minute: minute);

                  // Verificar si la hora está dentro del rango deseado (8:00 am - 8:00 pm)
                  const TimeOfDay startOfDay = TimeOfDay(hour: 8, minute: 0);
                  const TimeOfDay endOfDay = TimeOfDay(hour: 20, minute: 0);
                  if (selectedTime.hour < startOfDay.hour ||
                      selectedTime.hour > endOfDay.hour) {
                    return 'La hora debe estar entre las 8:00 am y las 8:00 pm';
                  }

                  return null;
                },
                onSaved: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    horaInicio = value;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Hora Fin'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la hora inicio';
                  }

                  // Expresión regular para validar el formato de la hora
                  RegExp regExp =
                      RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9] (AM|PM)$');
                  if (!regExp.hasMatch(value)) {
                    return 'Ingrese la hora en formato HH:MM AM/PM';
                  }

                  // Convertir la hora ingresada a un objeto TimeOfDay
                  List<String> parts = value.split(' ');
                  List<String> timeParts = parts[0].split(':');
                  int hour = int.parse(timeParts[0]);
                  int minute = int.parse(timeParts[1]);
                  if (parts[1] == 'PM' && hour != 12) {
                    hour += 12;
                  }
                  TimeOfDay selectedTime =
                      TimeOfDay(hour: hour, minute: minute);

                  // Verificar si la hora está dentro del rango deseado (8:00 am - 8:00 pm)
                  const TimeOfDay startOfDay = TimeOfDay(hour: 8, minute: 0);
                  const TimeOfDay endOfDay = TimeOfDay(hour: 20, minute: 0);
                  if (selectedTime.hour < startOfDay.hour ||
                      selectedTime.hour > endOfDay.hour) {
                    return 'La hora debe estar entre las 8:00 am y las 8:00 pm';
                  }

                  return null;
                },
                onSaved: (String? value) {
                  if (value != null && value.isNotEmpty) {
                    horaFin = value;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Descripcion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la descripcion del ejercicio';
                  }
                  return null;
                },
                onSaved: (value) {
                  descripcionAgenda = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formEventos.currentState!.validate()) {
                    _formEventos.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('¡El evento se guardó correctamente!'),
                      ),
                    );

                    //Redirigir
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NavegacionScreen(token: widget.token),
                      ),
                    );

                    var eventos = {
                      "serviciosAgenda": servicioAgenda.text,
                      "fechaInicio": fechaInicioController.text,
                      "fechaFin": fechaFinController.text,
                      "horaInicio": horaInicio,
                      "horaFin": horaFin,
                      "descripcionAgenda": descripcionAgenda,
                      "nombreEmpleado": nombreEmpleado
                    };
                    Http.postEvento(eventos);
                    print(eventos);
                  }
                },
                icon: const Icon(Icons.send),
                label:
                    const Text('Enviar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextEditingController servicioAgenda = TextEditingController();
TextEditingController fechaInicioController = TextEditingController();
TextEditingController fechaFinController = TextEditingController();
String horaInicio = '';
String horaFin = '';
String descripcionAgenda = '';
String nombreEmpleado = '';
