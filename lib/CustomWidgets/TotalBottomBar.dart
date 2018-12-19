import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalBottomBar extends StatefulWidget{
  var totalSpent;

  TotalBottomBar(var total,var currency){
    totalSpent = total.toStringAsFixed(2)+" "+currency;
  }

  _TotalBottomBar createState() => new _TotalBottomBar();
}


class _TotalBottomBar extends State<TotalBottomBar> {
  Widget build(context){
    var width = MediaQuery.of(context).size.width-20;
    var heigth = MediaQuery.of(context).size.height-200;
    return new Container(
      
      decoration: new BoxDecoration(
        border: new Border( top:
          new BorderSide(
             color: Colors.blueGrey
          )
        )
      ),
      padding: EdgeInsets.all(10),
      width: width+10,
      child:
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          new Container(
            width: width*0.4,
            child:
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Text(
                  'Total spent', 
                  style:
                  TextStyle( 
                    color: Theme.of(context).primaryColorLight, 
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          new Container(
            width: width*0.25,
            child:
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  widget.totalSpent, 
                  style: 
                  TextStyle(
                    color: Theme.of(context).primaryColorLight, 
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}