import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';
import 'package:expences_calculator/CustomWidgets/BottomSaveButton.dart';
import 'package:expences_calculator/CustomWidgets/IconsBottomSheet.dart';



class CreateExpense extends StatefulWidget{

  SingleExpense expense;
  CreateExpense({this.expense});
  @override
  _CreateExpense createState() => new _CreateExpense();

}


class _CreateExpense extends State<CreateExpense>{
  

  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  DateTime date;
  TextEditingController ammountController;
  TextEditingController noteController;
  int ammount;
  String note;
  String icon;
  
  @override 
  void initState() {
      if(widget.expense != null){
        var temp = widget.expense;
        ammountController = new TextEditingController(text: temp.ammount.toString());
        noteController    = new TextEditingController(text: temp.note.toString());
        icon = temp.icon;
        date = temp.date;
      }else{
        ammountController = new TextEditingController();
        noteController    = new TextEditingController();
      }
      // TODO: implement initState
      super.initState();
  }

  @override
  void dispose() {
      ammountController.dispose();
      // TODO: implement dispose
      super.dispose();
  }


  onSave(){
    var tempExpense;
    if(widget.expense==null){
      tempExpense = new SingleExpense();
    }else{
      tempExpense = widget.expense;
    }

    tempExpense.ammount = double.parse(ammountController.text);
    tempExpense.date    = date == null ? DateTime.now() : date;
    tempExpense.icon    = icon;
    tempExpense.note    = noteController.text;
    //replace with save
    Navigator.pop(context,tempExpense);
  }

  onIconSelect(String text){
    icon = text;
  }


  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("New Expense", style: new TextStyle(color: Theme.of(context).primaryColorLight),),
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorLight, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: 
      new Container(
        padding: EdgeInsets.all(10),
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DateTimePickerFormField(
                format: dateFormat,
                decoration: InputDecoration(labelText: 'Date'),
                onChanged: (dt) => setState(() => date = dt),
                initialValue: widget.expense != null ? widget.expense.date : DateTime.now(),
              ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Ammount',
              ),
              keyboardType:TextInputType.number,
              controller: ammountController,
            ),
            new Container(
              margin:EdgeInsets.only(top: 10),
              child:
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                  ),
                  labelText: 'Note',
                ),
                controller: noteController,
              ),
            ),
            new IconsBottomSheet(onPressed: onIconSelect, icon: icon),
            //Bottom Save Button
            new BottomSaveButton(text: "Save Expense", onSave: onSave)
          ],
        ),
      )
    );
  }
}




