import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import '../widgets.dart';
import 'documents_et_organes_gestion.dart';

Widget gestionEtFonctionnement(context, GlobalKey<FormState> formKey) {
  return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<FournisseurRegistrationCubit,
              FournisseurRegistrationState>(builder: (context, state) {
            return dropDownButtonFormField(
              context,
              label: 'Status légal',
              field: 'providerManagement',
              fieldName: 'legalType',
              cubit: 'fournisseur',
              state: state,
              listValue: <String>['Enregistré', 'Non enregistré'],
              value: 'Enregistré',
              hintText: 'Enregistré',
              textError: 'status legal',
              validate: true,
            );
          }),
          const SizedBox(height: 15),
          BlocBuilder<FournisseurRegistrationCubit,
              FournisseurRegistrationState>(builder: (context, state) {
            final List<String> legalStatus = state.field!['legalStatus'];
            return dropDownButtonFormField(
              context,
              label: 'Nature juridique',
              field: 'providerManagement',
              fieldName: 'legalStatus',
              cubit: 'fournisseur',
              state: state,
              listValue: legalStatus,
              value: legalStatus[0],
              hintText: 'Status Legal',
              textError: 'nature juridique',
              validate: true,
            );
          }),
          const SizedBox(height: 15),
          const DocumentsEtOrganesDeGestion(),
          const SizedBox(height: 15),
          personnel(context),
          const SizedBox(height: 25),
          turnover(context),
          const SizedBox(height: 35),
          fisc(context),
          const SizedBox(height: 25),
          certification(context),
          const SizedBox(height: 25),
          customButton(context,
              text: "Continuer",
              bkgColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white, onPressed: () async {
            if (formKey.currentState!.validate()) {
              bool documentPhotoExist =
                  await BlocProvider.of<FournisseurRegistrationCubit>(context)
                      .checkDocumentPhoto();
              if (!documentPhotoExist) return;
              BlocProvider.of<FournisseurRegistrationCubit>(context)
                  .getToNextFormStep();
            }
            return;
          }),
          const SizedBox(height: 15),
        ],
      ));
}

Widget certification(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(context, "Certification"),
      item(context,
          label: "Certifié",
          field: "certification",
          mainField: "providerManagement",
          subfield: "certifie"),
      personnelItem(context,
          hint: 'Agromwinda',
          validation: 'organisation',
          label: "Par quelle organisation",
          mainField: 'providerManagement',
          field: 'certification',
          subfield: 'organisation',
          maxLength: 20,
          textInputType: TextInputType.multiline),
      personnelItem(context,
          hint: 'ISO9000',
          validation: 'norme',
          label: "Norme nationnale ou internationnale",
          mainField: 'providerManagement',
          field: 'certification',
          subfield: 'norme',
          maxLength: 20,
          textInputType: TextInputType.multiline),
    ],
  );
}

Widget fisc(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      sectionTitle(context, "Fiscalité"),
      item(context,
          label: "Paye les taxes",
          field: "fisc",
          mainField: "providerManagement",
          subfield: "taxe"),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        if (state.field!['providerManagement']['fisc']['taxe']) {
          return personnelItem(context,
              hint: '0',
              validation: 'année',
              label: "Depuis quelle année",
              mainField: 'providerManagement',
              field: 'fisc',
              subfield: 'yearOld');
        }
        return const SizedBox.shrink();
      }),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        if (state.field!['providerManagement']['fisc']['taxe']) {
          return personnelItem(context,
              hint: 'taxe',
              validation: 'taxe',
              label: "Nom de la taxe",
              mainField: 'providerManagement',
              field: 'fisc',
              subfield: 'taxeName',
              maxLength: 15,
              textInputType: TextInputType.multiline);
        }
        return const SizedBox.shrink();
      }),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        if (state.field!['providerManagement']['fisc']['taxe']) {
          return personnelItem(context,
              hint: '0',
              validation: 'nbr',
              label: "Montant payé chaque mois",
              mainField: 'providerManagement',
              field: 'fisc',
              subfield: 'amountPaidMonth',
              maxLength: 10);
        }
        return const SizedBox.shrink();
      }),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        if (state.field!['providerManagement']['fisc']['taxe']) {
          return personnelItem(context,
              hint: '0',
              validation: 'montant',
              label: "Montant payé chaque trimestre",
              mainField: 'providerManagement',
              field: 'fisc',
              subfield: 'amountPaidQuarter',
              maxLength: 10);
        }
        return const SizedBox.shrink();
      }),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        if (state.field!['providerManagement']['fisc']['taxe']) {
          return personnelItem(context,
              hint: '0',
              validation: 'montant',
              label: "Montant payé annuellement",
              mainField: 'providerManagement',
              field: 'fisc',
              subfield: 'amountPaidAnnually',
              maxLength: 10);
        }
        return const SizedBox.shrink();
      }),
    ],
  );
}

