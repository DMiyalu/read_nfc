import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/widgets/widgets.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/cubit/demande_intrant_list_cubit.dart';

import '../cubit/cubit/demande_intrant_registration_cubit.dart';
import '../cubit/nfc/nfc_read_cubit.dart';

Widget previewProductorInfos(context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        inputField(context,
            hint: "2563JKMD023",
            label: "NUI",
            fieldRequired: false,
            enabled: false),
        const SizedBox(height: 10),
        inputField(context,
            hint: "Masampu Mulanda Damien",
            label: "Nom producteur",
            enabled: false,
            fieldRequired: false),
        const SizedBox(height: 10),
        inputField(context, hint: "M", label: "Sexe", enabled: false),
        const SizedBox(height: 10),
        inputField(context,
            hint: "29-03-2022",
            label: "Date de naissance",
            fieldRequired: false,
            enabled: false),
        const SizedBox(height: 10),
        inputField(
          context,
          hint: "+243 822 800 063",
          label: "Téléphone",
          fieldRequired: false,
          enabled: false,
        ),
        const SizedBox(height: 10),
        inputField(
          context,
          hint: "8",
          label: "Taille du ménage",
          fieldRequired: false,
          enabled: false,
        ),
        const SizedBox(height: 10),
        inputField(
          context,
          hint: "-4.32820434124682215",
          label: "Longitude",
          fieldRequired: false,
          enabled: false,
        ),
        const SizedBox(height: 10),
        inputField(
          context,
          hint: "15.24682215328204341",
          label: "Latitude",
          fieldRequired: false,
          enabled: false,
        ),
        const SizedBox(height: 10),
        inputField(
          context,
          hint: "256",
          label: "Altitude",
          fieldRequired: false,
          enabled: false,
        ),
        const SizedBox(height: 40),
        customButton(context,
            text: "Continuer",
            bkgColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white, onPressed: () {
          if (formKey.currentState!.validate()) {
            BlocProvider.of<DemandeIntrantRegistrationCubit>(context)
                .goToNextFormStep();
          }
          return;
        })
      ],
    ),
  );
}

Widget demandeIntrantRegistrationFormNextStep(
    context, GlobalKey<FormState> formKey) {
  return Form(
    key: formKey,
    child: Column(
      children: [
        BlocBuilder<DemandeIntrantRegistrationCubit,
            DemandeIntrantRegistrationState>(builder: (context, state) {
          return dropDownButtonFormField(
            context,
            label: 'PTech',
            field: 'data',
            fieldName: 'ptech',
            cubit: 'demandeIntrant',
            state: state,
            listValue: <String>[
              'Produits phytosanitaires',
              'Graines',
              'Semences',
              'Trackteur',
              'Machette'
            ],
            value: 'Produits phytosanitaires',
            hintText: 'PTech',
            textError: 'Paquet technologique',
            validate: true,
          );
        }),
        const SizedBox(height: 10),
        inputField(context,
            hint: "0.0",
            label: "Longueuer (m)",
            field: 'data',
            keyboardType: TextInputType.phone,
            fieldName: 'longueur'),
        const SizedBox(height: 10),
        inputField(context,
            hint: "0.0",
            label: "Largeur (m)",
            field: 'data',
            keyboardType: TextInputType.phone,
            fieldName: 'largeur'),
        const SizedBox(height: 10),
        BlocBuilder<DemandeIntrantRegistrationCubit,
            DemandeIntrantRegistrationState>(builder: (context, state) {
          return inputField(context,
              hint: state.field!['data']['surface'],
              label: "Surface (m²)",
              field: 'data',
              enabled: false,
              fieldName: 'surface');
        }),
        const SizedBox(height: 10),
        BlocBuilder<DemandeIntrantRegistrationCubit,
            DemandeIntrantRegistrationState>(builder: (context, state) {
          return dropDownButtonFormField(
            context,
            label: 'Fournisseur',
            field: 'data',
            fieldName: 'fournisseur',
            cubit: 'demandeIntrant',
            state: state,
            listValue: <String>[
              'AgroMwinda',
              'Legunet',
              'BioFood',
              'AgriTech',
              'AgriFood'
            ],
            value: 'AgroMwinda',
            hintText: 'AgroMwinda',
            textError: 'Fournisseur',
            validate: true,
          );
        }),
        // inputField(context,
        //     hint: "AgroMwinda",
        //     label: "Choix du fournisseur",
        //     field: 'data',
        //     fieldName: 'fournisseur',
        //     fieldRequired: true),
        const SizedBox(height: 10),
        inputField(context,
            hint: "Kwilu",
            label: "Zone d'action",
            field: 'data',
            fieldName: 'zoneDaction'),
        const SizedBox(height: 10),
        inputField(context,
            hint: "Mbaza-Ngungu",
            label: "Territoire",
            field: 'data',
            fieldName: 'territoire'),
        const SizedBox(height: 40),
        _loader(context),
        const SizedBox(height: 20),
        customButton(context,
            text: "Terminer",
            bkgColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white, onPressed: () async {
          if (formKey.currentState!.validate()) {
            final result =
                await BlocProvider.of<DemandeIntrantRegistrationCubit>(context)
                    .sendFundingRequest(context);

            if (result != null) {
              BlocProvider.of<DemandeIntrantListCubit>(context)
                  .onRefreshFundingRequest(result);
              Get.toNamed('/', arguments: 2);
              return;
            }
          }
          return;
        })
      ],
    ),
  );
}

