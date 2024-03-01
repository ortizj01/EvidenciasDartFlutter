import 'package:flutter/material.dart';

class EstudiosScreen extends StatefulWidget {
  const EstudiosScreen({super.key});

  @override
  State<EstudiosScreen> createState() => _EstudiosScreenState();
}

class _EstudiosScreenState extends State<EstudiosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis Estudios'),
          titleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.deepPurple,
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:
                        Text('• Bachiller Tecnico en Desarrollo de Software'),
                  ))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('• Tecnologo en Desarrollo de Software'),
                  ))
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('lib/images/img2.jpg'),
                        width: 400,
                        height: 300,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
