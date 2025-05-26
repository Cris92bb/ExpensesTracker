import 'package:flutter/material.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';
import 'package:expences_calculator/Helpers/IconConstants.dart';
import '../Views/ExpenseDetails.dart';
import '../Views/CreateExpense.dart';

class ExpensesList extends StatefulWidget {
  final List<SingleExpense> expenses; // Made final
  final String currency; // Explicitly String and final

  ExpensesList({
    required this.expenses,
    required this.currency,
  }); // Use required

  @override
  _ExpensesList createState() => _ExpensesList();
}

class _ExpensesList extends State<ExpensesList> {
  // initState is fine as is.
  // var icons = getIcons(); // This might be better inside build or as a final field if icons don't change

  @override
  Widget build(context) {
    final iconsMap = getIcons(); // Get icons map

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (_, int index) {
          final expense = widget.expenses[index];
          // Ensure icon string is not null, provide a default or handle null in getIcon if necessary
          final iconName =
              expense.icon ??
              ""; // Assuming empty string if icon is null, or handle differently
          final iconData = getIcon(iconName); // getIcon now returns IconData?
          return EachList(expense, widget.currency, iconData);
        },
        itemCount: widget.expenses.length, // expenses list is non-nullable
      ),
    );
  }
}

class EachList extends StatelessWidget {
  final SingleExpense expence;
  final String currency;
  final IconData? icon; // IconData can be nullable

  EachList(this.expence, this.currency, this.icon); // Constructor remains

  @override
  Widget build(BuildContext context) {
    // Handle nullable date and ammount for display
    final displayAmmount = (expence.ammount ?? 0.0).toStringAsFixed(2);
    final displayDate = expence.date != null
        ? '${expence.date!.day}/${expence.date!.month}/${expence.date!.year}'
        : 'N/A';

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: ListTile(
        onLongPress: () {
          // Ensure expense object is passed correctly, CreateExpense might need null safety updates
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateExpense(expense: expence),
            ),
          );
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExpenseDetails(selectedExpense: expence, currency: currency),
            ),
          );
        },
        title: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.lightGreen,
            ), // Icon widget handles null IconData gracefully
            Container(width: 20),
          ],
        ),
        trailing: Text(
          "$displayAmmount $currency",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(displayDate, style: TextStyle(fontSize: 10)),
      ),
    );
  }
}
