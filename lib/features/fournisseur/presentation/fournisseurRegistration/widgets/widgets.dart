import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigi_android/common/widgets/image.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantRegistration/cubit/cubit/demande_intrant_registration_cubit.dart';
import 'adresse/adresse.dart';
import 'capacite/capacite_fournisseur.dart';
import 'gestionEtFonctionnement/gestion_et_fonctionnement.dart';
import 'identitePersonnelle/identite_personnelle.dart';
import 'modePaiement/mode_paiement.dart';

AppBar appBarForm(context) {
  return AppBar(
    leading: IconButton(
        onPressed: () => BlocProvider.of<FournisseurRegistrationCubit>(context)
            .getToPreviousFormStep(),
        icon: const Icon(
          Icons.arrow_back,
        )),
    title: formTitle(context),
  );
}

Widget inputField(context,
    {required String hint,
    required String label,
    required String field,
    required String fieldName,
    bool initialValue = false,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    bool fieldRequired = true}) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(builder: (context, state) {
    String defaultValue = state.field![field][fieldName];
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyText1,
      enabled: enabled,
      decoration: InputDecoration(
        // suffixIcon: enabled ? const SizedBox.shrink() : _suffixIcon(context),
        counter: const SizedBox(),
        hintText: initialValue ? defaultValue : hint,
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
        Map? _data = state.field![field];
        Map _providerField = _data ?? {fieldName: value};
        _providerField[fieldName] = value;
        print('value: $_providerField');
        BlocProvider.of<FournisseurRegistrationCubit>(context)
            .updateField(context, data: _providerField, field: field);
      },
      validator: (String? value) {
        if (!fieldRequired) {
          return null;
        }

        if (value == "") {
          return "$label obligatoire";
        }
      },
    );
  });
}

// Widget _suffixIcon(context) {
//   return SizedBox(
//     child: Container(
//       constraints: const BoxConstraints(maxHeight: 12, maxWidth: 12),
//       width: 12,
//       height: 12,
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Theme.of(context).colorScheme.primary,
//           width: 1,
//         ),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         Icons.done_rounded,
//         size: 10,
//         color: Theme.of(context).colorScheme.primary,
//       ),
//     ),
//   );
// }

DateTime? getInitialDate({required String birthday}) {
  DateTime? _initialDate = (birthday == '') ? null : DateTime.parse(birthday);
  return _initialDate;
}

Widget birthdayField(context,
    {required String label,
    bool checkStep = false,
    required String field,
    required String fieldName}) {
  return Ink(
    decoration: const BoxDecoration(
      border: Border(
          bottom: BorderSide(
        color: Colors.grey,
        width: 1,
      )),
    ),
    child:
        BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
      builder: (context, state) {
        DateTime? _initialDate = getInitialDate(
            birthday: state.field!["providerIdentity"]["createdAt"].toString());

        return DateTimePicker(
          locale: const Locale('fr'),
          initialDate: _initialDate,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 13,
              ),
          decoration: InputDecoration(
            hintText: "Date",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 13,
                ),
            label: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            filled: true,
            fillColor: Colors.transparent,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusColor: Colors.black,
            hoverColor: Theme.of(context).colorScheme.secondary,
            labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          // checkStep
          // ? inputDecorationCheckField(context, label: 'Date de creation')
          // : inputDecoration(context, label: 'Date de creation'),
          type: DateTimePickerType.date,
          firstDate: DateTime(1940),
          lastDate: DateTime.now(),
          onChanged: (value) {
            Map? _data = state.field![field];
            Map _providerField = _data ?? {fieldName: value};
            _providerField[fieldName] = value;
            BlocProvider.of<FournisseurRegistrationCubit>(context)
                .updateField(context, data: _providerField, field: field);
          },
          validator: (val) {
            if (val == null || val.length == 0) {
              return "Mettez la date";
            }

            String _year = val.substring(0, 3);
            if (int.parse(_year) > 2002) {
              return "Age minimun recquis 18 ans";
            }
            return null;
          },
        );
      },
    ),
  );
}

