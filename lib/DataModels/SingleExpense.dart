final String tableExpenses = "expences";
final String columnId = "_id";
final String columnDate = "date";
final String columnAmmount = "ammount";
final String columnNote = "note";
final String columnIcon = "icon";

class SingleExpense {
  int? id;
  DateTime? date;
  double? ammount;
  String? note;
  String? icon;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnDate: date != null ? parseDate(date!) : null,
      columnAmmount: ammount,
      columnNote: note,
      columnIcon: icon,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SingleExpense({this.id, this.date, this.ammount, this.note, this.icon});

  SingleExpense.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    date = map[columnDate] != null ? parseStringDate(map[columnDate]) : null;
    ammount = map[columnAmmount];
    note = map[columnNote];
    icon = map[columnIcon];
  }

  static List<SingleExpense> fromMultipleMap(List<Map<String, dynamic>> maps) {
    List<SingleExpense> expenses =
        []; // Already fixed in a previous step, ensure it's []
    for (var map in maps) {
      var newExpense = SingleExpense.fromMap(map);
      expenses.add(newExpense);
    }
    // Handle possible null dates before sorting
    expenses.sort((a, b) {
      if (a.date == null && b.date == null) return 0;
      if (a.date == null)
        return -1; // Or 1, depending on how you want to sort nulls
      if (b.date == null) return 1; // Or -1
      return a.date!.compareTo(b.date!);
    });
    return expenses;
  }

  @override
  String toString() {
    return "Expense: ${ammount?.toStringAsFixed(2) ?? 'N/A'} on date: ${date?.toIso8601String().substring(0, 10) ?? 'N/A'}";
  }
}

String parseDate(DateTime date) {
  // Parameter date is non-nullable
  var day = date.day.toString();
  var year = date.year.toString();
  var month = date.month.toString();
  return year + "-" + month + "-" + day;
}

DateTime parseStringDate(String date) {
  var splitted = date.split("-");
  var day = int.parse(splitted[2]);
  var year = int.parse(splitted[0]);
  var month = int.parse(splitted[1]);
  DateTime dt = new DateTime.utc(year, month, day);
  return dt;
}
