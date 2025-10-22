
import 'package:flutter/material.dart';
import 'banco/restaurante_DAO.dart';
import 'banco/tipo_DAO.dart';
import 'restaurante.dart';
import 'tipo.dart';

class TelaEditRestaurante extends StatefulWidget {
  static Restaurante restaurante = Restaurante(); //atributo estático

  @override
  State<StatefulWidget> createState() {
    return TelaEditRestauranteState();
  }
}

class TelaEditRestauranteState extends State<TelaEditRestaurante>{

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController cdController = TextEditingController();
  int? codigo = TelaEditRestaurante.restaurante.codigo as int;
  String? culinariaSelecionada;

  List<Tipo> tiposCulinaria = [];
  int? tipoCulinaria;

  void initState(){
    super.initState();
    carregarTipos();
    nomeController.text = TelaEditRestaurante.restaurante.nome!;
    latitudeController.text = TelaEditRestaurante.restaurante.latitude.toString()!;
    longitudeController.text = TelaEditRestaurante.restaurante.longitude.toString()!;
    tipoCulinaria = TelaEditRestaurante.restaurante.cutinaria?.codigo;
    culinariaSelecionada = TelaEditRestaurante.restaurante.cutinaria?.descricao!;
  }

  Future<void> carregarTipos() async{
    final lista = await TipoDAO.listarTipos();
    setState(() {
      tiposCulinaria = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atualizar Restaurante')),
      body: Padding(padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Informações do Restaurante:"),
            SizedBox(height: 30),
            Text('CODIGO'),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Codigo'),
              controller: cdController,
              validator:  (String? value){},
              enabled: false,

            ),
            Text("Tipo de Comida: "),
            DropdownButtonFormField<String>(
                value: culinariaSelecionada,
                items: tiposCulinaria.map((tipo){
                  return DropdownMenuItem<String>(
                    value: tipo.descricao,
                    child: Text("${tipo.descricao}"),
                  );
                }).toList(),
                onChanged: (String? novaCulinaria){
                  setState(() {
                    culinariaSelecionada = novaCulinaria;
                    Tipo tipoSelecionado = tiposCulinaria.firstWhere(
                          (tipo) => tipo.descricao == novaCulinaria,
                    );
                    tipoCulinaria = tipoSelecionado.codigo;
                  });
                }
            ),

            TextFormField(
              decoration: const InputDecoration(hintText: 'Nome  do Restaurante'),
              validator: (String? value) {},
              controller: nomeController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Latitude'),
              validator: (String? value) {},
              controller: latitudeController,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Longitude'),
              validator: (String? value) {},
              controller: longitudeController,
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () async{
                  final sucesso = await RestauranteDAO.cadastrarRestaurante(
                      nomeController.text,
                      latitudeController.text,
                      longitudeController.text,
                      tipoCulinaria
                  );
                  String msg = 'ERRO: restaurante não cadastrado.';
                  Color corFundo = Colors.red;
                  if(sucesso > 0 ){
                    //sucesso é o ID do restaurante cadastrado, que será maior que 0(zero)
                    msg = '"${nomeController.text}" cadastrado! ID: $sucesso';
                    corFundo = Colors.green;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(msg),
                        backgroundColor: corFundo,
                        duration: Duration(seconds: 5),
                      )
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save),
                    Text("Salvar")
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}