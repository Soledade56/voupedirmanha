import 'package:flutter/material.dart';
import 'package:soledade/banco/restaurante_dao.dart';
import 'package:soledade/tela_cad_restaurante.dart';
import 'package:soledade/restaurante.dart';

class TelaHome extends StatefulWidget {
  TelaHome({super.key});

  @override
  State<TelaHome> createState() => TelaHomeState();
}

class TelaHomeState extends State<TelaHome> {
List <Restaurante> restaurantes = [];

@override
void initState(){
  super.initState();
  carregaRestaurantes();
}
Future<void> carregaRestaurantes()async{
  final lista = await RestauranteDAO.listarTodos();
  setState((){
    restaurantes = lista;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Lista de Restaurantes"),
        actions: [
          IconButton(
              onPressed: (){
                var t = Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadRestaurante()));
                if(t == true || t == null){
                  }
                },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: restaurantes.length,
            itemBuilder: (context, index){
              final r = restaurantes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child:  ListTile(
                  title:  Text(r.nome?? 'Sem nome'),
                  subtitle:  Text('ID: ${r.codigo}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     IconButton(
                      onPressed: (){
                        //Codigo para Editar Restaurante
                  },
                        icon: Icon(Icons.edit, color: Colors.blue)
                    ),
                      IconButton(
                          onPressed: (){
                            //Codigo para EXCLUIR Restaurante
                            AlertDialog(
                              title:  Text("Confirmar ação"),
                              content: Text("Deseja realmente exluir?"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {

                                      //Código para excluir o registro
                                    },
                                    child: Text("sim")
                                    ),
                                TextButton(
                                onPressed: (){
                            },
                            child: Text("não")
                                ),
                            ],
                            );
                            },
                     icon: Icon(Icons.delete, color: Colors.red)
                ),
                    ],
                ),
              ),
              );
            }
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TelaCadRestaurante()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}