import 'package:sqflite/sqflite.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';

final String tableExpenses = "expences";
final String columnId = "_id";
final String columnDate = "date";
final String columnAmmount = "ammount";
final String columnNote = "note";
final String columnIcon = "icon";

class ExpensesProvider {
  //added Database as sttic so no need to reopen it everytime when use Provider
  static Database? db; // Made nullable

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table $tableExpenses ( 
  $columnId integer primary key autoincrement, 
  $columnDate text not null,
  $columnAmmount real not null,
  $columnIcon text not null,
  $columnNote text not null)
''');
      },
    );
  }

  Future<SingleExpense> insert(SingleExpense expense) async {
    // Ensure db is not null before using
    expense.id = await db!.insert(tableExpenses, expense.toMap());
    return expense;
  }

  Future<SingleExpense?> getExpense(int id) async {
    // Return type is nullable
    // Ensure db is not null
    if (db == null) return null;
    List<Map<String, Object?>> maps = await db!.query(
      tableExpenses,
      columns: [columnId, columnDate, columnAmmount, columnIcon, columnNote],
      where: "$columnId = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      // Use isNotEmpty
      // Cast the map if necessary, though fromMap should handle Map<String, Object?> if values are compatible
      return SingleExpense.fromMap(maps.first);
    }
    return null;
  }

  Future<List<SingleExpense>> getAllExpenses() async {
    // Return non-nullable list
    // Ensure db is not null
    if (db == null) return [];
    List<Map<String, Object?>> maps = await db!.query(
      tableExpenses,
      columns: [columnId, columnDate, columnAmmount, columnIcon, columnNote],
    );
    if (maps.isNotEmpty) {
      // Use isNotEmpty
      // Cast each map in the list
      return SingleExpense.fromMultipleMap(maps.map((map) => map).toList());
    }
    return []; // Return empty list instead of null
  }

  Future<int> delete(int id) async {
    // Ensure db is not null
    if (db == null) return 0;
    return await db!.delete(
      tableExpenses,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(SingleExpense todo) async {
    // Ensure db is not null and todo.id is not null
    if (db == null || todo.id == null) return 0;
    return await db!.update(
      tableExpenses,
      todo.toMap(),
      where: "$columnId = ?",
      whereArgs: [todo.id],
    );
  }

  Future close() async => db?.close(); // Use null-aware access
}
