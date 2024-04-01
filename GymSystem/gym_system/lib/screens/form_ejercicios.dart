import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gym_system/screens/menu_inferior.dart';
import 'package:http/http.dart' as http;

class Http {
  static String url = "https://apidespliegue.onrender.com/registrarEjercicio";
  static postEjercicio(Map ejercicio) async {
    try {
      final res = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(ejercicio));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print('Error al insertar ejercicio');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class EjerciciosScreen extends StatefulWidget {
  final String token;

  const EjerciciosScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<EjerciciosScreen> createState() => _EjerciciosScreenState();
}

class _EjerciciosScreenState extends State<EjerciciosScreen> {
  String nombreEjercicio = '';
  int repeticionesEjercicio = 0;
  String descripcionEjercicio = '';
  final GlobalKey<FormState> _formEjercicio = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Ejercicios'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formEjercicio,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre del ejercicio';
                  }
                  return null;
                },
                onSaved: (value) {
                  nombreEjercicio = value!;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el numero de repeticiones';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    repeticionesEjercicio = int.parse(value);
                  }
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la descripcion del ejercicio';
                  }
                  return null;
                },
                onSaved: (value) {
                  descripcionEjercicio = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formEjercicio.currentState!.validate()) {
                    _formEjercicio.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('¡El ejercicio se guardó correctamente!'),
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
                  }

                  var ejercicios = {
                    'nombreEjercicio': nombreEjercicio,
                    'repeticionesEjercicio': repeticionesEjercicio,
                    'descripcionEjercicio': descripcionEjercicio
                  };
                  // enviar solicitud para guardar
                  Http.postEjercicio(ejercicios);
                  print(ejercicios);
                },
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
