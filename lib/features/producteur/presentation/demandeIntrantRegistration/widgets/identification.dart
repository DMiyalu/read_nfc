// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import '../cubit/cubit/demande_intrant_registration_cubit.dart';
import 'widgets_form.dart';

class Identification extends StatefulWidget {
  const Identification({Key? key}) : super(key: key);

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  static const platformRead = MethodChannel("pnda/rna/nfc/read");
  final _formKey = GlobalKey<FormState>();
  String? _nfcData;

  Future<void> _getDataReadNfc() async {
    print("get read 1");
    // await BlocProvider.of<NfcCubit>(context).onStartNfcReading();
    try {
      final String result =
          await platformRead.invokeMethod("startBiometricNfc");

      setState(() {
        _nfcData = result;
      });
      // await BlocProvider.of<NfcCubit>(context).onStopNfcReading(result);
    } on PlatformException catch (e) {
      print('error: ${e.toString()}');
      // await BlocProvider.of<NfcCubit>(context).onStopNfcReading("500");
    }
  }

  Widget _readNfc() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        nfcIcon(
          context,
          fieldStatus: 'onReadStatus',
          onTap: () => _getDataReadNfc(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: customButton(
            context,
            onPressed: () {
              BlocProvider.of<DemandeIntrantRegistrationCubit>(context)
                  .goToNextFormStep();
            },
            // onPressed: () => _getDataReadNfc(),
            text: "Lire NFC",
            bkgColor: Theme.of(context).colorScheme.primary,
            textColor: Colors.white,
            bigger: true,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        dataContent(context),
        clearButton(context),
        notificationStatus(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          inputField(
            context,
            hint: _nfcData ?? '-- -- -- --',
            label: "NUI",
            fieldRequired: false,
            enabled: false,
          ),
          _readNfc(),
        ],
      ),
    );
  }
}
