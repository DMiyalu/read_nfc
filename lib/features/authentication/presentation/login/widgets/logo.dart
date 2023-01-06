import 'package:flutter/material.dart';

Widget logo(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Image.asset(
          "assets/images/ic_logo.png",
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      Text(
        "Système d'Information de Gestion des Incitations",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
        textAlign: TextAlign.center,
      )
    ],
  );
}

Widget partnersLogo(context) {
  return Center(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/drapeau_rdc.png'),
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 5),
            Image(
              image: AssetImage('assets/images/rdc_logo.png'),
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const SizedBox(height: 3),
        Text(
          'Ministere de l\'agriculture',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black54,
              fontSize: 10,
              fontWeight: FontWeight.w500),
        ),
        Text(
          'République Démocratique du Congo',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.black54,
              fontSize: 10,
              fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}