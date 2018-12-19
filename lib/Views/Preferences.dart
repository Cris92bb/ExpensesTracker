import 'package:flutter/cupertino.dart';
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
    TextEditingController totalAmmountController;    
    TextEditingController payDayController;
    SharedPreferences fPrefs;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String currency                  = "\$";
    bool lightTheme                 = false;
    @override
    void initState() {
        _prefs.then((SharedPreferences prefs){
            currency               = prefs.getString('currency') ?? '\$';
            totalAmmountController = new TextEditingController(text: prefs.getDouble('maxAmmount').toString() ?? '');
            payDayController       = new TextEditingController(text: prefs.getInt('payDay').toString() ?? '');
            lightTheme             = prefs.getBool('lightTheme') ?? false;
            setState(() {
              fPrefs = prefs;
            });
        });
        super.initState();
    }



  @override
  void dispose() {
        // Clean up the controller when the Widget is removed from the Widget tree
        // This also removes the _printLatestValue listener
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
    return Scaffold(
      appBar: AppBar(
        //leading: new Icon(Icons.arrow_downward),
        title: Text("Preferences", style: new TextStyle(color: Theme.of(context).primaryColorLight),),
        iconTheme: IconThemeData(
            color: Theme.of(context).primaryColorLight, //change your color here
         ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child:
         Container( 
           padding: EdgeInsets.all(10),
           child:
            new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                      Container(
                        width:  width * 0.5,
                        child:Text(
                          "Currency",
                          style: new TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ),
                      Container(
                        width: width*0.5,
                        child:new DropdownButton<String>(
                          items: _currencyList.map((String value){
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text("Select a currency"),
                          onChanged: (dt) => setState(() => currency  = dt),
                          value: currency,
                        )
                      )
                    ],
                 ),
                new TextFormField(
                  controller: payDayController,
                  decoration: InputDecoration(
                    labelText: 'Pay Day',
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),

                new TextFormField(
                  controller: totalAmmountController,
                  decoration: InputDecoration(
                    labelText: 'Total to spend',
                  ),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                ),
                new Row(
                  children: <Widget>[
                      Container(
                        width:  width * 0.5,
                        child:Text(
                          "Dark Theme",
                          style: new TextStyle(
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
                BottomSaveButton(text: "Save",onSave: onSave,)
                // new Expanded
                //   child: Container(
                //     alignment: Alignment.bottomCenter,
                //     child:
                //     new RaisedButton(
                //       child: new Text('Save', style: TextStyle(color: Colors.white),),
                //       color: Colors.blueAccent,
                //       onPressed: (){
                //           _storePreferences();
                //           Navigator.pop(context,true);
                //       },
                //     ) ,
                //   ),
                // )
              ],
            )
        )
      ),
    );
  }
}


