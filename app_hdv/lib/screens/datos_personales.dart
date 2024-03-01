import 'package:flutter/material.dart';

class DatosScreen extends StatefulWidget {
  const DatosScreen({super.key});

  @override
  State<DatosScreen> createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Datos'),
        titleTextStyle: const TextStyle(color: Colors.white),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('• Juan Esteban Ortiz Jaramillo'),
              ))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('• 24 años'),
              ))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('• 3194386977'),
              ))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('• Medellìn - Antioquia'),
              ))
            ],
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('• juanestebanortiz70@gmail.com'),
              ))
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('lib/images/img3.png'),
                    width: 400,
                    height: 300,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
