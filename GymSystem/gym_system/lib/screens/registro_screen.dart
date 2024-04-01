import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gym_system/screens/login_screen.dart';
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

class Registrar extends StatefulWidget {
  const Registrar({Key? key}) : super(key: key);

  @override
  State<Registrar> createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  final GlobalKey<FormState> _formRegistro = GlobalKey<FormState>();
  String nombres = '';
  String apellidos = '';
  String documento = '';
  String correo = '';
  String telefono = '';
  String direccion = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Usuario'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formRegistro,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Nombre"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese sus nombres';
                    }
                    // Expresión regular para verificar que el valor contiene solo letras y espacios
                    RegExp regExp = RegExp(r'^[a-zA-Z\s]+$');
                    if (!regExp.hasMatch(value)) {
                      return 'El nombre solo puede contener letras y espacios';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nombres = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Apellidos"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese sus apellidos';
                    }
                    // Expresión regular para verificar que el valor contiene solo letras y espacios
                    RegExp regExp = RegExp(r'^[a-zA-Z\s]+$');
                    if (!regExp.hasMatch(value)) {
                      return 'Los apellidos solo pueden contener letras y espacios';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    apellidos = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Documento"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su documento';
                    }
                    // Verificar si el valor tiene exactamente 10 dígitos
                    if (value.length != 10) {
                      return 'El documento debe tener exactamente 10 dígitos';
                    }
                    // Verificar si el valor contiene solo dígitos
                    if (!value.contains(RegExp(r'^[0-9]*$'))) {
                      return 'El documento debe contener solo números';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    documento = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Correo"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su correo';
                    }
                    // Expresión regular para validar el formato del correo electrónico
                    RegExp emailRegExp =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Ingrese un correo electrónico válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    correo = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Teléfono"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su teléfono';
                    }
                    // Expresión regular para verificar que el valor contiene exactamente 10 dígitos
                    RegExp regExp = RegExp(r'^\d{10}$');
                    if (!regExp.hasMatch(value)) {
                      return 'El teléfono debe contener 10 dígitos numéricos';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    telefono = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Dirección"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese direccion';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    direccion = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Contraseña"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      }
                      if (value.length < 8) {
                        return 'La contraseña debe tener al menos 8 caracteres';
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'La contraseña debe contener al menos una mayúscula';
                      }
                      if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'La contraseña debe contener al menos un número';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    }),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formRegistro.currentState!.validate()) {
                      _formRegistro.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('¡El usuario se guardó correctamente!'),
                        ),
                      );

                      //Redirigir
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }

                    var usuario = {
                      "nombres": nombres,
                      "apellidos": apellidos,
                      "documento": documento,
                      "correo": correo,
                      "telefono": telefono,
                      "direccion": direccion,
                      "password": password
                    };
                    Http.postUsuario(usuario);
                    print(usuario);
                  },
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: const Text(
                    'Registrar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
