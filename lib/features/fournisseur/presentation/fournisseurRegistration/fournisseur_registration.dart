import 'package:flutter/material.dart';
import 'widgets/widgets.dart';

class FournisseurRegistration extends StatefulWidget {
  const FournisseurRegistration({Key? key}) : super(key: key);

  @override
  State<FournisseurRegistration> createState() =>
      _FournisseurRegistrationState();
}

class _FournisseurRegistrationState extends State<FournisseurRegistration> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarForm(context),
      body: formStep(context),
    );
  }
}
