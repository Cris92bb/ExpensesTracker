import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DataModels/SingleExpense.dart';
import '../Helpers/IconConstants.dart';
import './CreateExpense.dart';

class ExpenseDetails extends StatelessWidget{
  final SingleExpense selectedExpense;
  final String currency;
  ExpenseDetails(this.selectedExpense,this.currency);

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
        new Text(
          "Single Expense",
          style: new TextStyle(
            color: Theme.of(context).primaryColorLight
          ),
        ),
         actions: <Widget>[
           new IconButton(
             color: Theme.of(context).primaryColorLight,
             icon: new Icon(Icons.edit),
             tooltip: "Edit",
             onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => new CreateExpense(expense: selectedExpense,)));
             },
           )
         ]
      ),
      body:
      new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Center(
            child:
            new Icon(
              getIcon(selectedExpense.icon),
              size: 100,
              color: Colors.lightGreen,
            )
          ),
          new Container(
            alignment: AlignmentDirectional.center,
            height: heigth / 5 ,
            child: new Text(
              selectedExpense.ammount.toStringAsFixed(2)+" "+currency,
              style:new TextStyle(
                    color: Theme.of(context).primaryColorLight, 
                    fontFamily: 'Mogra',
                    fontSize: 30
              )
            ),
          ),
          new Center(
            child: new Text(
              selectedExpense.note
            ),
          )
        ],
      ),
    );
  }
}