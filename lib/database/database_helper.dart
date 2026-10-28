
import 'package:lilacexpensetracker/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {

DatabaseHelper._pvrContr();

static final DatabaseHelper instance = DatabaseHelper._pvrContr();

static Database? _database;

Future<Database> get database async {
    if (_database!= null) return _database!;

    _database = await _initDataBase();


    return _database!;
  }

Future<Database> _initDataBase() async {
    final databasePath = await getDatabasesPath();


    final path = p.join(databasePath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }


Future<void> _createDatabase(
      Database db, int version) async {
    await db.execute('''
  CREATE TABLE expenses (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    amount REAL NOT NULL,
    category TEXT NOT NULL,
    date TEXT NOT NULL,
    description TEXT
  )
''');
  }


  // thisfortheadd expense

 Future<int> addExpense(ExpenseModel expense) async {
  final db = await database;

  return await db.insert(
    'expenses',
    expense.toMap(),
  );
}

 // wellthis for the gettheexpense where we add
Future<List<ExpenseModel>> getExpenses() async {
  final db = await database;

  final data = await db.query('expenses');

  return data.map((item) => ExpenseModel.fromMap(item)).toList();
}

//this for the upfatethe adddata
Future<int> updateExpense(ExpenseModel expense) async {
  final db = await database;

  return await db.update(
    'expenses',
    expense.toMap(),
    where: 'id = ?',
    whereArgs: [expense.id],
  );
}

Future<int> deleteExpense(int id) async {
  final db = await database;

  return await db.delete(
    'expenses',
    where: 'id = ?',
    whereArgs: [id],
  );
}


 
}
