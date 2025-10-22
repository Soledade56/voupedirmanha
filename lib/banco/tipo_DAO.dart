import 'package:soledade/banco/database_helper.dart';
import 'package:soledade/tipo.dart';

class TipoDAO{

  static Future<List<Tipo>> listarTipos() async{

  final db = await DatabaseHelper.getDatabase();
  final resultado = await db.query('tb_tipo');

  return resultado.map((mapa){
  return Tipo(
  codigo: mapa['cd_tipo'] as int,
  descricao: mapa['nm_tipo'] as String
  );
  }).toList();
  }

  static Future<Tipo> listar(int? id) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_tipo',
        where: 'cd_tipo = ?',
        whereArgs: [id]
    );
    return Tipo(
        codigo: resultado.first['cd_tipo'] as int,
        descricao: resultado.first['nm_tipo'] as String
    );
  }
}