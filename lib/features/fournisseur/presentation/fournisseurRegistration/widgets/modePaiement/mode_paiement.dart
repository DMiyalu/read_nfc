import 'package:flutter/material.dart';

import 'widgets.dart';

class ModePaiement extends StatefulWidget {
  const ModePaiement({Key? key}) : super(key: key);

  @override
  State<ModePaiement> createState() => _ModePaiementState();
}

class _ModePaiementState extends State<ModePaiement> {
 final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
              const SizedBox(height: 30),
              modePaiement(context, _formKey),
        ],)
      ),
    );
  }
}