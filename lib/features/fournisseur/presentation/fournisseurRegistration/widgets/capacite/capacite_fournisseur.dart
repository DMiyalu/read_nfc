import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import 'widgets.dart';

class CapaciteFournisseur extends StatefulWidget {
  const CapaciteFournisseur({Key? key}) : super(key: key);

  @override
  State<CapaciteFournisseur> createState() => _CapaciteFournisseurState();
}

class _CapaciteFournisseurState extends State<CapaciteFournisseur> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<FournisseurRegistrationCubit>(context)
        .generateSupplierSpecialty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            capaciteFournisseur(context, _formKey),
          ],
        ),
      ),
    );
  }
}
