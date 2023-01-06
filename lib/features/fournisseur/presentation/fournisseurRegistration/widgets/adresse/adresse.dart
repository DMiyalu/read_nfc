import 'package:flutter/material.dart';
import 'widgets.dart';

class AdresseForm extends StatefulWidget {
  const AdresseForm({Key? key}) : super(key: key);

  @override
  State<AdresseForm> createState() => _AdresseFormState();
}

class _AdresseFormState extends State<AdresseForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              adresseFournisseur(context, _formKey),
              const SizedBox(height: 15),
            ],
          )),
    );
  }
}
