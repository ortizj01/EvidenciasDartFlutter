import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:gym_system/screens/detalleEventos.dart';
import 'package:gym_system/screens/form_eventos.dart';
//import 'package:gym_system/screens/form_eventos.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Evento {
  final String id;
  final String serviciosAgenda;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String horaInicio;
  final String horaFin;
  final String nombreEmpleado;
  final String descripcionAgenda;

  Evento(
      {required this.id,
      required this.serviciosAgenda,
      required this.fechaInicio,
      required this.fechaFin,
      required this.horaInicio,
      required this.horaFin,
      required this.nombreEmpleado,
      required this.descripcionAgenda});

  factory Evento.fromJson(Map<String, dynamic> json) {
    return Evento(
        id: json['_id'],
        serviciosAgenda: json['serviciosAgenda'],
        fechaInicio: json['fechaInicio'] != null
            ? DateTime.parse(json['fechaInicio'])
            : null,
        fechaFin:
            json['fechaFin'] != null ? DateTime.parse(json['fechaFin']) : null,
        horaInicio: json['horaInicio'] ?? '',
        horaFin: json['horaFin'] ?? '',
        nombreEmpleado: json['nombreEmpleado'] ?? '',
        descripcionAgenda: json['descripcionAgenda'] ?? '');
  }
}

Future<List<Evento>> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://apidespliegue.onrender.com/registrarEvento'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> eventosJson = jsonData['msg'];
    return eventosJson.map((json) => Evento.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de eventos');
  }
}

class ListarEvento extends StatefulWidget {
  final String token;

  const ListarEvento({Key? key, required this.token}) : super(key: key);

  @override
  State<ListarEvento> createState() => _ListarEventoState();
}

class _ListarEventoState extends State<ListarEvento> {
  //Editar
  TextEditingController fechaInicioController = TextEditingController();
  TextEditingController fechaFinController = TextEditingController();

