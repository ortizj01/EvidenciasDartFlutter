import 'package:flutter/material.dart';
import 'package:gym_system/screens/listar_ejercicios.dart';
import 'package:gym_system/screens/listar_eventos.dart';
import 'package:gym_system/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavegacionScreenApp extends StatelessWidget {
  final String token;
  const NavegacionScreenApp({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavegacionScreen(token: token),
    );
  }
}

class NavegacionScreen extends StatefulWidget {
  final String token;

  const NavegacionScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<NavegacionScreen> createState() => _NavegacionScreenState();
}

class AuthService {
  // Método para obtener el token de autenticación almacenado en SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Método para cerrar sesión (limpiar el token de autenticación)
  Future<void> logout(BuildContext context) async {
    try {
      // Obtener el token actual antes de eliminarlo
      final tokenBeforeLogout = await getToken();
      print('Token antes de cerrar sesión: $tokenBeforeLogout');

      // Eliminar el token de autenticación de SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // Verificar si el token se eliminó correctamente
      final tokenAfterLogout = await getToken();
      print('Token después de cerrar sesión: $tokenAfterLogout');

      // Navegar de regreso a la pantalla de inicio de sesión
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false, // Eliminar todas las rutas existentes
      );
    } catch (error) {
      print('Error al cerrar sesión: $error');
      // Manejar el error, si es necesario
    }
  }
}

class _NavegacionScreenState extends State<NavegacionScreen> {
  final AuthService _authService = AuthService();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions() {
    return [
      const Text(
        'Bienvenido',
        style: optionStyle,
      ),
      ListarEvento(token: widget.token),
      ListarEjercicios(token: widget.token),
      const Text(
        // aquí está la opción de cerrar sesión
        'Cerrar Sesión',
        style: optionStyle,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 3) {
        confirmacionCerrarSesion();
      }
    });
  }

  void confirmacionCerrarSesion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Llamar al método de cerrar sesión del AuthService
                _authService.logout(context);
              },
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Color.fromARGB(255, 255, 167, 67),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Eventos',
            backgroundColor: Color.fromARGB(255, 255, 167, 67),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Ejercicios',
            backgroundColor: Color.fromARGB(255, 255, 167, 67),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: 'Cerrar Sesión',
            backgroundColor: Color.fromARGB(255, 255, 167, 67),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(52, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
