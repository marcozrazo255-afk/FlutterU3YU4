import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Basedatoshelper {
  static final Basedatoshelper _instance = Basedatoshelper._internal();
  factory Basedatoshelper() => _instance;

  Basedatoshelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'usuarios.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE usuarios(
             id INTEGER PRIMARY KEY AUTOINCREMENT,
             usuario TEXT NOT NULL,
             password TEXT NOT NULL
            )
          ''');
      },
    );
  }

  Future<int> insertar(String usuario, String password) async {
    final db = await database;
    return await db.insert('usuarios', {
      'usuario': usuario,
      'password': password,
    });
  }

  Future<List<Map<String, dynamic>>> obtenerUsuario() async {
    final db = await database;
    return await db.query('usuarios');
  }

  Future eliminar(int id) async {
    final db = await database;
    return await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> modificar(int nid, String nusuario, String npassword) async {
    final db = await database;
    return await db.update(
      'usuarios',
      {'usuario': nusuario, 'password': npassword},
      where: 'id = ?',
      whereArgs: [nid],
    );
  }
}
