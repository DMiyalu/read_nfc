import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/screens/home-screen/cubit/animation_cubit.dart';
import 'package:sigi_android/common/screens/home-screen/widgets/drawer/navigation_drawer_widget.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurList/cubit/fournisseur_list_cubit.dart';
import 'package:sigi_android/features/fournisseur/presentation/fournisseurList/fournisseur_list.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/cubit/demande_intrant_list_cubit.dart';
import 'package:sigi_android/features/producteur/presentation/demandeIntrantList/demande_intrant.dart';
import 'package:sigi_android/features/profil/presentation/profil.dart';
import 'package:sigi_android/features/ptech/presentation/ptechList/cubit/ptech_cubit.dart';
import 'home_screen.dart';
import 'widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  late PageController controller;
  late int _currentIndex = Get.arguments ?? 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BlocProvider.of<FournisseurListCubit>(context).onLoadFournisseurs();
    BlocProvider.of<PtechCubit>(context).onFetchPtechs();
    BlocProvider.of<DemandeIntrantListCubit>(context)
        .onFecthDemandeIncitations();
    controller = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _updateHeaderDisplay(index);
    controller.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
  }

  void _updateHeaderDisplay(int index) {
    if (index == 0) {
      BlocProvider.of<AnimationCubit>(context).onShowHeaderLogo();
      BlocProvider.of<AnimationCubit>(context).onShowHeaderMenuIcon();
      BlocProvider.of<AnimationCubit>(context).onHideHeaderSearchIcon();
    }

    if (index == 1) {
      BlocProvider.of<AnimationCubit>(context).onShowHeaderLogo();
      BlocProvider.of<AnimationCubit>(context).onShowHeaderMenuIcon();
      BlocProvider.of<AnimationCubit>(context).onShowHeaderSearchIcon();
    }

    if (index == 2) {
      BlocProvider.of<AnimationCubit>(context).onShowHeaderLogo();
      BlocProvider.of<AnimationCubit>(context).onShowHeaderMenuIcon();
      BlocProvider.of<AnimationCubit>(context).onShowHeaderSearchIcon();
      BlocProvider.of<DemandeIntrantListCubit>(context)
          .onFecthDemandeIncitations();
    }

    if (index == 3) {
      BlocProvider.of<AnimationCubit>(context).onHideHeaderMenuIcon();
      BlocProvider.of<AnimationCubit>(context).onHideHeaderSearchIcon();
      BlocProvider.of<AnimationCubit>(context).onHideHeaderLogo();
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _listScreen = [
    const HomeScreen(),
    const FournisseurList(),
    const DemandeIntrant(),
    const ProfilScreen(),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PageView pageView = PageView(
      controller: controller,
      onPageChanged: _onPageChanged,
      physics: const NeverScrollableScrollPhysics(),
      pageSnapping: false,
      children: _listScreen,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(context, _scaffoldKey),
      body: pageView,
      drawer: const NavigationDrawerWidget(),
      bottomNavigationBar: _navbar(context),
    );
  }

  final bottomLabelList = <String>[
    "Accueil",
    "Fournisseur",
    "Demandes",
    "Profil"
  ];
  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.groups,
    Icons.admin_panel_settings,
    Icons.view_agenda_outlined
  ];

  Widget _navbar(context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(.8),
            spreadRadius: 1,
            blurRadius: 13,
            offset: const Offset(1, 2),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: MediaQuery.of(context).size.width * 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _navBarItem(context,
                  icon: iconList[0],
                  currentIndex: _currentIndex,
                  index: 0,
                  onItemTapped: _onItemTapped),
              _navBarItem(context,
                  icon: iconList[1],
                  currentIndex: _currentIndex,
                  index: 1,
                  onItemTapped: _onItemTapped),
              _navBarItem(context,
                  icon: iconList[2],
                  currentIndex: _currentIndex,
                  index: 2,
                  onItemTapped: _onItemTapped),
              _navBarItem(context,
                  icon: iconList[3],
                  currentIndex: _currentIndex,
                  index: 3,
                  onItemTapped: _onItemTapped),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navBarItem(context,
      {IconData? icon,
      required currentIndex,
      required int index,
      required Function onItemTapped}) {
    return InkWell(
      onTap: () => onItemTapped(index),
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      highlightColor: Theme.of(context).colorScheme.primary.withOpacity(.2),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: (currentIndex == index)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
            ),
            AutoSizeText(
              bottomLabelList[index],
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: (currentIndex == index)
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold),
              minFontSize: 10,
              stepGranularity: 10,
            ),
          ],
        ),
      ),
    );
  }
}
