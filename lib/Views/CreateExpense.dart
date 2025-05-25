import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';
import 'package:expences_calculator/CustomWidgets/BottomSaveButton.dart';
import 'package:expences_calculator/CustomWidgets/IconsBottomSheet.dart';
import '../Helpers/DatabaseHelper.dart';



class CreateExpense extends StatefulWidget{

  final SingleExpense? expense; // Made nullable
  CreateExpense({this.expense, Key? key}) : super(key: key); // Added Key
  @override
  _CreateExpense createState() => _CreateExpense(); // Removed 'new'

}


class _CreateExpense extends State<CreateExpense>{
  

  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"); // Existing
  // ExpensesProvider provider = new ExpensesProvider(); // Initialize if needed, or make it accessible differently
  // For now, let's assume it's okay to create a new one or handle it via DI/service locator later.
  final ExpensesProvider provider = ExpensesProvider(); // Initialize

  DateTime? date; // Made nullable
  late TextEditingController ammountController; // Made late
  late TextEditingController noteController; // Made late
  // int? ammount; // Not directly used as state field, derived from controller
  // String? note; // Not directly used as state field, derived from controller
  String? icon; // Made nullable

  
  @override 
  void initState() {
      super.initState(); // super.initState() first
      
      ammountController = TextEditingController();
      noteController    = TextEditingController();

      final SingleExpense? initialExpense = widget.expense;
      if (initialExpense != null) {
        // Populate fields from widget.expense if it's not null
        ammountController.text = initialExpense.ammount?.toString() ?? '';
        noteController.text    = initialExpense.note ?? '';
        icon = initialExpense.icon;
        date = initialExpense.date ?? DateTime.now(); // Default to now if date is null
      } else {
        // Default values for a new expense
        date = DateTime.now();
        icon = null; // Or a default icon if you have one
      }
  }

  @override
  void dispose() {
      ammountController.dispose();
      noteController.dispose(); // Dispose noteController too
      super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  onSave(){
    final double? ammountValue = double.tryParse(ammountController.text);
    final String noteValue = noteController.text;

    if (ammountValue == null) {
      // Handle error: ammount is not a valid double
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount'))
      );
      return;
    }
    if (date == null) {
      // Handle error: date is not selected
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date'))
      );
      return;
    }

    SingleExpense tempExpense;
    bool newExpense = widget.expense == null;

    if(newExpense){
      tempExpense = SingleExpense(
        ammount: ammountValue,
        date: date,
        icon: icon,
        note: noteValue
      );
    }else{
      // Update existing expense
      tempExpense = widget.expense!; // We know it's not null here
      tempExpense.ammount = ammountValue;
      tempExpense.date    = date;
      tempExpense.icon    = icon;
      tempExpense.note    = noteValue;
    }

    if(newExpense){
      provider.insert(tempExpense);
    }else{
      provider.update(tempExpense);
    }

    //replace with save
    Navigator.pop(context,tempExpense);
  }

  onIconSelect(String text){
    icon = text;
  }


  @override
  Widget build(BuildContext context){
    return Scaffold( // Removed 'new'
      appBar: AppBar( // Removed 'new'
        title: Text("New Expense", style: TextStyle(color: Theme.of(context).primaryColorLight),), // Removed 'new'
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorLight, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: 
      Container( // Removed 'new'
        padding: const EdgeInsets.all(10), // Added const
        child:  Column( // Removed 'new'
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row( // New Row for Date display and Button
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(date != null ? dateFormat.format(date!) : 'No date selected', style: const TextStyle(fontSize: 16)), // Added const
                ElevatedButton(
                  child: const Text('Select Date'), // Added const
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 20), // Added SizedBox for spacing
            TextFormField(
              decoration: const InputDecoration( // Added const
                labelText: 'Ammount',
              ),
              keyboardType:TextInputType.number,
              controller: ammountController,
            ),
            Container( // Removed 'new'
              margin: const EdgeInsets.only(top: 10), // Added const
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
            Expanded(child: IconsBottomSheet(onPressed: onIconSelect, icon: icon)), // Wrapped in Expanded
            //Bottom Save Button
            BottomSaveButton(text: "Save Expense", onSave: onSave) // Removed 'new'
          ],
        ),
      )
    );
  }
}




