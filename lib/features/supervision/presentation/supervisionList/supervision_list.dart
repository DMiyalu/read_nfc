import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/appbar.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_cubit.dart';
import 'widgets.dart';

class Supervision extends StatefulWidget {
  const Supervision({Key? key}) : super(key: key);

  @override
  State<Supervision> createState() => _SupervisionState();
}

class _SupervisionState extends State<Supervision> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        text: "Supervision",
        onTap: () => Get.toNamed('/'),
      ),
      body: SingleChildScrollView(
        child: listSupervision(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionButton(
        context,
        icon: Icons.add,
        onTap: () {
          BlocProvider.of<SupervisorCubit>(context).initForm();
          Get.toNamed('/supervision_form');
        },
        tag: 'supervision',
      ),
    );
  }
}
