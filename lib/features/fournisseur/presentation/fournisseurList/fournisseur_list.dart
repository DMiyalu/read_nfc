import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/custom_button.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/widgets/adresse/widgets.dart';
import '../widgets/widgets.dart';
import 'cubit/fournisseur_list_cubit.dart';

class FournisseurList extends StatefulWidget {
  const FournisseurList({Key? key}) : super(key: key);

  @override
  State<FournisseurList> createState() => _FournisseurListState();
}

class _FournisseurListState extends State<FournisseurList>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool serviceEnabled;

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
              savedList(context),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingActionButton(
        context,
        tag: 'fournisseur_registration',
        icon: Icons.person_add_rounded,
        onTap: () async {
          serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (serviceEnabled) {
            getGpsData(context);
            BlocProvider.of<FournisseurRegistrationCubit>(context).initForm();
            Get.toNamed('/fournisseur_registration_form');
            return;
          }
          openLocalisationAlert(context);
          return;
        },
      ),
    );
  }
}