InputDecoration inputDecorationCheckField(context, {String? label}) {
  return inputDecoration(context, label: label!).copyWith(
    // hintText: initialValue.toString(),
    labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 15,
          color: Theme.of(context).colorScheme.primary,
        ),
    // floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}

InputDecoration inputDecoration(context,
    {required String label, bool enable = true}) {
  return InputDecoration(
      constraints: const BoxConstraints(
        minHeight: 50,
        maxHeight: 50,
      ),
      filled: true,
      counter: const SizedBox.shrink(),
      fillColor: Theme.of(context).colorScheme.secondaryContainer,
      floatingLabelStyle: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: Theme.of(context).colorScheme.primary),
      focusColor: Colors.black,
      hoverColor: Theme.of(context).colorScheme.secondary,
      labelText: label,
      labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 15,
            color:
                enable ? Theme.of(context).colorScheme.secondary : Colors.grey,
          ),
      border: inputFieldBorderStyle(context),
      errorBorder: errorBorderStyle(context),
      enabledBorder: enableBorderStyle(context),
      disabledBorder: enableBorderStyle(context),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      hintStyle: Theme.of(context)
          .textTheme
          .bodyText1!
          .copyWith(color: Colors.black, fontSize: 13));
}

OutlineInputBorder inputFieldBorderStyle(context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:
          BorderSide(color: Theme.of(context).colorScheme.secondary, width: 1),
      gapPadding: 4.5);
}

OutlineInputBorder errorBorderStyle(context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red, width: 1),
      gapPadding: 4.5);
}

OutlineInputBorder enableBorderStyle(context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
      gapPadding: 4.5);
}

// Widget cameraValidationWidget(context) {
//   return BlocBuilder<FournisseurRegistrationCubit, FournisseurRegistrationState>(
//     builder: (context, state) {
//       if (state.field!['providerPhotoStatus'] == 200 && state.field!['providerIdentity']["photo"] == "")

//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text('Capture du fournisseur obligatoire', style: Theme.of(context).textTheme.bodyText1!.copyWith(
//             color: Colors.red,
//           ), textAlign: TextAlign.center,),
//         ),
//       );
//     }
//   );
// }

Widget cameraWidget(context) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(builder: (context, state) {
    if (state.field!['providerPhotoStatus'] == 200) return const SizedBox();
    return Flex(
      direction: Axis.horizontal,
      children: [
        pictureItem(
          context,
          text: 'Capturer photo',
          semanticLabel: 'Camera',
          icon: Icons.camera_alt_rounded,
          iconColor: Colors.blueGrey,
          onTap: () => BlocProvider.of<FournisseurRegistrationCubit>(context)
              .takePicture(
            mainfield: 'providerIdentity',
            status: 'providerPhotoStatus',
            source: ImageSource.camera,
          ),
        ),
        pictureItem(
          context,
          text: 'Joindre fichier',
          semanticLabel: 'Fichier',
          icon: Icons.attach_file_rounded,
          iconColor: Colors.purpleAccent,
          onTap: () => BlocProvider.of<FournisseurRegistrationCubit>(context)
              .takePicture(
            mainfield: 'providerIdentity',
            status: 'providerPhotoStatus',
            source: ImageSource.gallery,
          ),
        ),
      ],
    );
  });
}

Widget pictureItem(
  context, {
  required String text,
  required Function onTap,
  String? semanticLabel,
  IconData? icon,
  Color? iconColor,
}) {
  return Expanded(
    child: Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => onTap(),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).colorScheme.primary.withOpacity(.2)),
              child: Icon(
                icon,
                size: 20,
                color: iconColor,
                semanticLabel: semanticLabel!,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12,
                  ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget previewImage(context,
    {required String field,
    String? subfield,
    required String status,
    double width = 200,
    double height = 250}) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(builder: (context, state) {
    if (state.field![status] == 0) return const SizedBox();

    if (state.field![status] == 500) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Une erreur s\'est produite, réessayer la capture photo.',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state.field![status] == 200) {
      switch (field) {
        case "providerManagement":
          {
            String? base64string = state.field!['providerManagement']
                ['organeDeGestion']["photoRCCM"];
            if (base64string == null || base64string.isEmpty) {
              return const SizedBox.shrink();
            }

            // return Text("image data: ${base64string.toString()}",
            //     style: Theme.of(context).textTheme.bodyText1);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imagePreview(
                  base64String: base64string,
                  height: height,
                  width: width,
                ),
                const SizedBox(width: 5),
                removePicture(
                  context,
                  onTap: () =>
                      BlocProvider.of<FournisseurRegistrationCubit>(context)
                          .onDeletePicture(
                    mainfield: 'providerIdentity',
                    status: 'providerPhotoStatus',
                  ),
                ),
              ],
            );
          }

        case "providerIdentity":
          {
            String? base64string = state.field![field]["photo"];
            if (base64string == null || base64string == '') {
              return const SizedBox.shrink();
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(
                //   "image:${base64string.toString()}",
                //   softWrap: true,
                //   style: Theme.of(context).textTheme.bodyText1,
                // ),
                imagePreview(
                  base64String: base64string,
                  height: height,
                  width: width,
                ),
                const SizedBox(width: 20),
                removePicture(
                  context,
                  onTap: () =>
                      BlocProvider.of<FournisseurRegistrationCubit>(context)
                          .onDeletePicture(
                    mainfield: 'providerIdentity',
                    status: 'providerPhotoStatus',
                  ),
                ),
              ],
            );
          }

        default:
          return const SizedBox();
      }
    }
    return const SizedBox.shrink();
  });
}

