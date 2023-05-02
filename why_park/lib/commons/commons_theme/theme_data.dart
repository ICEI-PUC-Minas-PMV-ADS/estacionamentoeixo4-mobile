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
            headlineLarge:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            headlineMedium:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            headlineSmall:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            titleLarge:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            titleMedium:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
            titleSmall:
            TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
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
        inputDecorationTheme: InputDecorationTheme(
            labelStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
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
