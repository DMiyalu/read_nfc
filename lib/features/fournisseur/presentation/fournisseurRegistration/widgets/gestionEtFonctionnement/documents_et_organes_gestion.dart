import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/widgets/gestionEtFonctionnement/widgets.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/widgets/widgets.dart';

enum SingingCharacter { oui, non }

class DocumentsEtOrganesDeGestion extends StatefulWidget {
  const DocumentsEtOrganesDeGestion({Key? key}) : super(key: key);

  @override
  State<DocumentsEtOrganesDeGestion> createState() =>
      _DocumentsEtOrganesDeGestionState();
}

class _DocumentsEtOrganesDeGestionState
    extends State<DocumentsEtOrganesDeGestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(context, 'Documents et organes de gestion'),
        const SizedBox(height: 5),
        item(context,
            label: 'Acte constitutif(Status)',
            mainField: 'providerManagement',
            field: 'organeDeGestion',
            subfield: 'acteConstitutif'),
        item(context,
            label: 'Réglement d\'ordre interieur',
            mainField: 'providerManagement',
            field: 'organeDeGestion',
            subfield: 'reglementInterieur'),
        item(context,
            label: 'Manuel de procédures',
            mainField: 'providerManagement',
            field: 'organeDeGestion',
            subfield: 'manuelDeProcedure'),
        item(context,
            label: 'Comptabilité',
            mainField: 'providerManagement',
            field: 'organeDeGestion',
            subfield: 'comptabilité'),
        photoButton(context),
        photoValidation(context),
        previewImage(
          context,
          field: "providerManagement",
          subfield: "organeDeGestion",
          status: "providerManagementPhotoStatus",
          width: 100,
          height: 40,
        ),
      ],
    );
  }

  Widget photoValidation(context) {
    return BlocBuilder<FournisseurRegistrationCubit,
        FournisseurRegistrationState>(builder: (context, state) {
      final String photo =
          state.field!['providerManagement']['organeDeGestion']['photoRCCM'];
      if (photo.isEmpty && state.field!['providerManagementPhotoStatus'] == 404) {
        return Text('Photo du document obligatoire', style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Colors.red,
          fontSize: 12,
        ),);
      }
      return const SizedBox.shrink();
    });
  }

  Widget photoButton(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photo de F92 ou RCCM',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: 5),
                Ink(
                  child: InkWell(
                    onTap: () =>
                        BlocProvider.of<FournisseurRegistrationCubit>(context)
                            .takePicture(
                      mainfield: 'providerManagement',
                      field: 'organeDeGestion',
                      status: 'providerManagementPhotoStatus',
                      source: ImageSource.camera,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Ajouter la photo',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item(context,
      {required String label,
      required String mainField,
      required String field,
      required String subfield}) {
    return Ink(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
        ],
      ),
    );
  }
}
