import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';
import 'package:expences_calculator/Helpers/IconConstants.dart';
import '../Views/ExpenseDetails.dart';
import '../Views/CreateExpense.dart';

class ExpensesList extends StatefulWidget{

  var expenses = List<SingleExpense>();
  var currency;
  ExpensesList(List<SingleExpense> list, String givenCurrency){
    expenses = list;
    currency = givenCurrency;
  }

  @override
  _ExpensesList createState() => new _ExpensesList();

}





class _ExpensesList extends State<ExpensesList> {

  @override
  initState(){
    super.initState();
  }
  var icons = getIcons();
  Widget build(context){
  var width = MediaQuery.of(context).size.width;
  var heigth = MediaQuery.of(context).size.height-250;

    return new Expanded(
      child: new ListView.builder(
        padding:EdgeInsets.symmetric(horizontal: 20),
        reverse: false,
        itemBuilder: (_,int index) {
          if(widget.expenses==null) 
            return null;
          else
            return EachList(widget.expenses[index],widget.currency, icons[widget.expenses[index].icon]);
          },
          itemCount:widget.expenses == null ? 1 : widget.expenses.length ,
      )
    );
  }
}

class EachList extends StatelessWidget{
  final SingleExpense expence;
  final String currency;
  final IconData icon;
  EachList(this.expence,this.currency,this.icon);
  @override
  Widget build(BuildContext context) {
    return new Container(
      
      decoration: BoxDecoration(
        border: new Border(
          bottom: new BorderSide(color: Colors.grey)
          )
        ),
      child: new ListTile(
        onLongPress: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => new CreateExpense(expense: expence,)));
        },
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenseDetails(expence,currency)));
        },
        title: 
        new Row(
          children: <Widget>[
            new Icon(icon, color: Colors.lightGreen,),
            new Container(
              width: 20,
            ),
            ],
        ),
        trailing: new Text(
          expence.ammount.toStringAsFixed(2)+" "+currency,
          style: TextStyle(color: Theme.of(context).primaryColorLight,
          fontSize: 20,
          fontWeight:FontWeight.bold),
        ),
        subtitle:new Text(
          expence.date.day.toString()+'/'+expence.date.month.toString()+'/'+expence.date.year.toString(),
          style: new TextStyle(color:Theme.of(context).primaryColorLight, fontSize: 10),
        ),
      )
    );
  }
}