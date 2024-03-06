import 'package:flutter/material.dart';

class EjerciciosScreen extends StatefulWidget {
  const EjerciciosScreen({super.key});

  @override
  State<EjerciciosScreen> createState() => _EjerciciosScreenState();
}

class _EjerciciosScreenState extends State<EjerciciosScreen> {
  void ejercicios() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Ejercicios'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.sports_gymnastics,
                    ),
                    hintText: "Nombre Ejercicio",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'Digitar Ejercicio',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 2,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.repeat,
                    ),
                    hintText: "Repeticion Ejercicio",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'Ingrese repeticiones',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.description,
                    ),
                    hintText: "Descripcion Ejercicio",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'Ingrese Descripcion',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: ejercicios,
                icon: const Icon(Icons.save, color: Colors.white),
                label: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
