import 'package:flutter/material.dart';

class InfraccionesScreeen extends StatefulWidget {
  const InfraccionesScreeen({super.key});

  @override
  State<InfraccionesScreeen> createState() => _InfraccionesScreeenState();
}

class _InfraccionesScreeenState extends State<InfraccionesScreeen> {
  Map<String, int> vehiculo = {};
  TextEditingController placaController = TextEditingController();
  TextEditingController numInfraccionesController = TextEditingController();

  void guardarInfo() {
    String placa = placaController.text;
    int numInfracciones = int.parse(numInfraccionesController.text);

    if (placa.isNotEmpty && numInfracciones > 0) {
      setState(() {
        vehiculo[placa] = numInfracciones;
      });
      placaController.clear();
      numInfraccionesController.clear();
    }
  }

  void buscarInfracciones() {
    String placaBuscada = placaController.text;
    int numInfraccionesEncontradas = vehiculo[placaBuscada] ?? 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Infracciones de la placa $placaBuscada'),
          content: Text('Número de infracciones: $numInfraccionesEncontradas'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
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
        title: const Text('Infracciones'),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 450,
          color: Colors.grey,
          child: Column(
            children: [
              TextField(
                controller: placaController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Placa'),
                maxLength: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: numInfraccionesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: '# Infracciones'),
                maxLength: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: guardarInfo, child: const Text('Registrar')),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: placaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ingrese Placa'),
                maxLength: 6,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: buscarInfracciones, child: const Text('Buscar')),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
