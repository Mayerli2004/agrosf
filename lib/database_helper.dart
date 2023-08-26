import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Agrosf{
  final int id;
  final String name;
  final double price;
  final String imagePath;

  Agrosf({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });
}

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        dates TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        profile TEXT NOT NULL
      )
    ''');
    //creacion de la tabla de los animales

     await db.execute('''
      CREATE TABLE animals (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');
    await db.insert('users',
     {
      'dates':'aguacate',
      'username':'aguacate1',
      'password':'aguacate123',
      'profile': 'aguacate'
     },
    );
    await db.insert(
  'users',
  {
    'dates': 'cacao',
    'username': 'cacao2',
    'password': 'cacao123',
    'profile': 'cacao',
  },
);
await db.insert(
  'users',
  {
    'dates': 'piña',
    'username': 'piña3',
    'password': 'piña123',
    'profile': 'piña',
  },
);
await db.insert(
  'users',
  {
    'dates': 'guayaba',
    'username': 'guayaba4',
    'password': 'guayaba123',
    'profile': 'guayaba',
  },
);
  }  
   
  

  // Agregar el método para obtener la lista de animales
  Future<List<Agrosf>>getAgrosf()async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('agrosf');
     return List.generate(maps.length, (i){
      return Agrosf(
        id: maps[i]['id'],
        name: maps[i]['name'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
      );

    });
  }
  Future<void> insertAgrosf(Agrosf agrosf) async {
    final db = await database;
    await db.insert(
      'agrosf',
      {
        'name': agrosf.name,
        'price': agrosf.price,
        'imagePath': agrosf.imagePath,
      },
    );
  }
}
