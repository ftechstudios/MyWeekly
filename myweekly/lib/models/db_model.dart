import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './transaction_db.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'todo.db';
    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDB);
    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount DOUBLE,
        date TEXT
      )
    ''');
    //isChecked INTEGER
  }

  Future<void> insertTodo(TransactionDBTodo transactionTodo) async {
    final db = await database;
    await db.insert(
      'todo', //the name of our table
      transactionTodo
          .toMap(), // the function we created in our TransactionTodo Model
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(TransactionDBTodo transactionTodo) async {
    final db = await database;
    await db.delete(
      'todo',
      where: 'id == ?',
      whereArgs: [transactionTodo.id],
    );
  }

  Future<int> update(TransactionDBTodo transactionTodo) async {
    final db = await database;

    return await db.update(
      'todo',
      transactionTodo.toMap(),
      where: 'id== ?',
      whereArgs: [transactionTodo.id],
    );
  }

  Future<List<TransactionDBTodo>> getTodo() async {
    final db = await database;

    List<Map<String, dynamic>> items = await db.query(
      'todo',
      orderBy: 'id DESC',
    );
    // double totalAmount = 0;

    return List.generate(
        items.length,
        (i) => TransactionDBTodo(
              id: items[i]['id'],
              title: items[i]['title'],
              amount: items[i]['amount'],
              date: DateTime.parse(items[i]['date']),
              //    isChecked: items[i]['isChecked'] == 1 ? true :false,
            ));
  }

  Future<List<TransactionDBTodo>> filterTodo() async {
    final db = await database;

    List<Map<String, dynamic>> items = await db.rawQuery(
        '''SELECT * FROM 'todo' WHERE date BETWEEN '2022-09-13' AND '2022-09-20' ORDER BY id DESC ''');

    return List.generate(
        items.length,
        (i) => TransactionDBTodo(
              id: items[i]['id'],
              title: items[i]['title'],
              amount: items[i]['amount'],
              date: DateTime.parse(items[i]['date']),
              //    isChecked: items[i]['isChecked'] == 1 ? true :false,
            ));
  }

  Future<List<TransactionDBTodo>> retrieveTaskList() async {
    final db = await database;
    final List<Map<String, Object?>> queryResult = await db.query('tasks');
    return queryResult.map((e) => TransactionDBTodo.fromMap(e)).toList();
  }

  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from todo');
    int? result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<dynamic> queryTodo() async {
    Database db = await database;
    var response = await db.query('todo');
    return response;
  }

  Future<dynamic> readQuery() async {
    Database db = await database;
    List<Map<String, Object?>> records = await db.query('todo');
    Map<String, Object?> mapRead = records.first;
    return mapRead;
  }

  Future<List<TransactionDBTodo>> getItems() async {
    final db = await database;
    final List<Map<String, Object?>> queryResult = await db.query('todo');
    return queryResult.map((e) => TransactionDBTodo.fromMap(e)).toList();
  }

  Future<TransactionDBTodo> getPersonWithId(int id) async {
    final db = await database;
    var response = await db.query("todo", where: "id = ?", whereArgs: [id]);
    return TransactionDBTodo.fromMap(response.first);
  }

  Future<List<TransactionDBTodo>> filterTodos() async {
    final db = await database;

    List<Map<String, dynamic>> items = await db.rawQuery(
        '''SELECT * FROM 'todo' WHERE date BETWEEN '2022-10-18' AND '2022-10-25' ORDER BY id DESC ''');

    return List.generate(
        items.length,
        (i) => TransactionDBTodo(
              id: items[i]['id'],
              title: items[i]['title'],
              amount: items[i]['amount'],
              date: DateTime.parse(items[i]['date']),
              //    isChecked: items[i]['isChecked'] == 1 ? true :false,
            ));
  }

  get fetchAndSet async {
    List items = await filterTodos();
    return items;
  }

  Future<List<Map<String, Object?>>> get getMapList async {
    Database db = await database;
    var response = await db.query('todo');
    return response;
  }

  Future<List<TransactionDBTodo>> getListItem() async {
    final db = await database;
    var response = await db.query("todo");

    List<TransactionDBTodo> eachItem = [];
    for (var i = 0; i < response.length; i++) {
      eachItem.add(TransactionDBTodo.fromMap(response[i]));
    }
    return eachItem.toList();
  }
}
