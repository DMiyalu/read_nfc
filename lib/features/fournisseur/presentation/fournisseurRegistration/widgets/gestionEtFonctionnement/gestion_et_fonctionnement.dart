import 'package:flutter/material.dart';
import 'widgets.dart';

class GestionEtFonctionnement extends StatefulWidget {
  const GestionEtFonctionnement({Key? key}) : super(key: key);

  @override
  State<GestionEtFonctionnement> createState() => _GestionEtFonctionnementState();
}

class _GestionEtFonctionnementState extends State<GestionEtFonctionnement> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
              const SizedBox(height: 30),
              gestionEtFonctionnement(context, _formKey),
        ],)
      ),
    );
  }
}
