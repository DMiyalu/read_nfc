import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import '../widgets.dart';

Widget adresseFournisseur(context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
            builder: (context, state) {
          final List<String> provinces = [
            "Province",
            ...state.field!['province']
          ];
          return dropDownButtonFormField(
            context,
            label: 'Province',
            field: 'providerAdress',
            fieldName: 'province',
            cubit: 'fournisseur',
            state: state,
            listValue: provinces,
            value: provinces[0],
            hintText: 'Province',
            textError: 'un province',
            validate: true,
          );
        }),
        const SizedBox(height: 15),
        BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
            builder: (context, state) {
          final List<String> cities = [...state.field!['cities']];
          return dropDownButtonFormField(
            context,
            label: 'Territoire/Ville',
            field: 'providerAdress',
            fieldName: 'city',
            cubit: 'fournisseur',
            state: state,
            listValue: cities,
            value: cities[0],
            hintText: 'Ville',
            textError: 'une ville/territoire',
            validate: true,
          );
        }),
        const SizedBox(height: 15),
        BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
            builder: (context, state) {
          final List<String> town = [...state.field!['towns']];
          return dropDownButtonFormField(
            context,
            label: 'Secteur/Commune',
            field: 'providerAdress',
            fieldName: 'town',
            cubit: 'fournisseur',
            state: state,
            listValue: town,
            value: town[0],
            hintText: 'Commune',
            textError: 'un Secteur/Commune',
            validate: false,
          );
        }),
        // const SizedBox(height: 15),
        // BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
        //     builder: (context, state) {
        //   final List<String> district = state.field!['district'];
        //   return dropDownButtonFormField(
        //     context,
        //     label: 'Groupement/Quartier',
        //     field: 'providerAdress',
        //     fieldName: 'district',
        //     cubit: 'fournisseur',
        //     state: state,
        //     listValue: district,
        //     value: district[0],
        //     hintText: 'Quartier',
        //     textError: 'une groupement/quartier',
        //     validate: true,
        //   );
        // }),
        // const SizedBox(height: 15),
        // Builder(builder: (context) {
        //   return BlocBuilder<FournisseurRegistrationCubit,
        //       FournisseurRegistrationState>(builder: (context, state) {
        //     final List<String> village = state.field!['village'];
        //     return dropDownButtonFormField(
        //       context,
        //       label: 'Avenue/Village',
        //       field: 'providerAdress',
        //       fieldName: 'street',
        //       cubit: 'fournisseur',
        //       state: state,
        //       listValue: village,
        //       value: village[0],
        //       hintText: 'Village',
        //       textError: 'une avenue/village',
        //       validate: true,
        //     );
        //   });
        // }),
        const SizedBox(height: 15),
        inputField(context,
            enabled: true,
            initialValue: true,
            hint: "No. Avenue. Reference.",
            label: "Adresse",
            fieldRequired: true,
            field: 'providerAdress',
            fieldName: 'addressLine'),
        inputField(context,
            enabled: false,
            initialValue: true,
            hint: "",
            label: "Longitude",
            fieldRequired: false,
            field: 'providerAdress',
            fieldName: 'longitude'),
        inputField(context,
            enabled: false,
            initialValue: true,
            hint: "",
            label: "Latitude",
            fieldRequired: false,
            field: 'providerAdress',
            fieldName: 'latitude'),
        inputField(context,
            enabled: false,
            initialValue: true,
            hint: "",
            label: "Altitude",
            fieldRequired: false,
            field: 'providerAdress',
            fieldName: 'altitude'),
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
    ),
  );
}

Future<bool> getGpsData(context) async {
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      openLocalisationAlert(context);
      return false;
    }
    getLocation(context);
    return true;
  }

  if (permission == LocationPermission.deniedForever) {
    openLocalisationAlert(context);
    return false;
  }
  getLocation(context);
  return true;
}

getLocation(context) async {
  Position _position = await Geolocator.getCurrentPosition();
  BlocProvider.of<FournisseurRegistrationCubit>(context)
      .updateGpsData(position: _position);
}

openLocalisationAlert(context) {
  Get.dialog(
    Center(
        child: Container(
      height: 100,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('Activez la localisation !',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center),
    )),
    barrierDismissible: true,
  );
}
