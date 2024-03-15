import 'package:flutter/material.dart';
import 'package:gym_system/screens/registro_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool llamadoAPI = false;
  bool mostrarPasswor = true;
  final GlobalKey<FormState> _formLogin =
      GlobalKey<FormState>(); //estado del formulario
  String correo = '';
  String password = '';

  void acceder(String correo, String password) async {
    // Endpoint de tu API
    var url = Uri.parse('https://apidespliegue.onrender.com/registarUsuario');

    // Cuerpo de la solicitud
    var body = {
      'correo': correo,
      'password': password,
    };

    // Realizar la solicitud POST
    var response = await http.post(url, body: body);

    // Verificar el estado de la respuesta
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, puedes procesar la respuesta aquí
      // Por ejemplo, puedes imprimir la respuesta
      print('Respuesta de la API: ${response.body}');
    } else {
      // Si la solicitud falla, puedes manejar el error aquí
      print('Error al hacer la solicitud: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Form(
          key: _formLogin,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                    hintText: "Usuario",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'Digitar Usuario',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su usuario';
                  }
                  return null;
                },
                onSaved: (value) {
                  correo = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.password,
                    ),
                    suffixIcon: Icon(Icons.password),
                    hintText: "Contrasena",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    labelText: 'Ingrese Contrasena',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    )),
                // funcion del framework para validar
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su contrasena';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  //Realizar validacion cuando se le da al boton
                  if (_formLogin.currentState!.validate()) {
                    _formLogin.currentState!.save();
                    acceder(correo, password);
                  }
                },
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  'Acceder',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
              ListTile(
                title: const Text('Registrate'),
                leading: const Icon(Icons.app_registration),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => const RegistrarScreen());
                  Navigator.push(context, route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
