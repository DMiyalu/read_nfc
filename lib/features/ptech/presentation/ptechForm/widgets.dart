import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/widgets/gestionEtFonctionnement/widgets.dart';
import 'cubit/ptech_form_cubit.dart';
import 'cubit/ptech_form_state.dart';

Widget inputField(context,
    {required String hint,
    required String label,
    required String field,
    required String fieldName,
    TextEditingController? controller,
    bool initialValue = false,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    bool fieldRequired = true}) {
  return BlocBuilder<PtechFormCubit, PtechFormState>(builder: (context, state) {
    String defaultValue = state.field![field][fieldName];
    return TextFormField(
      // initialValue: defaultValue,
      // key: Key(defaultValue),
      controller: controller,
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
        Map? data = state.field![field];
        Map providerField = data ?? {fieldName: value};
        providerField[fieldName] = value;
        BlocProvider.of<PtechFormCubit>(context).onFieldChange(data!);
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

Widget intrantsListWidget(context) {
  return BlocBuilder<PtechFormCubit, PtechFormState>(builder: (context, state) {
    if (state.field!['data']['intrants'].isEmpty) {
      return const SizedBox.shrink();
    }

    final List intrants = state.field!['data']['intrants'];
    return Column(
      children: intrants
          .asMap()
          .entries
          .map((entry) =>
              intrantItem(context, intrant: entry.value, count: entry.key))
          .toList(),
    );
  });
}

Widget intrantItem(context, {required Map intrant, required count}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary.withOpacity(.15),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 4),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(.8),
            shape: BoxShape.circle,
          ),
          child: Text(
            (count + 1).toString(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 10,
                  color: Colors.white60,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Expanded(
          child: Ink(
            child: InkWell(
              onTap: () => Get.bottomSheet(
                intrantDetails(context, intrant: intrant),
              ),
              child: Text(
                intrant['name'].toString(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          radius: 5,
          splashColor: Theme.of(context).colorScheme.primary,
          onTap: () => BlocProvider.of<PtechFormCubit>(context).onRemoveIntrant(
            intrantName: intrant['name'],
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(
              Icons.delete_rounded,
              color: Colors.red,
              size: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget intrantDetails(context, {required Map intrant}) {
  return Container(
    height: 200,
    // width: 350,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleIntrantDetails(context, 'Nom intrant'),
        const SizedBox(height: 4),
        _valueIntrantDetails(context, intrant['intrantName']),
        const SizedBox(height: 10),
        _titleIntrantDetails(context, 'Prix/Surface'),
        const SizedBox(height: 4),
        _valueIntrantDetails(context, intrant['pricePerArea']),
        const SizedBox(height: 10),
        _titleIntrantDetails(context, 'Mode de stockage'),
        const SizedBox(height: 4),
        _valueIntrantDetails(context, intrant['stockageMode']),
        const SizedBox(height: 10),
      ],
    ),
  );
}

Widget _valueIntrantDetails(context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
    textAlign: TextAlign.left,
  );
}

Widget _titleIntrantDetails(context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText1,
    textAlign: TextAlign.left,
  );
}

Widget validation(context) {
  return BlocBuilder<PtechFormCubit, PtechFormState>(builder: (context, state) {
    if (!state.field!['showValidation']) {
      return const SizedBox.shrink();
    }
    return Text(
      'Vueillez bien remplir les champs',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: Colors.red,
          ),
    );
  });
}

// Widget loader(context) {
//   return BlocBuilder<PtechFormCubit, PtechFormState>(builder: (context, state) {
//     if (state.field!['sending']) {
//       return Center(
//         child: Ink(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: loader(context)),
//       );
//     }
//     return const SizedBox.shrink();
//   });
// }

Widget storageMode(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // sectionTitle(context, 'Mode de stockage'),
      BlocBuilder<PtechFormCubit, PtechFormState>(builder: (context, state) {
        return dropDownButtonFormField(
          context,
          label: 'Mode de stockage',
          field: 'data',
          fieldName: 'stockageMode',
          cubit: 'ptech',
          state: state,
          listValue: <String>['Par terre', 'Sur étalage'],
          value: 'Par terre',
          hintText: 'mode',
          textError: 'mode de stockage',
          validate: true,
        );
      }),
    ],
  );
}

Widget dropDownButtonFormField(context,
    {required List<String> listValue,
    required String fieldName,
    required String field,
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
                ? ((value == null || value == hintText)
                    ? 'Mettez $textError'
                    : null)
                : null;
          },
          onChanged: (Object? value) {
            Map? data = state.field![field];
            Map providerField = data ?? {fieldName: value};
            providerField[fieldName] = value.toString();
            BlocProvider.of<PtechFormCubit>(context).onFieldChange(data!);
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

Widget supplierSpecialty(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionTitle(context, 'Specialité du fournisseur'),
      specialityItem(
        context,
        label: 'Fertilisant',
        mainField: 'data',
        field: 'supplierSpecialty',
        subfield: 'fertilisant',
      ),
      specialityItem(
        context,
        label: 'Produits phyto-sanitaires',
        mainField: 'data',
        field: 'supplierSpecialty',
        subfield: 'produitPhytoSanitaire',
      ),
      specialityItem(
        context,
        label: 'Produits veterinaires',
        mainField: 'data',
        field: 'supplierSpecialty',
        subfield: 'produiVeterinaire',
      ),
      specialityItem(
        context,
        label: 'Semences',
        mainField: 'data',
        field: 'supplierSpecialty',
        subfield: 'semences',
      ),
      specialityItem(
        context,
        label: 'Services',
        mainField: 'data',
        field: 'supplierSpecialty',
        subfield: 'services',
      ),
      specialityItem(
        context,
        label: 'Autres',
        mainField: 'data',
        field: 'supplierSpecialty',
        subfield: 'autre',
      ),
    ],
  );
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
      child: BlocBuilder<PtechFormCubit, PtechFormState>(
          builder: (context, state) {
        return Ink(
          child: InkWell(
            onTap: () {
              Map data = state.field![mainField];
              final List specialities = state.field!['data']['specialities'];

              // Add Or Remove Subfield On Spcialities List
              if (data[field][subfield]) {
                specialities.remove(subfield);
              } else {
                specialities.add(subfield);
              }

              // Update (true/false) subfield status
              data[field] = {
                ...data[field],
                subfield: !data[field][subfield],
              };

              print('on Change radio button value: $data');
              BlocProvider.of<PtechFormCubit>(context).onFieldChange(data);
            },
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
                Ink(
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
              ],
            ),
          ),
        );
      }),
    ),
  );
}
