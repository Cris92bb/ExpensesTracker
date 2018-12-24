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
import 'dart:async';

var databasePath;

//void main() => runApp( MyApp());



void main() async {
  runApp( MyApp());
}



class MyApp extends StatefulWidget{
  MyApp();
  _MyApp createState() =>  _MyApp();
}





Future<ThemeData> getTheme() async{
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
    ));
    return DarkTheme.theme;
  }else{
    //light theme startup
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor          : Colors.lightGreen,
        systemNavigationBarIconBrightness : Brightness.light,
        statusBarColor                    : Colors.transparent,
    ));
    return LightTheme.theme;
  }
}

class _MyApp extends State<MyApp> {
_MyApp({this.darkTheme});
  // This widget is the root of your application.
  bool darkTheme=false; 
  var theme = LightTheme.theme;
  @override
  void initState() {
    getTheme().then((th)=> theme = th);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Expenses Tracker',
      theme: theme,
      home:  MyHomePage(title: 'Expenses Tracker',
      onThemeChanged: (bool value){
        setState(() {
          getTheme().then((th)=> theme = th);
        });
      },),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.onThemeChanged}) : super(key: key);

  var onThemeChanged;

  final String title;

  @override
  _MyHomePageState createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    ExpensesProvider provider =  ExpensesProvider();
    @override
    void initState() {
        super.initState();
        getPrefs();
        provider.open("expenses.db").then((value){
          loadExpenses();  
        });

    }

    Future<void> insertExpense(SingleExpense exp) async {
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
    
    return Scaffold(
            
            // drawer: Drawer(

            // ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title:  Center(
                child:
                 Text(
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
                 IconButton(
                  icon: Icon(Icons.settings),
                  color: Theme.of(context).primaryColorLight,
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
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column (
                children: <Widget>[
                   HorizontalSlider(total,currency,remaining,payday),
                   ExpensesList(expenses,currency),
                   TotalBottomBar(totalSpent,currency)
                ],
              )
            ),
            floatingActionButton:  FloatingActionButton(
              tooltip: 'Increment',
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightGreen,
              onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>  CreateExpense())).then((val){
                      setState(() {
                        if(val!=null)
                          loadExpenses();
                      });
                  });
              },
            ), 
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,// This trailing comma makes auto-formatting nicer for build methods.
          );
          
    }
  }
