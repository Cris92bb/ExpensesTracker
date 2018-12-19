import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class BottomSaveButton extends StatelessWidget{
  
  final dynamic onSave;
  final String text;

  BottomSaveButton({this.text,this.onSave});


  Widget build(context){
    var width = MediaQuery.of(context).size.width;
    return 
      new Expanded(
      child:new Container(
        alignment: Alignment.bottomCenter,
        child:
        new MaterialButton(
          minWidth: width,
          child: new Text(text, style: TextStyle(color: Theme.of(context).primaryColorDark),),
          color: Colors.lightGreen,
          onPressed: onSave,
        ),
      )
    );
  }
}



