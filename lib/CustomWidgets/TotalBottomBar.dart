import 'package:flutter/material.dart';

class TotalBottomBar extends StatelessWidget { // Changed to StatelessWidget
  final String totalSpentFormatted; // Store the formatted string

  // Constructor with named parameters and initialization
  TotalBottomBar({ // Removed const
    Key? key, 
    required double total, // Take raw double
    required String currency
  }) : totalSpentFormatted = "${total.toStringAsFixed(2)} $currency", // Format here
       super(key: key);

  @override
  Widget build(BuildContext context){ // No longer a State widget
    var width = MediaQuery.of(context).size.width-20;

    return Container(
      decoration: const BoxDecoration( // Added const
        border: Border( top:
           BorderSide(
             color: Colors.blueGrey
          )
        )
      ),
      padding: const EdgeInsets.all(10), // Added const
      width: width+10, // This might need to be width if padding is included, or use full width
      child: Row( // Removed 'new'
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
            width: width*0.4,
            child:
             Row( // Removed 'new'
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 const Text( // Added const
                  'Total spent', 
                  style:
                  TextStyle( 
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
           Container(
            width: width*0.25,
            child:
            Row( // Removed 'new'
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  totalSpentFormatted, // Use the formatted field
                  style: 
                  const TextStyle( // Added const
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}