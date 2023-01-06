import 'package:flutter/material.dart';

Widget title(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Text(
          "Bienvenue sur SIGI",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 5),
      Center(
        child: Text(
          "Connectez-vous pour continuer",
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 12,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
