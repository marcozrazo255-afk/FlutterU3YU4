import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Basedatoshelper {
  // 1) Singleton: misma instancia en toda la app.
  static final Basedatoshelper _instance = Basedatoshelper._internal();
  factory Basedatoshelper() => _instance;
  Basedatoshelper._internal();

  // 2) Referencia a la BD (perezosa).
  Database? _database;

  // 3) Getter: abre o devuelve la BD existente.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // 4) Inicialización: crear/abrir archivo 'abarrotes.db'.
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'abarrotes.db');

    // 4.1) Abrir BD, crear tabla si versión 1.
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // 4.2) Esquema corregido: clave primaria autoincremental en 'id' y 'codigo' único.
        await db.execute('''
          CREATE TABLE productos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            codigo TEXT NOT NULL UNIQUE,
            nombre TEXT NOT NULL,
            precio REAL NOT NULL
          )
        ''');
      },
    );
  }

  // 5) Inserción: devuelve el id del nuevo registro.
  Future<int> insertar(String codigo, String nombre, String precio) async {
    final db = await database;

    // 5.1) Convertir precio a número para esquema REAL.
    final precioNum = double.tryParse(precio) ?? 0.0;

    return await db.insert(
      'productos',
      {'codigo': codigo, 'nombre': nombre, 'precio': precioNum},
      // 5.2) En caso de 'codigo' duplicado, fallará con excepción (capturada en UI).
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // 6) (Opcional) Obtener todos los productos.
  Future<List<Map<String, dynamic>>> obtenerProductos() async {
    final db = await database;
    return await db.query('productos', orderBy: 'id DESC');
  }

  // 7) (Opcional) Eliminar por id.
  Future<int> eliminar(int id) async {
    final db = await database;
    return await db.delete('productos', where: 'id = ?', whereArgs: [id]);
  }

  // 8) (Opcional) Actualizar nombre y precio por código.
  Future<int> modificarPorCodigo(
    String codigo,
    String nombre,
    double precio,
  ) async {
    final db = await database;
    return await db.update(
      'productos',
      {'nombre': nombre, 'precio': precio},
      where: 'codigo = ?',
      whereArgs: [codigo],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
}
