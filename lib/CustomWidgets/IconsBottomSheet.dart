
import 'package:flutter/material.dart';
import 'package:expences_calculator/Helpers/IconConstants.dart';





class IconsBottomSheet extends StatefulWidget{
  dynamic  onPressed;
  String   icon;
  IconsBottomSheet({this.onPressed, this.icon});

  _IconsBottomSheet createState() =>  _IconsBottomSheet();


}

class _IconsBottomSheet extends State<IconsBottomSheet>{
 int selectedIndex;


 var icons = getIcons();
 Widget build(context){
     return Expanded( 
            child: GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemBuilder: (_,index){
                  var value =  icons.values.elementAt(index);
                  var key   =  icons.keys.elementAt(index);
                  return IconButton(
                    color: widget.icon == key ? Colors.lightGreen : Theme.of(context).primaryColorLight,
                    icon: Icon(value),
                    onPressed:(){
                      widget.onPressed(key);
                      setState(() {
                        widget.icon = key;               
                      });
                    }
                  );
              },
              itemCount: icons.length,
          )
     );
 }
}

