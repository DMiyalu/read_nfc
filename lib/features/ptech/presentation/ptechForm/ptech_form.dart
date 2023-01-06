// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/appbar.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/ptech/data/ptech_model.dart';
import 'package:sigi_android/features/ptech/presentation/ptechForm/cubit/ptech_form_cubit.dart';
import 'package:sigi_android/features/ptech/presentation/ptechList/cubit/ptech_cubit.dart';
import 'widgets.dart';

class PtechForm extends StatefulWidget {
  const PtechForm({Key? key}) : super(key: key);

  @override
  State<PtechForm> createState() => _PtechFormState();
}

class _PtechFormState extends State<PtechForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ptechNameController = TextEditingController();
  final TextEditingController _intrantNameController = TextEditingController();
  final TextEditingController _intrantPriceController = TextEditingController();
  final TextEditingController _intrantStockageModeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: "PTech", onTap: () => Get.back()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            inputField(
              context,
              field: 'data',
              fieldName: 'name',
              hint: 'Surintrants',
              label: 'Nom du Ptech',
              enabled: true,
              fieldRequired: true,
              controller: _ptechNameController,
            ),
            const SizedBox(height: 20),
            Text(
              'Ajoutez des intrants pour ce Ptech',
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            inputField(context,
                field: 'data',
                fieldName: 'intrantName',
                hint: 'Tracteur',
                label: 'Intrants du Ptech',
                enabled: true,
                fieldRequired: true,
                controller: _intrantNameController),
            // intrantsListWidget(context),
            inputField(
              context,
              field: 'data',
              fieldName: 'pricePerArea',
              hint: '0.00 Fc',
              label: 'Prix/Surface',
              keyboardType: TextInputType.number,
              enabled: true,
              fieldRequired: true,
              controller: _intrantPriceController,
            ),
            const SizedBox(height: 20),
            storageMode(context),
            const SizedBox(height: 30),
            supplierSpecialty(context),
            const SizedBox(height: 25),
            customButton(
              context,
              text: 'Ajouter intrant',
              bkgColor: Colors.transparent,
              showBorder: true,
              textColor: Theme.of(context).colorScheme.primary,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<PtechFormCubit>(context).onAddIntrant();
                  setState(() {
                    _intrantNameController.clear();
                    _intrantPriceController.clear();
                    _intrantStockageModeController.clear();
                  });
                }
                return;
              },
            ),
            const SizedBox(height: 20),
            intrantsListWidget(context),
            const SizedBox(height: 20),
            validation(context),
            // loader(context),
            customButton(
              context,
              text: 'Terminer',
              bkgColor: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              onPressed: () async {
                final PtechModel? result =
                    await BlocProvider.of<PtechFormCubit>(context)
                        .onSendPtech();
                if (result == null) {
                  return;
                }
                BlocProvider.of<PtechCubit>(context).onRefreshPtechs(result);
                Get.offAllNamed('/ptech_list');
              },
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
