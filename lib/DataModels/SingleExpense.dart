final String tableExpenses  = "expences";
final String columnId       =      "_id";
final String columnDate     =     "date";
final String columnAmmount  =  "ammount";
final String columnNote     =     "note";
final String columnIcon     =     "icon";

class SingleExpense {
  int id;
  DateTime date;
  double ammount;
  String note;
  String icon;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{

      columnDate    : parseDate(date),
      columnAmmount : ammount,
      columnNote    : note,
      columnIcon    : icon
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  SingleExpense();

  SingleExpense.fromMap(Map<String, dynamic> map) {
    id        = map[columnId];
    date      = parseStringDate(map[columnDate]);
    ammount   = map[columnAmmount];
    note      = map[columnNote];
    icon      = map[columnIcon];

  }

    static List<SingleExpense> fromMultipleMap(List<Map<String, dynamic>> maps) {
      List<SingleExpense> expenses = new List();
        for(var map in maps ){
            var newExpense = SingleExpense.fromMap(map);
            expenses.add(newExpense);
        }
        expenses.sort((a, b) => a.date.compareTo(b.date) );
        return expenses;
    }

    @override 
    String toString() {
        return  "Expense: "+ammount.toString()+" on date: "+date.year.toString();
      }
}

String parseDate(DateTime date){
  var day   =   date.day.toString();
  var year  =  date.year.toString();
  var month = date.month.toString();
  return year+"-"+month+"-"+day;
}

DateTime parseStringDate(String date){
  var splitted = date.split("-");
  var day   =   int.parse(splitted[2]);
  var year  =   int.parse(splitted[0]);
  var month =   int.parse(splitted[1]);
  DateTime dt = new DateTime.utc(year,month,day);
  return dt;
}