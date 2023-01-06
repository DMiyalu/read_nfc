import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  fontFamily: 'Twitterchirp',
  primarySwatch: Colors.blue,
);

ThemeData themeData() {
  return theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      primary: const Color.fromRGBO(52, 74, 88, 1),
      primaryContainer: Colors.transparent,
      secondary: Colors.black,
      secondaryContainer: Colors.black,
      background: Colors.white,
      tertiary: Colors.grey[600],
    ),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    textTheme: const TextTheme(
        bodyText1: TextStyle(
      color: Colors.black,
    )),
  );
}