Widget _loader(context) {
  return BlocBuilder<DemandeIntrantRegistrationCubit,
      DemandeIntrantRegistrationState>(builder: (context, state) {
    return state.field!['sending'] ? loader(context) : const SizedBox.shrink();
  });
}

Widget dataContent(context) {
  return BlocBuilder<NfcReadCubit, NfcReadState>(builder: (context, state) {
    Map onReadStatus = state.field!['onReadStatus'];

    if (onReadStatus['during'] && onReadStatus['code'] == 0) {
      return loader(context);
    }

    if (!onReadStatus['during'] && onReadStatus['code'] == 0) {
      return const SizedBox();
    }

    if (!onReadStatus['during'] && onReadStatus['code'] == 500) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lecture de la carte a echouée. Essayez à nouveau!',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              onReadStatus['data'].toString(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    }

    if (!onReadStatus['during'] && onReadStatus['code'] == 503) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('Veuillez activer le NFC',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center),
      );
    }

    if (!onReadStatus['during'] && onReadStatus['code'] == 200) {
      Map data = onReadStatus['data'];
      return previewContent(context, data: data);
    }

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Text('Opération echouée = $onReadStatus',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center),
    );
  });
}

Widget previewContent(context, {required Map data, Widget? actionButton}) {
  return Column(
    children: [
      RichText(
        softWrap: true,
        textAlign: TextAlign.left,
        text: TextSpan(
            text: "NUI: ",
            style: Theme.of(context).textTheme.bodyText1,
            children: [
              TextSpan(
                  text: data['personnalIdentity']['nui'] ?? "vide",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 18))
            ]),
      ),
      const SizedBox(height: 10),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            previewItem(context,
                field: 'Nom',
                value: data['personnalIdentity']['lastName'] ?? 'vide'),
            previewItem(context,
                field: 'Prenom',
                value: data['personnalIdentity']['firstName'] ?? 'vide'),
            const SizedBox(height: 10),
            actionButton ?? const SizedBox.shrink(),
          ],
        ),
      ),
    ],
  );
}

Widget previewItem(context, {required String field, required String value}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: RichText(
      softWrap: true,
      textAlign: TextAlign.left,
      text: TextSpan(
          text: "$field\n",
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
                text: "$value",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w300))
          ]),
    ),
  );
}

Widget clearButton(context) {
  return BlocBuilder<NfcReadCubit, NfcReadState>(builder: (context, state) {
    Map onReadStatus = state.field!['onReadStatus'];
    return (!onReadStatus['during'] && onReadStatus['code'] != 0)
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: customButton(context,
                text: "Actualiser",
                bigger: true,
                bkgColor: Colors.transparent,
                showBorder: true,
                textColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
              // BlocProvider.of<NfcReadCubit>(context).clearNfcData()),
            }))
        : const SizedBox();
  });
}