Widget removePicture(context, {required Function onTap}) {
  return Ink(
    child: InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete,
              size: 18,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Supprimer',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.red,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    ),
  );
}

Widget formTitle(context) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(
    builder: (context, state) {
      String _title = state.field!['formTitle'] ?? '';
      return Text(
        _title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
      );
    },
  );
}

Widget formStep(context) {
  return BlocBuilder<FournisseurRegistrationCubit,
      FournisseurRegistrationState>(
    builder: (context, state) {
      int _step = state.field!['step'];

      if (_step == 1) return const IdentiteFournisseur();
      if (_step == 2) return const AdresseForm();
      if (_step == 3) return const GestionEtFonctionnement();
      if (_step == 4) return const ModePaiement();
      if (_step == 5) return const CapaciteFournisseur();
      return const SizedBox.shrink();
    },
  );
}

Widget dropDownButtonFormField(context,
    {required List<String> listValue,
    required String fieldName,
    required String field,
    String? subfield,
    required String cubit,
    String? value,
    required state,
    String? hintText,
    String? textError,
    required String label,
    bool validate = false,
    String? activityType}) {
  return Stack(
    children: [
      Text(
        label,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
      ),
      Container(
        constraints: const BoxConstraints(maxHeight: 43, minHeight: 43),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(.8),
                width: 1,
              ),
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            )),
        child: DropdownButtonFormField(
          elevation: 0,
          value: value,
          hint: Text(hintText!, style: Theme.of(context).textTheme.bodyText1),
          items: listValue.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          isExpanded: true,
          decoration: _dropDownInputDecoration(
            label: '',
            showLabel: false,
          ),
          alignment: Alignment.center,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 13,
                color: Theme.of(context).colorScheme.tertiary,
              ),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            size: 30,
            color: Theme.of(context).colorScheme.secondary.withOpacity(.4),
          ),
          validator: (value) {
            return validate
                ? ((value == null ||
                        value.toString().toLowerCase() ==
                            hintText.toLowerCase())
                    ? 'Mettez $textError'
                    : null)
                : null;
          },
          onChanged: (Object? _value) {
            print('** value selected: $_value');
            Map? data = state.field![field];
            Map providerField = {};

            if (subfield != null) {
              print("*** subfield: $subfield");
              providerField = data!;
              final Map subfieldData = {
                ...providerField[fieldName],
                subfield: _value,
              };

              providerField[fieldName] = subfieldData;
            } else {
              providerField = data ?? {fieldName: _value};
              providerField[fieldName] = _value.toString();
              print("** value: ${providerField.toString()}");
            }
            // Map _providerField = {};
            // if (subfield != '') {
            //   // _providerField = {..._data!};
            //   // _providerField[fieldName] = {subfield: _value.toString()};
            //   // print("** value: ${_providerField.toString()}");
            // } else {
            //   Map _providerField = _data ?? {fieldName: _value};
            //   _providerField[fieldName] = _value.toString();
            //   print("** value: ${_providerField.toString()}");
            // }

            if (cubit == 'fournisseur') {
              BlocProvider.of<FournisseurRegistrationCubit>(context)
                  .updateField(context,
                      data: providerField, field: field, fieldName: fieldName);
              return;
            }

            if (cubit == 'demandeIntrant') {
              BlocProvider.of<DemandeIntrantRegistrationCubit>(context)
                  .updateField(context, data: providerField, field: field);
              return;
            }
          },
        ),
      ),
    ],
  );
}

InputDecoration _dropDownInputDecoration(
    {required bool showLabel, required String label}) {
  return const InputDecoration(
    disabledBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    border: InputBorder.none,
    contentPadding: EdgeInsets.zero,
  );
}
