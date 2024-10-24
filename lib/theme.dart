import 'package:flutter/material.dart';

final theme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
    // isCollapsed: true,
    contentPadding: EdgeInsets.symmetric(vertical: 16),
    border: MaterialStateOutlineInputBorder.resolveWith(
      (states) {
        if (states.contains(WidgetState.focused)) {
          return UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          );
        } else if (states.contains(WidgetState.error)) {
          return UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red[100]!,
              width: 1.5,
            ),
          );
        }
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        );
      },
    ),
  ),
);
