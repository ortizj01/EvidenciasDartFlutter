import 'package:flutter/material.dart';
import 'package:gps_foto/screens/foto.dart';
import 'package:gps_foto/screens/mapa.dart';
import 'package:camera/camera.dart'; // Importa la clase CameraDescription

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<void> _cameraInitialization;
  CameraDescription? _firstCamera;

  @override
  void initState() {
    super.initState();
    _cameraInitialization = _initializeFirstCamera();
  }

  Future<void> _initializeFirstCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      setState(() {
        _firstCamera = cameras.first;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Cámara no disponible'),
          content: Text(
              'No se encontraron cámaras disponibles en este dispositivo.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Proyecto Final',
            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<void>(
          future: _cameraInitialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                _firstCamera != null) {
              return ListView(
                children: [
                  ListTile(
                    title: const Text('Tomar Foto'),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blueGrey,
                    ),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      final route = MaterialPageRoute(
                        builder: (context) =>
                            CameraScreen(camera: _firstCamera!),
                      );
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    title: const Text('Ubicación'),
                    leading: const Icon(
                      Icons.map,
                      color: Colors.blueGrey,
                    ),
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      final route = MaterialPageRoute(
                        builder: (context) => const MapaScreen(),
                      );
                      Navigator.push(context, route);
                    },
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
