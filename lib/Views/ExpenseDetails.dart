import 'package:flutter/material.dart';
import '../DataModels/SingleExpense.dart';
import '../Helpers/IconConstants.dart';
import './CreateExpense.dart';
import '../Helpers/DatabaseHelper.dart';

class ExpenseDetails extends StatelessWidget{
  final SingleExpense selectedExpense;
  final String currency;
  ExpenseDetails({required this.selectedExpense, required this.currency, Key? key}) : super(key: key);
  final ExpensesProvider provider = ExpensesProvider(); // Initialize here or pass via constructor if preferred
  
  @override
  Widget build(context){

    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height-100;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorLight, 
        ),
        title:
        Text( // Removed 'new'
          "Single Expense",
          style: TextStyle( // Removed 'new'
            color: Theme.of(context).primaryColorLight
          ),
        ),
         actions: <Widget>[
           IconButton( // Removed 'new'
             color: Theme.of(context).primaryColorLight,
             icon: const Icon(Icons.edit), // Added const
             tooltip: "Edit",
             onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => CreateExpense(expense: selectedExpense,))); // Removed 'new'
             },
           ),
          IconButton( // Removed 'new'
             color: Theme.of(context).primaryColorLight,
             icon: const Icon(Icons.delete), // Added const
             tooltip: "Delete",
             onPressed: (){
               if (selectedExpense.id != null) {
                 provider.delete(selectedExpense.id!);
               }
               Navigator.pop(context,true);
             },
           )
         ]
      ),
      body:
      Column( // Removed 'new'
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center( // Removed 'new'
            child:
            Icon( // Removed 'new'
              getIcon(selectedExpense.icon ?? ""), // Handle null icon string
              size: 100,
              color: Colors.lightGreen,
            )
          ),
          Container( // Removed 'new'
            alignment: AlignmentDirectional.center,
            height: heigth / 5 ,
            child: Text( // Removed 'new'
              "${(selectedExpense.ammount ?? 0.0).toStringAsFixed(2)} $currency", // Handle null ammount
              style: TextStyle( // Removed 'new'
                    color: Theme.of(context).primaryColorLight, 
                    fontFamily: 'Mogra',
                    fontSize: 30
              )
            ),
          ),
          Center( // Removed 'new'
            child: Text( // Removed 'new'
              selectedExpense.note ?? "", // Handle null note
            ),
          )
        ],
      ),
    );
  }
}