Widget notificationStatus(context) {
  return BlocBuilder<NfcReadCubit, NfcReadState>(builder: (context, state) {
    Map onReadStatus = state.field!['onReadStatus'];
    return (!onReadStatus['during'] && onReadStatus['code'] != 0)
        ? const SizedBox.shrink()
        : _notificationStatus(
            context,
            title: 'Veuillez approcher la carte NFC du téléphone',
            subtitle:
                "Rapprochez la carte d'au moins 10 cm du téléphone pour une lecture optimale",
          );
  });
}

Widget _notificationStatus(context,
    {required String title,
    required String subtitle,
    String? error,
    Color? bkgColor,
    Color? borderColor}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color:
            bkgColor ?? Theme.of(context).colorScheme.primary.withOpacity(.4),
        border: Border(
          top: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.primary,
            width: 3,
          ),
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
        )),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset("assets/images/feather-alert-circle.svg",
            alignment: Alignment.center,
            height: 18,
            width: 18,
            color: Theme.of(context).colorScheme.secondary.withOpacity(.9)),
        const SizedBox(width: 10),
        Flexible(
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.left,
            text: TextSpan(
                text: "$title\n",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 10,
                    ),
                children: [
                  TextSpan(
                      text: "$subtitle\n",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            // color: Theme.of(context).colorScheme.background,
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                          )),
                  (error != null)
                      ? TextSpan(
                          text: "Erreur: $error",
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    // color: Theme.of(context).colorScheme.background,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ))
                      : const TextSpan()
                ]),
          ),
        )
      ],
    ),
  );
}

Widget inputField(context,
    {required String hint,
    required String label,
    String? field,
    String? fieldName,
    bool fieldRequired = false,
    TextInputType? keyboardType,
    bool enabled = true}) {
  return BlocBuilder<DemandeIntrantRegistrationCubit,
      DemandeIntrantRegistrationState>(builder: (context, state) {
    return Container(
      decoration: BoxDecoration(
        color: enabled
            ? Colors.blueGrey.shade100.withOpacity(.3)
            : Colors.transparent,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        enabled: enabled,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          suffixIcon: !enabled ? _suffix(context) : const SizedBox.expand(),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 15,
            maxWidth: 15,
          ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).colorScheme.tertiary, fontSize: 13),
          // labelText: label,
          label: RichText(
            text: TextSpan(
              text: fieldRequired ? '*' : '',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.red,
                    fontSize: 16,
                  ),
              children: <TextSpan>[
                TextSpan(
                    text: label,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusColor: Colors.black,
          hoverColor: Theme.of(context).colorScheme.secondary,
          labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15,
                color: Theme.of(context).colorScheme.tertiary,
              ),
        ),
        onChanged: (String value) {
          Map? data = state.field![field];
          Map providerField = data ?? {fieldName: value};
          providerField[fieldName] = value;
          BlocProvider.of<DemandeIntrantRegistrationCubit>(context).updateField(
              context,
              data: providerField,
              field: field!,
              fieldName: fieldName);
        },
        validator: (String? value) {
          return null;
        },
      ),
    );
  });
}

Widget _suffix(context) {
  return SizedBox(
    height: 16,
    width: 16,
    child: Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.green,
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.done,
        color: Colors.green,
        size: 9,
      ),
    ),
  );
}

Widget nfcIcon(context, {required String fieldStatus, Function? onTap}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 25),
    child: GestureDetector(
      onTap: () => onTap!(),
      child: BlocBuilder<NfcReadCubit, NfcReadState>(builder: (context, state) {
        Map fieldStatus_ = state.field![fieldStatus];

        return Icon(Icons.nfc_rounded,
            size: 120,
            color: (fieldStatus_['code'] == 200)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary.withOpacity(.7));
      }),
    ),
  );
}
