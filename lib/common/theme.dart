// Packages
import 'package:flutter/material.dart';

// Constants
import 'package:peliculas/common/constants.dart';

ThemeData themeLight = ThemeData.light().copyWith(
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
  ),
);

ThemeData themeDark = ThemeData.light().copyWith();
