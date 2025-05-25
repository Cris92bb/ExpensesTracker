
import 'package:flutter/material.dart';

Map<String,IconData> icons = {}; // Initialize here

populateList(){
  // icons is already initialized, just populate if empty or ensure population logic
  // This check might be redundant if populateList is only called when icons is empty.
  // However, to be safe and match the previous logic structure:
  if (icons.isEmpty) { 
    icons = <String,IconData>{}; // Use literal for empty map
  }
  icons["food"]       = Icons.fastfood;
  icons["shopping"]   = Icons.shopping_cart;
  icons["car"]        = Icons.airport_shuttle;
  icons["book"]       = Icons.book;
  icons["umbreall"]   = Icons.beach_access;
  icons["gift"]       = Icons.cake;
  icons["child"]      = Icons.child_friendly;
  icons["event"]      = Icons.event_seat;
  icons["flight"]     = Icons.flight;
  icons["games"]      = Icons.gamepad;
  icons["friends"]    = Icons.group;
  icons["bar"]        = Icons.local_bar;
  icons["cafe"]       = Icons.local_cafe;
  icons["restaurant"] = Icons.local_dining;
  icons["cinema"]     = Icons.local_movies;
  icons["parking"]    = Icons.local_parking;
  icons["pizza"]      = Icons.local_pizza;
  icons["taxi"]       = Icons.local_taxi;
  icons["pets"]       = Icons.pets;
  icons["redeem"]     = Icons.redeem;
  icons["cigarette"]  = Icons.smoking_rooms;
  icons["public_transport"]= Icons.subway;
  icons["girls"]      = Icons.wc;
}


Map<String,IconData> getIcons(){
  if (icons.isEmpty) { // Ensure populated before returning
    populateList();
  }
  return icons;
}

IconData? getIcon(String text){ // Return nullable IconData
  if (icons.isEmpty) { // Ensure populated
    populateList();
  }
  return icons[text];
}