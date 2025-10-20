
import 'package:soledade/banco/tipo_DAO.dart';
import 'database_helper.dart';
import 'usuario_dao.dart';
import '../restaurante.dart';

class RestauranteDAO {

  static Future<void> atualizarRestaurante(
      int? cd,
      String? nome,
      String? latitude,
      String? longitude,
      int? tipo

      ) async{
    final db = await DatabaseHelper.getDatabase();

    final resultado = await db.update('tb_restaurante',
        {
          'nm_restaurante': nome,
          'latitude_restaurante': latitude,
          'longitude_restarurante': longitude,
          'cd_tipo': tipo
        },
        where: 'cd_restaurante = ?',
        whereArgs: [cd]

    );
}

  static Future<Restaurante> listar(int? id) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_restaurante',
        where: 'cd_restaurante = ?',
        whereArgs: [id]
    );

    return Restaurante(
      codigo: resultado.first['cd_restaurante'] as int,
      nome: resultado.first['nm_restaurante'] as String,
      latitude: resultado.first['latitude_restaurante'] as String,
      longitude: resultado.first['longitude_restaurante'] as String,
      culinaria: await TipoDAO.listar(resultado.first['cd_tipo'] as int),

    );

  }

  static Future<void> excluir(Restaurante r) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.delete('tb_restaurante',
        where: 'cd_restaurante = ?',
        whereArgs: [r.codigo]
    );
  }

  static Future<List<Restaurante>> listarTodos() async {
    final db =  await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_restaurante',
        where: 'cd_usuario = ?',
        whereArgs: [UsuarioDAO.usuarioLogado.codigo]
    );
    return resultado.map((mapa){
      return Restaurante(
          codigo: mapa['cd_restaurante'] as int,
          nome: mapa['nm_restaurante'] as String
      );
    }).toList();
  }

  static Future<int> cadastrarRestaurante (
      String? nomeRestaurante,
      String? latitude,
      String? longitude,
      int? tipo
      ) async{
    final db = await DatabaseHelper.getDatabase();
    final dadosRestaurante = {
      'cd_tipo': tipo,
      'nm_restaurante': nomeRestaurante,
      'latitude_restaurante': latitude,
      'longitude_restaurante': longitude,
      'cd_usuario': UsuarioDAO.usuarioLogado.codigo
    };
    try{
      final idRestaurante = await db.insert('tb_restaurante', dadosRestaurante);
      return idRestaurante;
    } catch(e){
      print("Erro ao cadastrar restaurante: $e");
      return -1;
    }
  }

}