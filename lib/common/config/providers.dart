import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/common/screens/home-screen/cubit/animation_cubit.dart';
import 'package:sigi_android/features/control/presentation/cubit/control_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurDetails/cubit/fournisseur_details_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurList/cubit/fournisseur_list_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/cubit/cubit/fournisseur_registration_cubit.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/cubit/demande_intrant_list_cubit.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantRegistration/cubit/cubit/demande_intrant_registration_cubit.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantRegistration/cubit/nfc/nfc_read_cubit.dart';
import 'package:sigi_android/features/profil/presentation/cubit/profil_cubit.dart';
import 'package:sigi_android/features/ptech/presentation/ptechForm/cubit/ptech_form_cubit.dart';
import 'package:sigi_android/features/ptech/presentation/ptechList/cubit/ptech_cubit.dart';
import 'package:sigi_android/features/suivi/presentation/cubit/monitoring_cubit.dart';
import 'package:sigi_android/features/supervision/presentation/cubit/supervisor_cubit.dart';
import 'package:sigi_android/features/synchronization/download/cubit/synchronization_download_cubit.dart';

List getProviders() {
  return [
    BlocProvider<FournisseurRegistrationCubit>(
      create: (BuildContext context) => FournisseurRegistrationCubit(),
    ),
    BlocProvider<DemandeIntrantRegistrationCubit>(
      create: (BuildContext context) => DemandeIntrantRegistrationCubit(),
    ),
    BlocProvider<DemandeIntrantListCubit>(
      create: (BuildContext context) => DemandeIntrantListCubit(),
    ),
    BlocProvider<AnimationCubit>(
      create: (BuildContext context) => AnimationCubit(),
    ),
    BlocProvider<NfcReadCubit>(
      create: (BuildContext context) => NfcReadCubit(),
    ),
    BlocProvider<FournisseurDetailsCubit>(
      create: (BuildContext context) => FournisseurDetailsCubit(),
    ),
    BlocProvider<FournisseurListCubit>(
      create: (BuildContext context) => FournisseurListCubit(),
    ),
    BlocProvider<MonitoringCubit>(
      create: (BuildContext context) => MonitoringCubit(),
    ),
    BlocProvider<SupervisorCubit>(
      create: (BuildContext context) => SupervisorCubit(),
    ),
    BlocProvider<ControlCubit>(
      create: (BuildContext context) => ControlCubit(),
    ),
    BlocProvider<PtechCubit>(
      create: (BuildContext context) => PtechCubit(),
    ),
    BlocProvider<PtechFormCubit>(
      create: (BuildContext context) => PtechFormCubit(),
    ),
    BlocProvider<SynchronizationDownloadCubit>(
      create: (BuildContext context) => SynchronizationDownloadCubit(),
    ),
    BlocProvider<ProfilCubit>(
      create: (BuildContext context) => ProfilCubit(),
    ),
  ];
}
