import 'package:flutter/material.dart';
import 'usuario.dart';
import 'tela_login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

   /* Usuario u = Usuario(
      codigo: 1,
      login: "soledade123",
      nome: "Soledade",
      senha: "@senhaforte123"
    );*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLogin(),
    );

  }
}
