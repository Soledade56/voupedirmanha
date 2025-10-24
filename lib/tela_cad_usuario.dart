import 'package:flutter/material.dart';
import 'package:soledade/banco/usuario_dao.dart';

class TelaCadUsuario extends StatefulWidget {
  TelaCadUsuario({super.key});

  @override
  State<StatefulWidget> createState() {
    return TelaCadUsuarioState();

  }

}

class TelaCadUsuarioState extends State<TelaCadUsuario>{

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return(
        Scaffold(
          appBar: AppBar(title: const Text('Cadastro de Usuario')),
          body: Padding(padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Informações do Usuario"),
                SizedBox(height: 30),
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                      hintText: 'Nome do Usuario'),
                  validator: (String? value) {
                  },
                ),
                TextFormField(
                  controller: loginController,
                  decoration: const InputDecoration(
                      hintText: 'Login do Usuario'),
                  validator: (String? value) {
                  },
                ),
            TextFormField(
              controller: senhaController,  obscureText:  true,
              decoration: const InputDecoration(
                  hintText: 'Senha do Usuario'),
              validator: (String? value) {
              },
            ),
            ElevatedButton(
                onPressed: ()async {
                final sucesso = await UsuarioDAO.cadastrarUsuario(
                    nomeController.text,
                    loginController.text,
                    senhaController.text,
                );
                String msg = 'ERRO: usuario não cadastrado';
                Color corFundo = Colors.red;
                if(sucesso> 0 ){
                  //sucesso é o ID do restaurante cadastrado, que será maior que 0(zer0)
                  msg = '"${nomeController.text}" cadastrado! ID: $sucesso';
                  corFundo = Colors.green;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                      backgroundColor: corFundo,
                      duration:  Duration(seconds: 5),
                    )
                );

            },
                child: const Text("Cadastrar"))
              ],
            ),
         )
        )
    );
  }
}