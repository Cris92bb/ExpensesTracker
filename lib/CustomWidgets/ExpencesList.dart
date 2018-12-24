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
  _ExpensesList createState() =>  _ExpensesList();

}





class _ExpensesList extends State<ExpensesList> {

  @override
  initState(){
    super.initState();
  }
  var icons = getIcons();

  Widget build(context){

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
  final SingleExpense   expence;
  final String         currency;
  final IconData           icon;

  EachList(this.expence,this.currency,this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey)
          )
        ),
      child: ListTile(
        onLongPress: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateExpense(expense: expence,)));
        },
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ExpenseDetails(expence,currency)));
        },
        title: 
         Row(
          children: <Widget>[
             Icon(icon, color: Colors.lightGreen,),
             Container(
              width: 20,
            ),
            ],
        ),
        trailing: Text(
          expence.ammount.toStringAsFixed(2)+" "+currency,
          style: TextStyle(
          fontSize: 20,
          fontWeight:FontWeight.bold),
        ),
        subtitle: Text(
          expence.date.day.toString()+'/'+expence.date.month.toString()+'/'+expence.date.year.toString(),
          style: TextStyle(fontSize: 10),
        ),
      )
    );
  }
}