import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import '../widgets.dart';

Widget modePaiement(context, GlobalKey<FormState> formKey) {
  return Form(
      key: formKey,
      child: Column(
        children: [
          BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
            builder: (context, state) {
              return dropDownButtonFormField(
                context,
                label: 'Type de banque',
                field: 'providerPayment',
                fieldName: 'typeOfBank',
                cubit: 'fournisseur',
                state: state,
                listValue: <String>['Mobile', 'Fixe'],
                value: 'Mobile',
                hintText: 'Mobile',
                textError: 'type de banque',
                validate: true,
              );
            }
          ),
          const SizedBox(height: 25),
          inputField(
            context,
            hint: "210-003-445-487",
            label: "Numéro de compte",
            field: 'providerPayment',
            fieldName: 'accountNumber',
          ),
          const SizedBox(height: 25),
          inputField(
            context,
            hint: "AgroMwinda",
            label: "Nom du compte",
            field: 'providerPayment',
            fieldName: 'accountName',
          ),
          const SizedBox(height: 25),
          customButton(context,
              text: "Continuer",
              bkgColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white, onPressed: () {
            if (formKey.currentState!.validate()) {
              BlocProvider.of<FournisseurRegistrationCubit>(context)
                  .getToNextFormStep();
            }
            return;
          })
        ],
      ));
}
