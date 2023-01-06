import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit/demande_intrant_registration_cubit.dart';
import 'widgets/widgets.dart';

class DemandeIntrantRegistration extends StatefulWidget {
  const DemandeIntrantRegistration({Key? key}) : super(key: key);

  @override
  State<DemandeIntrantRegistration> createState() =>
      _DemandeIntrantRegistrationState();
}

class _DemandeIntrantRegistrationState
    extends State<DemandeIntrantRegistration> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: formTitle(context),
        leading: Ink(
          child: InkWell(
            onTap: () =>
                BlocProvider.of<DemandeIntrantRegistrationCubit>(context)
                    .goToPreviewFormStep(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
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
