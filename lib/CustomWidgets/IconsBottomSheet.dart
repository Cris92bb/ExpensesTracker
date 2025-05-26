import 'package:flutter/material.dart';
import 'package:expences_calculator/Helpers/IconConstants.dart';

class IconsBottomSheet extends StatefulWidget {
  final Function(String) onPressed;
  String? icon; // Made nullable
  IconsBottomSheet({required this.onPressed, this.icon});

  _IconsBottomSheet createState() => _IconsBottomSheet();
}

class _IconsBottomSheet extends State<IconsBottomSheet> {
  int? selectedIndex; // Made nullable

  var icons = getIcons(); // getIcons() now returns Map<String, IconData?>
  Widget build(context) {
    // Removed the Expanded widget that was wrapping GridView.builder
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
      ), // Added const
      itemBuilder: (_, index) {
        IconData? value = icons.values.elementAt(index); // value is IconData?
        var key = icons.keys.elementAt(index);

        return IconButton(
          color: widget.icon == key
              ? Colors.lightGreen
              : Theme.of(context).primaryColorLight,
          icon: Icon(value), // Icon widget handles IconData?
          onPressed: () {
            widget.onPressed(key);
            setState(() {
              widget.icon = key;
            });
          },
        );
      },
      itemCount: icons.length,
      // Extra parenthesis removed here
    );
  }
}
