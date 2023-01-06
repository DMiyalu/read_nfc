import 'package:flutter/material.dart';

Widget loader(context, {Color? color}) {
  return SizedBox(
    width: 50,
    height: 50,
    child: CircularProgressIndicator(
      color: color??Theme.of(context).colorScheme.primary,
      strokeWidth: 2,
    ),
  );
}