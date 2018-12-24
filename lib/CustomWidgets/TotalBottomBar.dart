import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalBottomBar extends StatefulWidget{
  var totalSpent;

  TotalBottomBar(var total,var currency){
    totalSpent = total.toStringAsFixed(2)+" "+currency;
  }


  _TotalBottomBar createState() => _TotalBottomBar();
}


class _TotalBottomBar extends State<TotalBottomBar> {
  Widget build(context){
    var width = MediaQuery.of(context).size.width-20;

    return Container(
      
      decoration: BoxDecoration(
        border: Border( top:
           BorderSide(
             color: Colors.blueGrey
          )
        )
      ),
      padding: EdgeInsets.all(10),
      width: width+10,
      child:

         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
            width: width*0.4,
            child:
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 Text(
                  'Total spent', 
                  style:
                  TextStyle( 
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),

           Container(
            width: width*0.25,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.totalSpent, 
                  style: 
                  TextStyle(
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