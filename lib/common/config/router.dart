import 'package:get/get.dart';
import 'package:sigi_android/common/screens/home-screen/home.dart';
import 'package:sigi_android/common/screens/routestack.dart';
import 'package:sigi_android/features/aide/presentation/aide.dart';
import 'package:sigi_android/features/authentication/presentation/login/login.dart';
import 'package:sigi_android/features/control/presentation/controlForm/control_form.dart';
import 'package:sigi_android/features/control/presentation/controlList/control_list.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurRegistration/fournisseur_registration.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantRegistration/demande_intrant_registration.dart';
import 'package:sigi_android/features/ptech/presentation/ptechForm/ptech_form.dart';
import 'package:sigi_android/features/ptech/presentation/ptechList/ptech_list.dart';
import 'package:sigi_android/features/search/presentation/search.dart';
import 'package:sigi_android/features/suivi/presentation/suiviList/suivi_list.dart';
import 'package:sigi_android/features/suivi/presentation/suiviRegistration/suivi_registration.dart';
import 'package:sigi_android/features/supervision/presentation/supervisionForm/supervision_form.dart';
import 'package:sigi_android/features/supervision/presentation/supervisionList/supervision_list.dart';
import 'package:sigi_android/splash.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/', page: () => const Home(), transition: Transition.cupertino),
    GetPage(
        name: '/splash',
        page: () => const SplashScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/routestack',
        page: () => const RouteStack(),
        transition: Transition.cupertino),
    GetPage(
        name: '/login',
        page: () => const Login(),
        transition: Transition.cupertino),
    GetPage(
        name: '/search',
        page: () => const SearchScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/fournisseur_registration_form',
        page: () => const FournisseurRegistration(),
        transition: Transition.cupertino),
    GetPage(
        name: '/demande_intrant_registration_form',
        page: () => const DemandeIntrantRegistration(),
        transition: Transition.cupertino),
    GetPage(
        name: '/aide',
        page: () => const AideScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/suivi',
        page: () => const SuiviList(),
        transition: Transition.cupertino),
    GetPage(
        name: '/suivi_registration',
        page: () => const SuiviRegistration(),
        transition: Transition.cupertino),
    GetPage(
        name: '/supervision',
        page: () => const Supervision(),
        transition: Transition.cupertino),
    GetPage(
        name: '/supervision_form',
        page: () => const SupervisorForm(),
        transition: Transition.cupertino),
    GetPage(
        name: '/control',
        page: () => const ControlList(),
        transition: Transition.cupertino),
    GetPage(
        name: '/control_form',
        page: () => const ControlForm(),
        transition: Transition.cupertino),
    GetPage(
        name: '/ptech_list',
        page: () => const PtechList(),
        transition: Transition.cupertino),
    GetPage(
        name: '/ptech_form',
        page: () => const PtechForm(),
        transition: Transition.cupertino),
  ];
}
