import 'package:app_hdv/screens/datos_personales.dart';
import 'package:app_hdv/screens/estudios.dart';
import 'package:app_hdv/screens/habilidades.dart';
import 'package:flutter/material.dart';

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
        title: const Center(
          child: Text(
            'Hoja de vida',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Datos personales'),
              leading: const Icon(
                Icons.dataset,
                color: Colors.blueGrey,
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (context) => const DatosScreen());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: const Text('Estudios'),
              leading: const Icon(
                Icons.book,
                color: Colors.blueGrey,
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (context) => const EstudiosScreen());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              title: const Text('Habilidades'),
              leading: const Icon(
                Icons.work,
                color: Colors.blueGrey,
              ),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                final route = MaterialPageRoute(
                    builder: (context) => const HabilidadesScreen());
                Navigator.push(context, route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
