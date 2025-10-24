import 'database_helper.dart';
import '../usuario.dart';


class UsuarioDAO{
  static Usuario usuarioLogado = Usuario();
static Future<bool> autenticar(String login, String senha) async {
  final db = await DatabaseHelper.getDatabase();

  final resultado = await db.query(
    'tb_usuario',
    where: 'nm_login = ? and ds_senha = ?',
    whereArgs: [login,senha]
  );
  usuarioLogado.codigo = resultado.first['cd_usuario'] as int;
  usuarioLogado.nome = resultado.first['nm_usuario'] as String;

    return resultado.isNotEmpty;

  }

  static Future<int> cadastrarUsuario (
      String? nome,
      String? login,
      String? senha,
      ) async {
    final db = await DatabaseHelper.getDatabase();
    final dadosUsuario = {
      'nm_usuario': nome,
      'nm_login': login,
      'ds_senha': senha,
    };
    try {
      final  nm_Usuario= await db.insert('tb_Usuario', dadosUsuario);
      return nm_Usuario;
    } catch (e) {
      print("Erro ao cadastrar usuario: $e");
      return -1;
    }
  }
}