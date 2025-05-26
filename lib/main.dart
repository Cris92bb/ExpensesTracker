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
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key}); // Use super.key
  _MyApp createState() => _MyApp();
}

Future<ThemeData> getTheme() async {
  bool theme;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  theme = prefs.getBool("lightTheme") ?? false;

  if (theme) {
    //dark theme startup
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.lightGreen,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    return DarkTheme.theme;
  } else {
    //light theme startup
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.lightGreen,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    return LightTheme.theme;
  }
}

class _MyApp extends State<MyApp> {
  // _MyApp(); // No need for constructor here
  // This widget is the root of your application.
  // bool darkTheme=false; // Not used here
  ThemeData theme = LightTheme.theme; // Initialize with a default
  @override
  void initState() {
    super.initState(); // super.initState() first
    getTheme().then((th) {
      if (mounted) {
        setState(() {
          theme = th;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Tracker',
      theme: theme,
      home: MyHomePage(
        title: 'Expenses Tracker',
        onThemeChanged: (bool value) {
          // value is the new theme state (true for dark)
          if (mounted) {
            setState(() {
              // Update the theme based on 'value' directly or by re-calling getTheme if it uses this value
              // For simplicity, let's assume getTheme() will now correctly reflect the new preference
              // after it's been saved by PreferencesForm.
              // The `value` parameter here might be redundant if getTheme() always reads from prefs.
              getTheme().then((th) {
                if (mounted) {
                  setState(() {
                    theme = th;
                  });
                }
              });
            });
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.onThemeChanged,
  }) : super(key: key); // Use Key? and required

  final Function(bool) onThemeChanged; // Specific function type
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExpensesProvider provider = ExpensesProvider();

  @override
  void initState() {
    super.initState();
    getPrefs();
    provider.open("expenses.db").then((value) {
      loadExpenses();
    });
  }

  Future<void> insertExpense(SingleExpense exp) async {
    await provider.insert(exp);
    loadExpenses();
  }

  //need all expenses here so i can pass totals to other widgets
  List<SingleExpense> expenses = []; // Initialize
  loadExpenses() async {
    provider.getAllExpenses().then((allExps) {
      double sum = 0.0;
      if (allExps.isNotEmpty) {
        // Use isNotEmpty
        allExps.forEach((val) {
          sum += val.ammount ?? 0.0; // Handle nullable ammount
        });
      }
      if (mounted) {
        setState(() {
          expenses = allExps;
          remaining = (total ?? 0.0) - sum; // Handle nullable total
          totalSpent = sum;
        });
      }
    });
  }

  getPrefs() async {
    SharedPreferences.getInstance().then((pref) {
      if (mounted) {
        setState(() {
          bool? darkTheme = pref.getBool("lightTheme");
          widget.onThemeChanged(darkTheme ?? false); // Provide default if null
          currency = pref.getString('currency') ?? ""; // Provide default
          payday = pref.getInt("payDay") ?? 30; // Provide default
          total = pref.getDouble('maxAmmount') ?? 0.0; // Provide default

          remaining = (total ?? 0.0) - totalSpent; // Handle nullable total
          print(total);
        });
      }
    });
  }

  String currency = ""; // Initialize
  int payday = 30; // Initialize
  double? total = 1.0; // Make nullable or initialize with a default
  double remaining = 0.0; // Initialize
  double totalSpent = 0.0; // Initialize

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontFamily: 'Mogra',
              fontSize: 30,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            // Removed 'new'
            color: Theme.of(context).primaryColorLight,
            icon: const Icon(Icons.settings), // Added const
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PreferencesForm()),
              ).then(
                (val) => val != null && val == true ? getPrefs() : null,
              ); // Ensure val is true
            },
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            HorizontalSlider(
              givenTotal: total ?? 0.0,
              currency: currency,
              givenRemaining: remaining,
              payDate: payday,
            ), // Corrected givenPayDay to payDate
            ExpensesList(expenses: expenses, currency: currency),
            TotalBottomBar(total: totalSpent, currency: currency),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: const Icon(Icons.add), // Added const
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateExpense()),
          ).then((val) {
            if (mounted && val != null) {
              // Check mounted
              setState(() {
                loadExpenses();
              });
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
