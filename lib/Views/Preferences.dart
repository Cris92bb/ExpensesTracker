import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expences_calculator/CustomWidgets/BottomSaveButton.dart';
import 'package:intl/intl.dart';

class PreferencesForm extends StatefulWidget {
  @override
  _PreferencesForm createState() => _PreferencesForm();
}


var _currencyList = ["\$","£","€"];
class _PreferencesForm extends State<PreferencesForm> {

    final dateFormat = DateFormat("MMMM d, yyyy");
    late TextEditingController totalAmmountController;    
    late TextEditingController payDayController;
    late SharedPreferences fPrefs; // Marked as late
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String currency                  = "\$";
    bool lightTheme                 = false;
    @override
    void initState() {
        super.initState(); // Call super.initState() first
        _prefs.then((SharedPreferences prefs){
            fPrefs = prefs; // Initialize fPrefs
            currency = prefs.getString('currency') ?? '\$';
            // Provide default values before calling toString()
            totalAmmountController = TextEditingController(text: (prefs.getDouble('maxAmmount') ?? 0.0).toString());
            payDayController       = TextEditingController(text: (prefs.getInt('payDay') ?? 30).toString());
            lightTheme             = prefs.getBool('lightTheme') ?? false;
            if (mounted) { // Check if the widget is still in the tree
              setState(() {}); // Update state after async operation
            }
        });
    }



  @override
  void dispose() {
        payDayController.dispose();
        totalAmmountController.dispose();
        super.dispose();
      }

  _storePreferences() async{
     final SharedPreferences prefs = await _prefs;
     prefs.setDouble('maxAmmount', double.parse(totalAmmountController.text));
     prefs.setString('currency', currency);
     prefs.setInt('payDay', int.parse(payDayController.text));
     prefs.setBool('lightTheme', lightTheme);
  }

  onSave(){
    _storePreferences();
    Navigator.pop(context,true);
  }

  @override
  Widget build(BuildContext context) {
  var width = MediaQuery.of(context).size.width-30;

  var heigth = MediaQuery.of(context).size.height-30;
    return Scaffold(
      appBar: AppBar(
        //leading: new Icon(Icons.arrow_downward),
        title: Text("Preferences", style: TextStyle(color: Theme.of(context).primaryColorLight),), // Removed 'new'
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorLight, //change your color here
         ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child:
         Container( 
           //padding: EdgeInsets.all(10),
           child:
            Column( // Removed 'new'
              children: <Widget>[
                Row( // Removed 'new'
                  children: <Widget>[
                      Container(
                        width:  width * 0.5,
                        child:Text(
                          "Currency",
                          style: TextStyle( // Removed 'new'
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.5,
                        child: DropdownButton<String>( // Removed 'new'
                          items: _currencyList.map((String value){
                            return DropdownMenuItem<String>( // Removed 'new'
                              value: value,
                              child: Text(value), // Removed 'new'
                            );
                          }).toList(),
                          hint: Text("Select a currency"),
                          onChanged: (String? dt) => setState(() { // dt can be nullable
                            if (dt != null) currency  = dt;
                          }),
                          value: currency,
                        )
                      )
                    ],
                 ),
                TextFormField( // Removed 'new'
                  controller: payDayController,
                  decoration: InputDecoration(
                    labelText: 'Pay Day',
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),

                TextFormField( // Removed 'new'
                  controller: totalAmmountController,
                  decoration: InputDecoration(
                    labelText: 'Total to spend',
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
                Row( // Removed 'new'
                  children: <Widget>[
                      Container(
                        width:  width * 0.5,
                        child:Text(
                          "Dark Theme",
                          style: TextStyle( // Removed 'new'
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Switch(
                        activeColor: Colors.blue,
                        value: lightTheme ,
                        onChanged:(val){
                          setState(() {
                            lightTheme = val;
                          });
                        } ,
                      )
                    ],
                ),

                Expanded(
                  child:BottomSaveButton(text: "Save",onSave: onSave,)
                )
              ],
            )
        )
      ),
    );
  }
}