  Future<void> editarEvento(Evento evento) async {
    DateTime? fechaInicio = fechaInicioController.text.isNotEmpty
        ? DateFormat('yyyy-MM-dd').parse(fechaInicioController.text)
        : null;
    DateTime? fechaFin = fechaFinController.text.isNotEmpty
        ? DateFormat('yyyy-MM-dd').parse(fechaFinController.text)
        : null;

    print('Fecha Inicio:$fechaInicio');
    print('Fecha Fin:$fechaFin');

    const String url = 'https://apidespliegue.onrender.com/registrarEvento';

    //Metodo para convertir a un formato entendible para la API(JSON)
    final Map<String, dynamic> datosActualizados = {
      '_id': evento.id,
      'serviciosAgenda': evento.serviciosAgenda,
      'fechaInicio': fechaInicio != null
          ? DateFormat('yyyy-MM-dd').format(fechaInicio)
          : null,
      'fechaFin':
          fechaFin != null ? DateFormat('yyyy-MM-dd').format(fechaFin) : null,
      'horaInicio': evento.horaInicio,
      'horaFin': evento.horaFin,
      "descripcionAgenda": evento.descripcionAgenda,
      'nombreEmpleado': evento.nombreEmpleado
    };
    print('Datos a Actulizar');
    print(datosActualizados);

    final String cuerpoJson = jsonEncode(datosActualizados);

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: cuerpoJson,
      );
      if (response.statusCode == 200) {
        print('Actualizacion exitosa');
        setState(() {});
      } else {
        print('Error al editar: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error solicitud: $e');
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void mostrarEdicion(BuildContext context, Evento evento) {
    TextEditingController servicioController =
        TextEditingController(text: evento.serviciosAgenda);

    TextEditingController horaInicioController =
        TextEditingController(text: evento.horaInicio);
    TextEditingController horaFinController =
        TextEditingController(text: evento.horaFin);
    TextEditingController descripcionController =
        TextEditingController(text: evento.descripcionAgenda);
    TextEditingController empleadoController =
        TextEditingController(text: evento.nombreEmpleado);

    fechaInicioController.text = evento.fechaInicio != null
        ? DateFormat('yyyy-MM-dd').format(evento.fechaInicio!)
        : '';
    fechaFinController.text = evento.fechaFin != null
        ? DateFormat('yyyy-MM-dd').format(evento.fechaFin!)
        : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Evento'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey, // Asignar la clave global al formulario
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: empleadoController.text,
                    onChanged: (String? value) {
                      setState(() {
                        empleadoController.text = value ?? '';
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
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    value: servicioController.text,
                    onChanged: (String? value) {
                      setState(() {
                        servicioController.text = value ?? '';
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
                  const SizedBox(height: 20.0),
                  DateTimeFormField(
                    decoration: const InputDecoration(hintText: "Fecha Inicio"),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    initialValue: evento.fechaInicio,
                    onChanged: (DateTime? value) {
                      setState(() {
                        fechaInicioController.text =
                            DateFormat('yyyy-MM-dd').format(value!);
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  DateTimeFormField(
                    decoration: const InputDecoration(hintText: "Fecha Fin"),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    initialValue: evento.fechaFin,
                    onChanged: (DateTime? value) {
                      setState(() {
                        fechaFinController.text =
                            DateFormat('yyyy-MM-dd').format(value!);
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: horaInicioController,
                    decoration: const InputDecoration(hintText: 'Hora Inicio'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: horaFinController,
                    decoration: const InputDecoration(hintText: 'Hora Fin'),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: descripcionController,
                    decoration: const InputDecoration(hintText: 'Descripcion'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Validar el formulario antes de guardar
                if (formKey.currentState!.validate()) {
                  // Aquí puedes obtener los valores actualizados de los DateTimeFormFields y enviarlos a la API para la edición
                  Evento eventoEditado = Evento(
                      id: evento.id,
                      serviciosAgenda: servicioController.text,
                      fechaInicio: fechaInicioController.text.isNotEmpty
                          ? DateFormat('yyyy-MM-dd')
                              .parse(fechaInicioController.text)
                          : null,
                      fechaFin: fechaFinController.text.isNotEmpty
                          ? DateFormat('yyyy-MM-dd')
                              .parse(fechaFinController.text)
                          : null,
                      horaInicio: horaInicioController.text,
                      horaFin: horaFinController.text,
                      descripcionAgenda: descripcionController.text,
                      nombreEmpleado: empleadoController.text);
                  // Aquí puedes enviar los datos actualizados a la API para la edición
                  editarEvento(eventoEditado);
                  // Cerrar el diálogo
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void eliminarEvento(Evento evento) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alerta'),
            content: const Text('Estas Seguro de eliminar el evento'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(); //cerrar dialogo
                    try {
                      String url =
                          'https://apidespliegue.onrender.com/registrarEvento?_id=${evento.id}';

                      //solicitud a la API
                      final response = await http.delete(Uri.parse(url));

                      if (response.statusCode == 200) {
                        print('El evento se elimino correctamente');
                        setState(() {});
                      } else {
                        print('Error al eliminar: ${response.statusCode}');
                      }
                    } catch (e) {
                      print('Error al eminiar evento: $e');
                    }
                  },
                  child: const Text('Eliminar'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Eventos'),
        backgroundColor: Colors.white,
        actions: [
          // Botón para actualizar la lista de eventos
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {
                // Llamar a la función que recarga los datos
                setState(() {});
              },
              child: const Text('Actualizar'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            //icono para buscar
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: Busqueda(),
                );
              },
            ),
          )
        ],
      ),

      //Boton para crear un nuevo evento
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormEventos(token: widget.token)),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error ${snapshot.error}');
            } else {
              List<Evento> eventos = snapshot.data as List<Evento>;
              return ListView.separated(
                itemCount: eventos.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  String fechaInicioFormatted = '';
                  String fechaFinFormatted = '';

                  if (eventos[index].fechaInicio != null) {
                    fechaInicioFormatted =
                        DateFormat('dd/MM').format(eventos[index].fechaInicio!);
                  }

                  if (eventos[index].fechaFin != null) {
                    fechaFinFormatted =
                        DateFormat('dd/MM').format(eventos[index].fechaFin!);
                  }
                  return ListTile(
                    title: Text(eventos[index].serviciosAgenda),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (eventos[index].fechaInicio != null &&
                            eventos[index].fechaFin != null)
                          Text('$fechaInicioFormatted - $fechaFinFormatted'),
                        Text(
                            '${eventos[index].horaInicio} - ${eventos[index].horaFin}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            mostrarEdicion(context, eventos[index]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            eliminarEvento(eventos[index]);
                          },
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// Clase para buscar
class Busqueda extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // No es necesario implementar buildSuggestions si no quieres mostrar sugerencias mientras escribes.
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: buscarEventos(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else {
          List<Evento> eventos = snapshot.data as List<Evento>;
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              Evento evento = eventos[index];
              return ListTile(
                title: Text(evento.serviciosAgenda),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${evento.fechaInicio} - ${evento.fechaFin}'),
                    Text('${evento.horaInicio} - ${evento.horaFin}'),
                  ],
                ),
                onTap: () {
                  // Navegar a la pantalla de detalles del evento cuando se hace clic en el evento
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetallesEvento(evento: evento),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  Future<List<Evento>> buscarEventos(String query) async {
    // Realiza la solicitud a tu API para obtener todos los eventos
    final response = await http.get(
      Uri.parse('https://apidespliegue.onrender.com/registrarEvento'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> eventosJson = jsonData['msg'];
      // Filtra los eventos por el servicioAgenda si query no está vacío
      if (query.isNotEmpty) {
        return eventosJson
            .where((evento) => evento['serviciosAgenda']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .map((json) => Evento.fromJson(json))
            .toList();
      } else {
        // Si query está vacío, devuelve todos los eventos
        return eventosJson.map((json) => Evento.fromJson(json)).toList();
      }
    } else {
      throw Exception('Fallo la búsqueda de eventos');
    }
  }
}
