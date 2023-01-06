import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/screens/home-screen/widgets/drawer/widgets.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/widgets.dart';
import 'package:sigi_android/features/synchronization/download/cubit/synchronization_download_cubit.dart';
import '../../../../../features/authentication/database/save_token.dart';
import '../../../../../features/authentication/logic/cubits/authentication_cubit.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  ScrollController controller = ScrollController();
  ScrollPhysics physics = const ScrollPhysics();
  final padding = const EdgeInsets.symmetric(horizontal: 15);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).colorScheme.primary,
      child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              topElement(context),
              _synchronization(context),
              bottomElement(context),
            ],
          )),
    );
  }

  Widget bottomElement(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: buildMenuItem(
        context,
        text: 'Deconnexion',
        textColor: Colors.white,
        icon: Icons.logout_rounded,
        iconColor: Colors.red,
        onClicked: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  "Voulez vous vous deconnectez?",
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Center(
                    child: Text(
                      "Vous etes sur le point de quitter l'application.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Annuler',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))),
                      TextButton(
                          onPressed: () {
                            SaveToken.userDisconnect();
                            BlocProvider.of<AuthenticationCubit>(context)
                                .onLogOut();
                          },
                          child: Text(
                            'Je quitte',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          )),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget topElement(context) {
    return Flexible(
      child: ListView(
        controller: controller,
        physics: physics,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 15),
        children: <Widget>[
          buildHeader(context, onClicked: () {}),
          const SizedBox(height: 25),
          profilMenuItem(context),
          const SizedBox(height: 30),
          buildMenuItem(
            context,
            text: 'PTech',
            onClicked: () => selectedItem(1),
          ),
          buildMenuItem(
            context,
            text: 'Coupon intrants',
            onClicked: () => selectedItem(2),
          ),
          buildMenuItem(
            context,
            text: 'Suivi',
            onClicked: () => selectedItem(3),
          ),
          buildMenuItem(
            context,
            text: 'Supervision',
            onClicked: () => selectedItem(4),
          ),
          buildMenuItem(
            context,
            text: 'Controle',
            onClicked: () => selectedItem(5),
          ),
        ],
      ),
    );
  }

  Widget _synchronization(context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.blue.shade100,
            width: 3,
          ),
          right: BorderSide(
            color: Colors.blue.shade100,
            width: 3,
          ),
          top: BorderSide(
            color: Colors.blue.shade100,
            width: 3,
          ),
          left: BorderSide(
            color: Colors.blue.shade100,
            width: 3,
          ),
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.sync_outlined, color: Colors.green),
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 20,
        title: Text("Synchroniser",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).colorScheme.tertiary)),
        onTap: () {
          Get.bottomSheet(
            downloadStatus(context),
            isDismissible: false,
            barrierColor:
                Theme.of(context).colorScheme.secondary.withOpacity(.7),
            enterBottomSheetDuration: const Duration(milliseconds: 2),
          );
          BlocProvider.of<SynchronizationDownloadCubit>(context)
              .onDownloadPtechFormData(context);
        },
      ),
    );
  }

  Widget buildHeader(context, {required VoidCallback onClicked}) => InkWell(
        onTap: () => Scaffold.of(context).openEndDrawer(),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(top: 40, right: 15),
            child: Transform.rotate(
              angle: 47.9,
              child: Icon(Icons.add_rounded,
                  semanticLabel: 'Retour',
                  color: Theme.of(context).colorScheme.primary,
                  size: 22),
            ),
          ),
        ),
      );

  Widget buildMenuItem(context,
      {String? text,
      IconData? icon,
      VoidCallback? onClicked,
      Color? iconColor,
      Color? textColor}) {
    return ListTile(
      leading: Icon(icon ?? Icons.document_scanner_outlined,
          color: iconColor ?? Theme.of(context).colorScheme.tertiary),
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 20,
      title: Text(text!,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: textColor ?? Theme.of(context).colorScheme.tertiary)),
      hoverColor: Colors.white,
      onTap: onClicked,
    );
  }

  void selectedItem(int index) {
    Get.back();
    switch (index) {
      case 0:
        // Get.toNamed('/search');
        Null;
        break;
      case 1:
        Get.toNamed('/ptech_list');
        Null;
        break;
      case 2:
        Null;
        break;
      case 3:
        Get.toNamed('/suivi');
        Null;
        break;
      case 4:
        Get.toNamed('/supervision');
        Null;
        break;
      case 5:
        Get.toNamed('/control');
        Null;
        break;
    }
  }
}
