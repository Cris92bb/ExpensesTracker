

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HorizontalSlider extends StatefulWidget{

   String        total;
   String     currency;
   String    remaining;
   int         payDate;
   

   HorizontalSlider(givenTotal,givenCurrency, givenRemaining,givenPayDay){
     total      =     givenTotal.toStringAsFixed(2)+" "+givenCurrency;
     currency   =               givenCurrency;
     remaining  = givenRemaining.toStringAsFixed(2)+" "+givenCurrency;
     payDate    = givenPayDay;
  }

  @override
  _HorizontalSlider createState() => new _HorizontalSlider();
}



class _HorizontalSlider extends State<HorizontalSlider> {
  
  double minimalHeigth=36;
  double maximisedHeigth=90;


  bool maximised=false;

  maximiseHeigth(){
    setState(() {

          if(maximised){
            maximised = false;
          }else{
            maximised = true;
          }
    });
  }

  Widget build(context){
    var width = MediaQuery.of(context).size.width-50;




    return new GestureDetector(
      onVerticalDragUpdate: (event){
        if(!maximised && event.delta.dy > 10)
          maximiseHeigth();
        else if(maximised && event.delta.dy < -5)
          maximiseHeigth();
      },
      child:new Container(
      height: maximised ? maximisedHeigth : minimalHeigth,
      padding: EdgeInsets.all(5),
      color: Colors.transparent,
      // decoration: BoxDecoration(
      //   boxShadow: [new BoxShadow(color: Theme.of(context).primaryColorLight, blurRadius: 6, offset:  const Offset(0, 5))],
      //   border: new Border.all(
      //     color: Theme.of(context).primaryColorDark
      //   ),
      //   borderRadius:BorderRadius.vertical(bottom:Radius.circular(15)),
      //   color: Theme.of(context).primaryColorDark,
      // ),
      child:
      new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

            maximised ? 
            Container(
              alignment: Alignment.topCenter,
              child:
                Center(
                  child: new Text(calculateDaysLeft(widget.payDate).toString()+" days remaining")
                ),
            ):
            Container(), //empty
            
            
            
            new Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: 20,right: 20),
            child:new Row(
            children: <Widget>[
              new Container(
                child: 
                new Row( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      'Total: ', 
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight
                      ),
                    ),
                    new Text(
                      widget.total, 
                      style:  TextStyle(
                        color: Theme.of(context).primaryColorLight
                      ),
                    ),
                    ],
                  ),
                width: width * 0.50,
                ),
                new Container(
                  child:  new Row (
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      new Text('Left: ', 
                        style: TextStyle(
                          color: Theme.of(context).primaryColorLight
                        ),
                      ),
                      new Text(
                        widget.remaining, 
                        style:  TextStyle(
                          color: Theme.of(context).primaryColorLight
                        ),
                      ),
                    ]
                  ),
                  width: width * 0.50,
                ),
            ],
          )
        )
    ]
    )
  )
);
}
}

calculateDaysLeft(int date){
  var now = DateTime.now();
  var payDate = new DateTime(now.year,now.month, date);

  if(payDate.isBefore(now)){

    if(now.month== 12){
      now = new DateTime(now.year+1,1,date);
    }else{
      now = new DateTime(now.year,now.month+1,date);
    }

    var span = dateDifferenceInDays(payDate,DateTime.now());
    return span;
  }else{
    return payDate.difference(now).inDays;
  }
}


dateDifferenceInDays(DateTime from,DateTime to){
  int daysFrom = from.day;
  var daysTo  = new DateTime(to.year,to.month,0);
  print(daysTo.day - to.day);

  return daysFrom + daysTo.day-to.day;
}
