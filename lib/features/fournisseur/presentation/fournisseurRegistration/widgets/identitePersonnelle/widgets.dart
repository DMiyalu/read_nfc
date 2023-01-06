import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import '../widgets.dart';

Widget identiteFournisseur(context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        cameraWidget(context),
        // cameraValidationWidget(context),
        previewImage(context, field: "providerIdentity", status: 'providerPhotoStatus', width: 100, height: 100),
        const SizedBox(height: 25),
        inputField(context, hint: "AgroMwinda", label: "Nom fournisseur", field: 'providerIdentity', fieldName: 'fullName'),
        const SizedBox(height: 10),
        inputField(context,
            hint: "AgroMwinda", label: "Nom en sigle", fieldRequired: false, field: 'providerIdentity', fieldName: 'shortName'),
        const SizedBox(height: 10),
        birthdayField(context, field: 'providerIdentity', fieldName: 'createdAt', label: "Date de création"),
        // inputField(context, hint: "29-03-2022", label: "Date de création", field: 'providerIdentity', fieldName: 'createdAt'),
        const SizedBox(height: 10),
        inputField(context, keyboardType: TextInputType.phone, hint: "0822080003", label: "Téléphone", field: 'providerIdentity', fieldName: 'phone', maxLength: 10),
        const SizedBox(height: 10),
        inputField(context,
            hint: "agromwinda@gmail.com",
            label: "E-mail",
            fieldRequired: false, field: 'providerIdentity', fieldName: 'email'),
        const SizedBox(height: 10),
        inputField(context, initialValue: true,
            hint: "", enabled: false, label: "NUI", fieldRequired: false, field: 'providerIdentity', fieldName: 'nui'),
        const SizedBox(height: 10),
        inputField(context, hint: "Amboka Koti Ken", label: "Nom du gérant", field: 'providerIdentity', fieldName: 'managerName'),
        const SizedBox(height: 40),
        customButton(context,
            text: "Continuer",
            bkgColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white, onPressed: () {
          if (formKey.currentState!.validate()) {
            BlocProvider.of<FournisseurRegistrationCubit>(context).getToNextFormStep();
          }
          return;
        }),
        const SizedBox(height: 20),
      ],
    ),
  );
}
