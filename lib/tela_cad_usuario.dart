import 'package:flutter/material.dart';



class TelaCadUsuario extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return StatefulWidget();
    StatefulWidget;
  }
}
  class TelaCadUsuario extends State<TelaCadUsuario>{

  class _DemoForm extends State<DemoForm>{
    final formkey = Globalkey<formState();
    String nome = '';
    String email = '';
    String senha = '';
  }
@override
    Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: Text(widget.title)),
  body: Form(
  key: formKey,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  child: ListView(
  padding: const EdgeInsets.all(16),
  children: [
  TextFormField(
  decoration: const InputDecoration(
  prefixIcon: Icon(Icons.email),
  labelText: 'E-Mail',
  border: OutlineInputBorder()

  ),
  validator: (email) =>
  email != null && !EmailValidator.validate(email)
  ? 'E-Mail inválido'
      : null,
  onChanged: (email) {...},
  ),
  const SizedBox(height:16),
  TextFormField(...), //TextFormField
  const SizedBox(height: 16),
  ElevatedButton(...) //ElevatedButton
  ],
  )
  ),
  );
  }
}


