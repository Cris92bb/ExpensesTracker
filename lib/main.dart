import 'package:expences_calculator/CustomWidgets/HorizontalSlider.dart';
import 'package:expences_calculator/CustomWidgets/ExpencesList.dart';
import 'package:expences_calculator/CustomWidgets/TotalBottomBar.dart';
import 'package:expences_calculator/Views/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:expences_calculator/Helpers/DatabaseHelper.dart';
import 'package:expences_calculator/Views/CreateExpense.dart';
import 'package:expences_calculator/DataModels/SingleExpense.dart';
import 'package:expences_calculator/Themes/DarkTheme.dart';
import 'package:expences_calculator/Themes/LightTheme.dart';
import 'package:flutter/services.dart';


//import 'package:sqflite/sqflite.dart';
import 'dart:math';
import 'dart:async';

var databasePath;

//void main() => runApp(new MyApp());



void main() async {
  bool theme;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  theme = prefs.getBool("lightTheme") ?? false;

  if(theme){
    //dark theme startup
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor          : Colors.lightGreen,
        systemNavigationBarIconBrightness : Brightness.dark,
        statusBarColor                    : Colors.transparent,
        statusBarBrightness               : Brightness.dark,
        statusBarIconBrightness           : Brightness.dark,
    ));
  }else{
    //light theme startup
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor          : Colors.lightGreen,
        systemNavigationBarIconBrightness : Brightness.light,
        statusBarColor                    : Colors.transparent,
        statusBarBrightness               : Brightness.light,
        statusBarIconBrightness           : Brightness.light,
    ));
  }
  runApp(new MyApp(darkTheme: theme,));
}



class MyApp extends StatefulWidget{
  var darkTheme = false;
  MyApp({this.darkTheme});


  _MyApp createState() => new _MyApp(darkTheme: darkTheme);


}

class _MyApp extends State<MyApp> {
_MyApp({this.darkTheme});
  // This widget is the root of your application.
  bool darkTheme=false; 

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Expenses Tracker',
      theme: darkTheme?? false ? DarkTheme.theme: LightTheme.theme  ,
      home: new MyHomePage(title: 'Expenses Tracker',
      onThemeChanged: (bool value){
        setState(() {
                  darkTheme = value;
        });
      },),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.onThemeChanged}) : super(key: key);

  var onThemeChanged;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    ExpensesProvider provider = new ExpensesProvider();
    @override
    void initState() {
        super.initState();
        getPrefs();
        provider.open("expenses.db").then((value){
          loadExpenses();  
        });

    }

    Future<void> insertNewExpense(SingleExpense exp) async {
      await provider.insert(exp);
      loadExpenses();
    }

    //need all expenses here so i can pass totals to other widgets
    List<SingleExpense> expenses;
    loadExpenses() async{
          provider.getAllExpenses().then((allExps){
            var sum =  0.0;
            if(allExps != null && allExps.length>0){
              allExps.forEach((val){
                sum+=val.ammount;
              });
            }

            setState(() {
              expenses    =     allExps;  
              remaining   = total - sum;     
              totalSpent  =         sum;       
            });
          });
    }


    getPrefs() async {
      SharedPreferences.getInstance().then((pref){
       setState(() {
                var darkTheme  = pref.getBool("lightTheme");
                widget.onThemeChanged(darkTheme); 
                currency  = pref.getString('currency');
                payday    = pref.getInt("payDay");
                if(currency==null) currency ="‎£";
                total     =  pref.getDouble('maxAmmount');
                if(total==null)total =0;


                if(total!= null && totalSpent!=null){
                  remaining =       total - totalSpent;
                } else{
                  remaining =  total;
                }
                print(total);
              });
      });
    }

    var currency  =     "";
    int payday    =     30;
    double total  =      1;
    var remaining =    0.0;
    var totalSpent=    0.0;

  @override
  Widget build(BuildContext context) {
    
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
            
            // drawer: Drawer(

            // ),
            appBar: new AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: new Center(
                child:
                new Text(
                  widget.title, 
                  style:
                  TextStyle(
                    color: Theme.of(context).primaryColorLight, 
                    fontFamily: 'Mogra',
                    fontSize: 30
                  ),
                ),
              ),
              actions: <Widget>[
                new IconButton(
                  color: Theme.of(context).primaryColorLight,
                  icon: Icon(Icons.settings),
                  tooltip: 'Settings',
                  onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PreferencesForm())
                      ).then((val)=>val!=null && val? getPrefs():null);
                  },
                ),
              ],
            ),
            body: new Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: new Column (
                children: <Widget>[
                  new HorizontalSlider(total,currency,remaining,payday),
                  new ExpensesList(expenses,currency),
                  new TotalBottomBar(totalSpent,currency)
                ],
              )
            ),
            floatingActionButton: new FloatingActionButton(
              tooltip: 'Increment',
              child: new Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightGreen,
              onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => new CreateExpense())).then((val){
                      setState(() {
                        if(val!=null)
                          expenses.add(val);
                          expenses.sort((x,y)=> x.date.compareTo(y.date));
                      });
                  });
              },
            ), 
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,// This trailing comma makes auto-formatting nicer for build methods.
          );
          
    }
  }
