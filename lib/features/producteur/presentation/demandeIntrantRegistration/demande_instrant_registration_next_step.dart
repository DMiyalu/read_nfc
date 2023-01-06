import 'package:flutter/material.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantRegistration/widgets/widgets.dart';

class DemandeIntrantRegistrationNextStep extends StatefulWidget {
  const DemandeIntrantRegistrationNextStep({Key? key}) : super(key: key);

  @override
  State<DemandeIntrantRegistrationNextStep> createState() =>
      _DemandeIntrantRegistrationNextStepState();
}

class _DemandeIntrantRegistrationNextStepState
    extends State<DemandeIntrantRegistrationNextStep> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: formTitle(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            formStep(context, _formKey),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
