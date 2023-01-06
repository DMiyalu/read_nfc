import 'package:flutter/material.dart';

import 'widgets_form.dart';

class DemandeIntrantForm extends StatefulWidget {
  const DemandeIntrantForm({Key? key}) : super(key: key);

  @override
  State<DemandeIntrantForm> createState() => _DemandeIntrantFormState();
}

class _DemandeIntrantFormState extends State<DemandeIntrantForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return demandeIntrantRegistrationFormNextStep(context, formKey);
  }
}
