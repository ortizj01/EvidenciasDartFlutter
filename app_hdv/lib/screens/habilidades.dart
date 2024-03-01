import 'package:flutter/material.dart';

class HabilidadesScreen extends StatefulWidget {
  const HabilidadesScreen({super.key});

  @override
  State<HabilidadesScreen> createState() => _HabilidadesScreenState();
}

class _HabilidadesScreenState extends State<HabilidadesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis Habilidades'),
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
                    child: Text('• Resolución de problemas'),
                  ))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('• Conocimiento de frameworks y tecnologías'),
                  ))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('• Trabajo en equipo'),
                  ))
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('• Aprendizaje continuo'),
                  ))
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('lib/images/img1.jpg'),
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
