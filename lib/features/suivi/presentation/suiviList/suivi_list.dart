import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/appbar.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_cubit.dart';
import 'widgets.dart';

class SuiviList extends StatefulWidget {
  const SuiviList({Key? key}) : super(key: key);

  @override
  State<SuiviList> createState() => _SuiviListState();
}

class _SuiviListState extends State<SuiviList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        text: "Suivi",
        onTap: () => Get.toNamed('/'),
      ),
      body: SingleChildScrollView(
        child: listSuivi(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionButton(
        context,
        icon: Icons.add,
        onTap: () {
          BlocProvider.of<MonitoringCubit>(context).initForm();
          Get.toNamed('/suivi_registration');
        },
        tag: 'suivi',
      ),
    );
  }
}
