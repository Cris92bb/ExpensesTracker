import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class BottomSaveButton extends StatelessWidget{
  
  final dynamic onSave;
  final String text;

  BottomSaveButton({this.text,this.onSave});


  Widget build(context){
    var width = MediaQuery.of(context).size.width;
    return Container(
        alignment: Alignment.bottomCenter,
        child:
         MaterialButton(
          minWidth: width,
          child: Text(text),
          color: Colors.lightGreen,
          onPressed: onSave,
        ),
    );
  }
}



