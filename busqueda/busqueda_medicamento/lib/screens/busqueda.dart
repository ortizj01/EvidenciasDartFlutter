import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medicamento {
  final String nombre_comercial;
  final String cantidad_solicitada;

  Medicamento({
    required this.nombre_comercial,
    required this.cantidad_solicitada,
  });

  factory Medicamento.fromJson(Map<String, dynamic> json) {
    return Medicamento(
      nombre_comercial: json['nombre_comercial_'],
      cantidad_solicitada:
          json['cantidad_solicitada'] ?? 'Cantidad no disponible',
    );
  }
}

class Busqueda extends StatefulWidget {
  const Busqueda({Key? key}) : super(key: key);

  @override
  State<Busqueda> createState() => _BusquedaState();
}

class _BusquedaState extends State<Busqueda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BusquedaMedicamento());
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                '© 2024 Juan Esteban Ortiz',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BusquedaMedicamento extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Medicamento>>(
      future: buscarEscaso(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else {
          List<Medicamento> medicamentos = snapshot.data!;
          return ListView.builder(
            itemCount: medicamentos.length,
            itemBuilder: (context, index) {
              Medicamento? medicamento = medicamentos[index];
              if (medicamento != null) {
                return ListTile(
                  title: Text(medicamento.nombre_comercial),
                  subtitle: Text(
                      'Cantidad solicitada: ${medicamento.cantidad_solicitada}'),
                  trailing: medicamento.cantidad_solicitada != null &&
                          int.parse(medicamento.cantidad_solicitada) <= 5
                      ? const Text('Escaso',
                          style: TextStyle(color: Colors.red))
                      : null,
                );
              } else {
                return const ListTile(
                  title: Text('Medicamento no encontrado'),
                );
              }
            },
          );
        }
      },
    );
  }

  Future<List<Medicamento>> buscarEscaso(String query) async {
    final response = await http.get(
      Uri.parse('https://www.datos.gov.co/resource/sdmr-tfmf.json'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;

      List<Medicamento> medicamentos = [];
      for (var item in jsonData) {
        Medicamento medicamento = Medicamento.fromJson(item);
        if (medicamento.nombre_comercial
            .toLowerCase()
            .contains(query.toLowerCase())) {
          medicamentos.add(medicamento);
        }
      }
      return medicamentos;
    } else {
      throw Exception('Fallo la búsqueda de medicamentos');
    }
  }
}
