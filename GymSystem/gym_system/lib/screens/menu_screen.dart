// import 'package:flutter/material.dart';
// // import 'package:gym_system/screens/form_ejercicios.dart';
// import 'package:gym_system/screens/form_eventos.dart';

// class MenuScreen extends StatefulWidget {
//   const MenuScreen({super.key}); //required String token

//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }

// class _MenuScreenState extends State<MenuScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Gym System',
//           style: TextStyle(color: Colors.white, fontSize: 50),
//         ),
//         backgroundColor: Colors.orange,
//       ),
//       body: ListView(
//         children: [
//           const ListTile(
//             title: Text('Home'),
//             subtitle: Text('Inicio App'),
//             leading: Icon(
//               Icons.home_filled,
//               color: Colors.orange,
//             ),
//             trailing: Icon(Icons.navigate_next),
//           ),
//           ListTile(
//             title: const Text('Eventos'),
//             subtitle: const Text('Clases y eventos'),
//             leading: const Icon(
//               Icons.people,
//               color: Colors.orange,
//             ),
//             trailing: const Icon(Icons.navigate_next),
//             onTap: () {
//               final route =
//                   MaterialPageRoute(builder: (context) => const FormEventos());
//               Navigator.push(context, route);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
