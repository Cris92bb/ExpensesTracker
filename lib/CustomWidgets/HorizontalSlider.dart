

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HorizontalSlider extends StatefulWidget{

   String        total;
   String     currency;
   String    remaining;
   int         payDate;
   

   HorizontalSlider(givenTotal,givenCurrency, givenRemaining,givenPayDay){
     total      =     givenTotal.toStringAsFixed(2)+" "+givenCurrency;

     currency   =                                       givenCurrency;
     remaining  = givenRemaining.toStringAsFixed(2)+" "+givenCurrency;
     payDate    = givenPayDay;
  }

  @override

  _HorizontalSlider createState() =>  _HorizontalSlider();
}



class _HorizontalSlider extends State<HorizontalSlider> {
  

  double minimalHeigth    = 36;
  double maximisedHeigth  = 90;


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

    return GestureDetector(
      onVerticalDragUpdate: (event){
        if(!maximised && event.delta.dy > 10)
          maximiseHeigth();
        else if(maximised && event.delta.dy < -5)
          maximiseHeigth();
      },

      child: Container(
      height: maximised ? maximisedHeigth : minimalHeigth,
      padding: EdgeInsets.all(5),
      color: Colors.transparent,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

            maximised ? 
            Container(
              alignment: Alignment.topCenter,
              child:
                Center(

                  child:  Text(calculateDaysLeft(widget.payDate).toString()+" days remaining")
                ),
            ):
            Container(), //empty
            
            
            

            Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Row(
            children: <Widget>[
              Container(
                child: 
                 Row( 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     Text(
                      'Total: ', 
                    ),
                     Text(
                      widget.total, 
                    ),
                    ],
                  ),
                width: width * 0.50,
                ),

                Container(
                  child:   Row (
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      Text('Left: ', 
                      ),
                      Text(
                        widget.remaining, 
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

  if(date==null)date=30;
  var now = DateTime.now();
  var payDate = DateTime(now.year,now.month, date);

  if(payDate.isBefore(now)){

    if(now.month== 12){

      now =  DateTime(now.year+1,1,date);
    }else{
      now =  DateTime(now.year,now.month+1,date);
    }

    var span = dateDifferenceInDays(payDate,DateTime.now());
    return span;
  }else{
    return payDate.difference(now).inDays;
  }
}


dateDifferenceInDays(DateTime from,DateTime to){
  int daysFrom = from.day;

  var daysTo   = DateTime(to.year,to.month,0);
  print(daysTo.day - to.day);

  return daysFrom + daysTo.day-to.day;
}
