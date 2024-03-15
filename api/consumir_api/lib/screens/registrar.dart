import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Http {
  static String url = "https://apidespliegue.onrender.com/registarUsuario";
  static postUsuario(Map usuario) async {
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(usuario),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print('Fallo al insertar los datos');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
// https://apidespliegue.onrender.com/registarUsuario

class Registrar extends StatefulWidget {
  const Registrar({super.key});

  @override
  State<Registrar> createState() => _RegistrarState();
}

//
TextEditingController nombres = TextEditingController();
TextEditingController apellidos = TextEditingController();
TextEditingController documento = TextEditingController();
TextEditingController correo = TextEditingController();
TextEditingController telefono = TextEditingController();
TextEditingController edad = TextEditingController();
TextEditingController direccion = TextEditingController();
TextEditingController precioDolar = TextEditingController();
TextEditingController password = TextEditingController();

class _RegistrarState extends State<Registrar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Usuario'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: nombres,
                decoration: const InputDecoration(hintText: "Nombre"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: apellidos,
                decoration: const InputDecoration(hintText: "Apelldios"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: documento,
                decoration: const InputDecoration(hintText: "Documento"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: correo,
                decoration: const InputDecoration(hintText: "Correo"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: telefono,
                decoration: const InputDecoration(hintText: "Telefono"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: edad,
                decoration: const InputDecoration(hintText: "Edad"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: direccion,
                decoration: const InputDecoration(hintText: "Direccion"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: precioDolar,
                decoration: const InputDecoration(hintText: "Precio Dolar"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(hintText: "Contrasena"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  var usuario = {
                    "nombres": nombres.text,
                    "apellidos": apellidos.text,
                    "documento": documento.text,
                    "correo": correo.text,
                    "telefono": telefono.text,
                    "edad": edad.text,
                    "direccion": direccion.text,
                    "precioDolar": precioDolar.text,
                    "password": password.text
                  };
                  Http.postUsuario(usuario);
                  print(usuario);
                },
                icon: const Icon(Icons.send),
                label: const Text('Registrar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              )
            ],
          ),
        ));
  }
}