Widget item(context,
    {required String label,
    required String mainField,
    required String field,
    required String subfield}) {
  return Ink(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      margin: const EdgeInsets.only(top: 25),
      child: Flex(
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
          BlocBuilder<FournisseurRegistrationCubit,
              FournisseurRegistrationState>(builder: (context, state) {
            return Ink(
              child: InkWell(
                onTap: () {
                  // Map? _data = state.field![mainField];
                  Map _providerField = state.field![mainField];
                  _providerField[field] = {
                    ..._providerField[field],
                    subfield: true,
                  };
                  print('on Change radio button value: $_providerField');
                  BlocProvider.of<FournisseurRegistrationCubit>(context)
                      .updateField(context,
                          data: _providerField, field: mainField);
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
            );
          }),
          const SizedBox(width: 3),
          Text(
            'Oui',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                ),
          ),
          const SizedBox(width: 15),
          BlocBuilder<FournisseurRegistrationCubit,
              FournisseurRegistrationState>(builder: (context, state) {
            return Ink(
              child: InkWell(
                onTap: () {
                  Map _providerField = state.field![mainField];
                  _providerField[field] = {
                    ..._providerField[field],
                    subfield: false,
                  };
                  BlocProvider.of<FournisseurRegistrationCubit>(context)
                      .updateField(context,
                          data: _providerField, field: mainField);
                },
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: state.field![mainField][field][subfield]
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  child: state.field![mainField][field][subfield]
                      ? const SizedBox.shrink()
                      : Icon(
                          Icons.done_rounded,
                          size: 12,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                ),
              ),
            );
          }),
          const SizedBox(width: 3),
          Text(
            'Non',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    ),
  );
}

Widget turnover(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(context, "Chiffre d'affaire de l'année passée"),
      BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
          builder: (context, state) {
        final List<String> turnOver = state.field!['turnOver'];
        return dropDownButtonFormField(
          context,
          label: '',
          field: 'providerManagement',
          fieldName: 'turnover',
          subfield: 'interval',
          cubit: 'fournisseur',
          state: state,
          listValue: turnOver,
          value: turnOver[0],
          hintText: "Chiffre d'affaire",
          textError: "Chiffre d'affaire",
          validate: true,
        );
      }),
    ],
  );
}

Widget personnel(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(context, 'Personnel'),
      const SizedBox(height: 5),
      personnelItem(context,
          hint: '0',
          validation: 'nbr',
          label: "Nombre de volontaires",
          mainField: 'providerManagement',
          field: 'personnel',
          subfield: 'nombreVolontaires'),
      // const SizedBox(height: 3),
      personnelItem(context,
          hint: '0',
          validation: 'nbr',
          label: "Nombre de staff payé",
          mainField: 'providerManagement',
          field: 'personnel',
          subfield: 'nombreStaff'),
    ],
  );
}

Widget personnelItem(context,
    {required String hint,
    required String validation,
    required String label,
    required String mainField,
    required String field,
    String? fieldName,
    bool initialValue = false,
    bool enabled = true,
    TextInputType textInputType = TextInputType.number,
    int maxLength = 4,
    required String subfield}) {
  return Flex(
    direction: Axis.horizontal,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14,
                // fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.tertiary,
              ),
          textAlign: TextAlign.left,
          softWrap: true,
        ),
      ),
      const SizedBox(width: 4),
      SizedBox(
        width: 90,
        height: 45,
        child: BlocBuilder<FournisseurRegistrationCubit,
            FournisseurRegistrationState>(builder: (context, state) {
          return TextFormField(
            maxLength: maxLength,
            maxLines: 1,
            keyboardType: textInputType,
            style: Theme.of(context).textTheme.bodyText1,
            enabled: enabled,
            decoration: InputDecoration(
              counter: const SizedBox(),
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(vertical: 2),
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 13),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusColor: Colors.black,
              hoverColor: Theme.of(context).colorScheme.secondary,
              isCollapsed: false,
            ),
            onChanged: (String value) {
              Map _providerField = state.field![mainField];
              _providerField[field] = {
                ..._providerField[field],
                subfield: value,
              };
              BlocProvider.of<FournisseurRegistrationCubit>(context)
                  .updateField(context,
                      data: _providerField,
                      field: mainField,
                      fieldName: fieldName);
            },
            validator: (String? value) {
              if (value == "" && enabled) {
                return label;
              }
            },
          );
        }),
      ),
    ],
  );
}

Widget sectionTitle(context, String? text) {
  return Text(
    text!,
    style: Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(fontSize: 13, fontWeight: FontWeight.bold),
    textAlign: TextAlign.left,
  );
}
