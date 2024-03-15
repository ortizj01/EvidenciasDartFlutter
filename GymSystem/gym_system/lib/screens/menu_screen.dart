import 'package:flutter/material.dart';
import 'package:gym_system/screens/form_ejercicios.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Gym System',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Home'),
            subtitle: Text('Inicio App'),
            leading: Icon(
              Icons.home_filled,
              color: Colors.orange,
            ),
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            title: const Text('Mision'),
            subtitle: const Text('Quienes somos?'),
            leading: const Icon(
              Icons.people,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const EjerciciosScreen());
              Navigator.push(context, route);
            },
          ),
          // ListTile(
          //   title: const Text('Productos'),
          //   subtitle: const Text('Lista de productos'),
          //   leading: const Icon(
          //     Icons.production_quantity_limits_outlined,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route = MaterialPageRoute(
          //         builder: (context) => const ProductosScreen());
          //     Navigator.push(context, route);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Contacto'),
          //   subtitle: const Text('Donde estamos'),
          //   leading: const Icon(
          //     Icons.phone_android,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route = MaterialPageRoute(
          //         builder: (context) => const ContactoScreen());
          //     Navigator.push(context, route);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Array'),
          //   subtitle: const Text('Donde estamos'),
          //   leading: const Icon(
          //     Icons.add_box,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route =
          //         MaterialPageRoute(builder: (context) => const ScreenArray());
          //     Navigator.push(context, route);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Ejercicio'),
          //   subtitle: const Text('Prodcutos'),
          //   leading: const Icon(
          //     Icons.sell_outlined,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route = MaterialPageRoute(
          //         builder: (context) => const ScreenEjercicio());
          //     Navigator.push(context, route);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Rectangulo'),
          //   subtitle: const Text('Area y Perimetro'),
          //   leading: const Icon(
          //     Icons.rectangle,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route = MaterialPageRoute(
          //         builder: (context) => const RectanguloScreen());
          //     Navigator.push(context, route);
          //   },
          // ),
          // ListTile(
          //   title: const Text('Login'),
          //   subtitle: const Text('Ingresa al sistema'),
          //   leading: const Icon(
          //     Icons.login,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route =
          //         MaterialPageRoute(builder: (context) => const LoginScreen());
          //     Navigator.push(context, route);
          //   },
          // )
        ],
      ),
    );
  }
}
