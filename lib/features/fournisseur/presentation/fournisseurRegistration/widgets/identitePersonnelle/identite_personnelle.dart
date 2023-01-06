import 'package:flutter/material.dart';
import 'widgets.dart';

class IdentiteFournisseur extends StatefulWidget {
  const IdentiteFournisseur({Key? key}) : super(key: key);

  @override
  State<IdentiteFournisseur> createState() => _IdentiteFournisseurState();
}

class _IdentiteFournisseurState extends State<IdentiteFournisseur> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
              const SizedBox(height: 30),
              identiteFournisseur(context, _formKey),
        ],)
      ),
    );
  }
}
