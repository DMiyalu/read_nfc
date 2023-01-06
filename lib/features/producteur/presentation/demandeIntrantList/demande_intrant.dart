import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantRegistration/cubit/cubit/demande_intrant_registration_cubit.dart';
import 'widgets/widgets.dart';

class DemandeIntrant extends StatefulWidget {
  const DemandeIntrant({Key? key}) : super(key: key);

  @override
  State<DemandeIntrant> createState() => _DemandeIntrantState();
}

class _DemandeIntrantState extends State<DemandeIntrant>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              savedList(context),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingActionButton(context,
          tag: 'demande_intrant_registration',
          icon: Icons.add_rounded, onTap: () {
        BlocProvider.of<DemandeIntrantRegistrationCubit>(context).initForm();
        Get.toNamed('/demande_intrant_registration_form');
      }),
    );
  }
}
