import 'package:flutter/material.dart';
import 'package:movilidad/screens/infracciones_screen.dart';
import 'package:movilidad/screens/picoyplaca.dart';

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
        title: const Text('Movilidad'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Pico y Placa'),
            subtitle: const Text('Consulte su pico y placa'),
            leading: const Icon(
              Icons.car_rental,
              color: Colors.black,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const PicoYPlacaScreen());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('Infracciones'),
            subtitle: const Text('Ingrese y consulte'),
            leading: const Icon(
              Icons.newspaper,
              color: Colors.black,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const InfraccionesScreeen());
              Navigator.push(context, route);
            },
          )
        ],
      ),
    );
  }
}
