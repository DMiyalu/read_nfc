import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/screens/home-screen/cubit/animation_cubit.dart';


PreferredSizeWidget appBar(context, GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    title: _title(context),
    titleTextStyle: Theme.of(context).textTheme.bodyText1,
    leading: const SizedBox(),
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.primary,
    leadingWidth: 0.0,
    elevation: 0.0,
    actions: _actions(context, scaffoldKey),
  );
}

Widget _title(context) {
  return BlocBuilder<AnimationCubit, AnimationState>(
    builder: (context, state) {
      bool _visible = state.field!['logo']['display'];

      if (!_visible) return const SizedBox();
      return Text(
        "SIGI",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
      );
    },
  );
}

List<Widget> _actions(context, GlobalKey<ScaffoldState> scaffoldKey) {
  List<Widget> actions = [
    searchIcon(),
    menuIcon(scaffoldKey),
    const SizedBox(width: 10),
  ];
  return actions;
}

Widget menuIcon(GlobalKey<ScaffoldState> scaffoldKey) {
  return BlocBuilder<AnimationCubit, AnimationState>(
    builder: (context, state) {
      bool _visible = state.field!['menuIcon']['display'];

      if (!_visible) return const SizedBox();
      return SizedBox(
        width: 40,
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => scaffoldKey.currentState!.openDrawer(),
            //  Scaffold.of(context).openDrawer()
            child: const Icon(
              Icons.menu_rounded,
              size: 20,
              color: Colors.white,
              semanticLabel: "Menu",
            ),
          ),
        ),
      );
    },
  );
}

Widget searchIcon() {
  return BlocBuilder<AnimationCubit, AnimationState>(
    builder: (context, state) {
      bool _visible = state.field!['searchIcon']['display'];

      if (!_visible) return const SizedBox();
      return SizedBox(
        width: 40,
        child: Ink(
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.toNamed('/search'),
            child: const Icon(
              Icons.search_rounded,
              size: 20,
              color: Colors.white,
              semanticLabel: "Recherche",
            ),
          ),
        ),
      );
    },
  );
}
