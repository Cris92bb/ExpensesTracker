import 'package:sqflite/sqflite.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';

final String tableExpenses  = "expences";
final String columnId       =      "_id";
final String columnDate     =     "date";
final String columnAmmount  =  "ammount";
final String columnNote     =     "note";
final String columnIcon     =     "icon";

class ExpensesProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 6,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableExpenses ( 
  $columnId integer primary key autoincrement, 
  $columnDate string not null,
  $columnAmmount double not null,
  $columnNote string,
  $columnIcon string)
''');
    });
  }

  Future<SingleExpense> insert(SingleExpense expense) async {
    if(expense == null)
      return null;
    expense.id = await db.insert(tableExpenses, expense.toMap());
    return expense;
  }

  Future<SingleExpense> getExpense(int id) async {
    List<Map> maps = await db.query(tableExpenses,
        columns: [columnId, columnDate, columnAmmount,columnIcon,columnNote],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new SingleExpense.fromMap(maps.first);
    }
    return null;
  }

  
  Future<List<SingleExpense>> getAllExpenses() async {
    List<Map> maps = await db.query(tableExpenses,
        columns: [columnId, columnDate, columnAmmount,columnIcon,columnNote]);
    if (maps.length > 0) {
      return SingleExpense.fromMultipleMap(maps);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableExpenses, where: "$columnId = ?", whereArgs: [id]);
  }

  Future<int> update(SingleExpense todo) async {
    return await db.update(tableExpenses, todo.toMap(),
        where: "$columnId = ?", whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}