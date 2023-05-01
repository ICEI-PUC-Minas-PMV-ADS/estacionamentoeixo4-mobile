import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0.0,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        ),
        textTheme: TextTheme(
            bodyLarge:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            bodyMedium:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            bodySmall:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            labelLarge:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            labelMedium:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            labelSmall:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            displaySmall:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            displayLarge:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            displayMedium:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        primaryColor: isDarkTheme ? Colors.white : Colors.black,
        hintColor: isDarkTheme ? Colors.white : Colors.black,
        cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
        dividerColor: isDarkTheme ? Colors.white : Colors.black,
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll<Color>(Colors.deepPurple))),
        textButtonTheme: const TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll<Color>(Colors.deepPurple))),
        outlinedButtonTheme: const OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.deepPurple),
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          ),
        ),
        iconTheme:
            IconThemeData(color: isDarkTheme ? Colors.white : Colors.black));
  }
}
