import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/features/fournisseur/data/fournisseur_model.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurList/cubit/fournisseur_list_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import '../gestionEtFonctionnement/widgets.dart';
import '../widgets.dart';

Widget capaciteFournisseur(context, GlobalKey<FormState> formKey) {
  return Form(
      key: formKey,
      child: Column(
        children: [
          area(context),
          const SizedBox(height: 25),
          storageMode(context),
          const SizedBox(height: 30),
          sectionTitle(context, 'Specialité du fournisseur'),
          supplierSpecialty(context),
          const SizedBox(height: 30),
          businessNetwork(context),
          const SizedBox(height: 25),
          _loader(context),
          const SizedBox(height: 25),
          customButton(context,
              text: "Enregistrer",
              bkgColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white, onPressed: () async {
            if (formKey.currentState!.validate()) {
              await BlocProvider.of<FournisseurRegistrationCubit>(context)
                  .getSupplierSpecialtyList();

              Fournisseur? fournisseur =
                  await BlocProvider.of<FournisseurRegistrationCubit>(context)
                      .onSubmit(context);

              if (fournisseur != null) {
                BlocProvider.of<FournisseurListCubit>(context)
                    .onRefreshFournisseurs(fournisseur);
                Get.offAllNamed('/', arguments: 1);
                return;
              }
              Get.snackbar("", "Erreur lors de l'envoie");
              return;
            }
            return;
          }),
          const SizedBox(height: 20),
        ],
      ));
}

Widget _loader(context) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(builder: (context, state) {
    return state.field!['sending'] ? loader(context) : const SizedBox.shrink();
  });
}

Widget businessNetwork(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(context, 'Réseau d\'affaire'),
      item(
        context,
        label: "Affilié à une OP",
        field: "businessNetwork",
        mainField: "providerCapacity",
        subfield: "affiliatedAtOP",
      ),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        final bool affiliatedAtOP = state.field!['providerCapacity']
            ['businessNetwork']['affiliatedAtOP'];
        final List<String> businessNetwork = state.field!['businessNetwork'];
        if (affiliatedAtOP) {
          return dropDownButtonFormField(
            context,
            label: '',
            field: 'providerCapacity',
            fieldName: 'businessNetwork',
            subfield: 'which',
            cubit: 'fournisseur',
            state: state,
            listValue: businessNetwork,
            value: businessNetwork[0],
            hintText: 'Organisation',
            textError: 'Organisation d\'affiliation',
            validate: true,
          );

          // personnelItem(
          //   context,
          //   hint: 'Organisation',
          //   validation: '',
          //   label: "Laquelle",
          //   mainField: 'providerCapacity',
          //   field: 'businessNetwork',
          //   subfield: 'which',
          //   maxLength: 15,
          //   textInputType: TextInputType.multiline,
          // );
        }
        return const SizedBox();
      }),
    ],
  );
}

Widget supplierSpecialty(context) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(builder: (context, state) {
    final Map supplierSpecialty =
        state.field!['providerCapacity']['supplierSpecialty'];

    if (supplierSpecialty.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: supplierSpecialty.keys.map((speciality) {
          return specialityItem(
            context,
            label: speciality.toString().capitalizeFirst!,
            mainField: 'providerCapacity',
            field: 'supplierSpecialty',
            subfield: speciality.toString().toLowerCase(),
          );
        }).toList()

        // [
        //   // sectionTitle(context, 'Specialité du fournisseur'),
        //   specialityItem(
        //     context,
        //     label: 'Fertilisant',
        //     mainField: 'providerCapacity',
        //     field: 'supplierSpecialty',
        //     subfield: 'fertilisant',
        //   ),
        //   specialityItem(
        //     context,
        //     label: 'Produits phyto-sanitaires',
        //     mainField: 'providerCapacity',
        //     field: 'supplierSpecialty',
        //     subfield: 'produitPhytoSanitaire',
        //   ),
        //   specialityItem(
        //     context,
        //     label: 'Produits veterinaires',
        //     mainField: 'providerCapacity',
        //     field: 'supplierSpecialty',
        //     subfield: 'produiVeterinaire',
        //   ),
        //   specialityItem(
        //     context,
        //     label: 'Semences',
        //     mainField: 'providerCapacity',
        //     field: 'supplierSpecialty',
        //     subfield: 'semences',
        //   ),
        //   specialityItem(
        //     context,
        //     label: 'Services',
        //     mainField: 'providerCapacity',
        //     field: 'supplierSpecialty',
        //     subfield: 'services',
        //   ),
        //   specialityItem(
        //     context,
        //     label: 'Autree',
        //     mainField: 'providerCapacity',
        //     field: 'supplierSpecialty',
        //     subfield: 'autre',
        //   ),
        // ],
        );
  });
}

Widget specialityItem(context,
    {required String label,
    required String mainField,
    required String field,
    required String subfield}) {
  return Ink(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      margin: const EdgeInsets.only(top: 25),
      child: BlocBuilder<FournisseurRegistrationCubit,
          FournisseurRegistrationState>(builder: (context, state) {
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                    ),
              ),
            ),
            Ink(
              child: InkWell(
                onTap: () {
                  // Map? _data = state.field![mainField];
                  Map _providerField = state.field![mainField];
                  _providerField[field] = {
                    ..._providerField[field],
                    subfield: !_providerField[field][subfield],
                  };
                  print('on Change radio button value: $_providerField');
                  BlocProvider.of<FournisseurRegistrationCubit>(context)
                      .updateField(
                    context,
                    data: _providerField,
                    field: mainField,
                  );
                },
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: state.field![mainField][field][subfield]
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.tertiary,
                      width: 1,
                    ),
                  ),
                  child: state.field![mainField][field][subfield]
                      ? Center(
                          child: Icon(
                            Icons.done_rounded,
                            size: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        );
      }),
    ),
  );
}

Widget area(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(context, 'Superficie du dépot'),
      personnelItem(context,
          hint: '0',
          validation: 'Longueur',
          label: "Longueur(m)",
          mainField: 'providerCapacity',
          field: 'area',
          fieldName: 'longueur',
          subfield: 'length'),
      personnelItem(context,
          hint: '0',
          validation: 'Largeur',
          label: "Largeur(m)",
          mainField: 'providerCapacity',
          field: 'area',
          fieldName: 'largeur',
          subfield: 'lenght'),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        return personnelItem(context,
            hint: state.field!['providerCapacity']['area']['totalArea']
                .toString(),
            validation: '',
            label: "Superficie totale(m²)",
            mainField: 'providerCapacity',
            field: 'area',
            enabled: false,
            subfield: 'totalArea');
      }),
    ],
  );
}

Widget storageMode(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // sectionTitle(context, 'Mode de stockage'),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        final List<String> productDisplayMode =
            state.field!['productDisplayMode'];
        return dropDownButtonFormField(
          context,
          label: 'Mode de stockage',
          field: 'providerCapacity',
          fieldName: 'storageMode',
          cubit: 'fournisseur',
          state: state,
          listValue: productDisplayMode,
          value: productDisplayMode[0],
          hintText: 'mode',
          textError: 'mode de stockage',
          validate: true,
        );
      }),
    ],
  );
}
