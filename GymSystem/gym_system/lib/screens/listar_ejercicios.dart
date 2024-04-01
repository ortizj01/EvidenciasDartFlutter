import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gym_system/screens/detalleEjercicios.dart';
import 'package:gym_system/screens/form_ejercicios.dart';
import 'package:http/http.dart' as http;

class Ejercicio {
  final String id;
  final String nombreEjercicio;
  final int repeticionesEjercicio;
  final String descripcionEjercicio;

// constructor de la calse
  Ejercicio(
      {required this.id,
      required this.nombreEjercicio,
      required this.repeticionesEjercicio,
      required this.descripcionEjercicio});

// metodo factory para construir un objeto Ejercicio desde un mapa JSON.
  factory Ejercicio.fromJson(Map<String, dynamic> json) {
    return Ejercicio(
        id: json['_id'],
        nombreEjercicio: json['nombreEjercicio'],
        repeticionesEjercicio: json['repeticionesEjercicio'],
        descripcionEjercicio: json['descripcionEjercicio']);
  }
}

//funcion asincronica para obtener una lista de ejercicios desde una API
Future<List<Ejercicio>> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://apidespliegue.onrender.com/registrarEjercicio'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> ejercicioJson = jsonData['msg'];
    return ejercicioJson.map((json) => Ejercicio.fromJson(json)).toList();
  } else {
    throw Exception('Fallo la carga de ejercicios');
  }
}

class ListarEjercicios extends StatefulWidget {
  final String token;

// constructor que recibe un token como parametro
  const ListarEjercicios({Key? key, required this.token}) : super(key: key);

  @override
  State<ListarEjercicios> createState() => _ListarEjerciciosState();
}

class _ListarEjerciciosState extends State<ListarEjercicios> {
  Future<void> editarEjercicio(Ejercicio ejercicio) async {
    const String url = 'https://apidespliegue.onrender.com/registrarEjercicio';

    //Metodo para convertir a un formato entendible para la API(JSON)
    final Map<String, dynamic> datosActualizados = {
      '_id': ejercicio.id,
      'nombreEjercicio': ejercicio.nombreEjercicio,
      'repeticionesEjercicio': ejercicio.repeticionesEjercicio,
      'descripcionEjercicio': ejercicio.descripcionEjercicio
    };

    print('Datos a Actulizar');
    print(datosActualizados);

//convertimos el objeto a una cadena JSON
    final String cuerpoJson = jsonEncode(datosActualizados);

    try {
      //solicitud PUT con los datos
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

  void mostrarVentanaEdicion(BuildContext context, Ejercicio ejercicio) {
    TextEditingController nombreEjercicioController =
        TextEditingController(text: ejercicio.nombreEjercicio);
    TextEditingController repeticionesController =
        TextEditingController(text: ejercicio.repeticionesEjercicio.toString());
    TextEditingController descripcionController =
        TextEditingController(text: ejercicio.descripcionEjercicio.toString());

// mostrar dialogo de alerta
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Ejercicio'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nombreEjercicioController,
                  decoration:
                      const InputDecoration(labelText: 'Nombre Ejercicio'),
                ),
                TextField(
                  controller: repeticionesController,
                  decoration: const InputDecoration(labelText: 'Repeticiones'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Convertir los valores de texto a tipos numéricos
                int repeticiones = int.parse(repeticionesController.text);

                // Crear la instancia de Exportacion con los valores convertidos
                Ejercicio ejercicioActualizado = Ejercicio(
                  id: ejercicio.id,
                  nombreEjercicio: nombreEjercicioController.text,
                  repeticionesEjercicio: repeticiones,
                  descripcionEjercicio: descripcionController.text,
                );
                editarEjercicio(ejercicioActualizado);
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void eliminarEjercicio(Ejercicio ejercicio) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content: const Text(
              "¿Estás seguro de que deseas eliminar este ejercicio?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cerrar el diálogo
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cerrar el diálogo
                try {
                  // URL de la API para eliminar la exportación
                  String url =
                      'https://apidespliegue.onrender.com/registrarEjercicio?_id=${ejercicio.id}';

                  final response = await http.delete(Uri.parse(url));

                  if (response.statusCode == 200) {
                    print(
                        'El ejercicio con ID ${ejercicio.id} se eliminó correctamente.');
                    setState(() {});
                  } else {
                    print('Error al eliminar : ${response.statusCode}');
                  }
                } catch (e) {
                  print('Error al eliminar el ejercicio: $e');
                }
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ejercicios'),
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
                    delegate: BusquedaEjercicios(),
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
                  builder: (context) => EjerciciosScreen(token: widget.token)),
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
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Ejercicio> ejercicios = snapshot.data as List<Ejercicio>;
                  return ListView.separated(
                    itemCount: ejercicios.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(ejercicios[index].nombreEjercicio),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ejercicios[index]
                                .repeticionesEjercicio
                                .toString()),
                            Text(ejercicios[index]
                                .descripcionEjercicio
                                .toString()),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                mostrarVentanaEdicion(
                                    context, ejercicios[index]);
                                print('Editar');
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                eliminarEjercicio(ejercicios[index]);
                                // Implementar la lógica para eliminar aquí
                                print('Eliminar');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }),
        ));
  }
}

class BusquedaEjercicios extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar";

  // construimos los botones de accion en la barra de busqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            //Limpia el campo
            query = '';
          })
    ];
  }

  // boton de retroceso
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  // sigerencias de busqueda cuando escribe
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  //contruye los resultados de la busqueda
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: buscarEjercicio(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            List<Ejercicio> ejercicio = snapshot.data as List<Ejercicio>;
            return ListView.builder(
                itemCount: ejercicio.length,
                itemBuilder: (context, index) {
                  Ejercicio ejercicios = ejercicio[index];
                  return ListTile(
                    title: Text(ejercicios.nombreEjercicio),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${ejercicios.repeticionesEjercicio}'),
                        Text(ejercicios.descripcionEjercicio),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetallesEjercicioScreen(ejercicio: ejercicios),
                        ),
                      );
                    },
                  );
                });
          }
        });
  }

//Buscar en la API
  Future<List<Ejercicio>> buscarEjercicio(String query) async {
    // Realiza la solicitud a tu API para obtener todos los eventos
    final response = await http.get(
      Uri.parse('https://apidespliegue.onrender.com/registrarEjercicio'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> ejercicioJson = jsonData['msg'];
      // Filtra los eventos por el servicioAgenda si query no está vacío
      if (query.isNotEmpty) {
        return ejercicioJson
            .where((ejercicio) => ejercicio['nombreEjercicio']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .map((json) => Ejercicio.fromJson(json))
            .toList();
      } else {
        // Si query está vacío, devuelve todos los eventos
        return ejercicioJson.map((json) => Ejercicio.fromJson(json)).toList();
      }
    } else {
      throw Exception('Fallo la búsqueda de ejercicios');
    }
  }
}
