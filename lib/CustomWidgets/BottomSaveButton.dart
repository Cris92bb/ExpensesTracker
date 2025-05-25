import 'package:flutter/material.dart';





class BottomSaveButton extends StatelessWidget{
  
  final VoidCallback onSave;
  final String text;

  BottomSaveButton({required this.text, required this.onSave});


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



