import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/appbar.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_cubit.dart';
import 'widgets.dart';

class ControlList extends StatefulWidget {
  const ControlList({Key? key}) : super(key: key);

  @override
  State<ControlList> createState() => _ControlListState();
}

class _ControlListState extends State<ControlList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        text: "Controle",
        onTap: () => Get.toNamed('/'),
      ),
      body: SingleChildScrollView(
        child: listControl(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionButton(
        context,
        icon: Icons.add,
        onTap: () {
          BlocProvider.of<ControlCubit>(context).initForm();
          Get.toNamed('/control_form');
        },
        tag: 'control',
      ),
    );
  }
}
