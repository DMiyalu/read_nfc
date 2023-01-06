import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/profil/presentation/cubit/profil_cubit.dart';
import 'widgets_profil.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfilCubit>(context).onLoadUserProfile();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  imageProfile(context),
                  const SizedBox(
                    height: 10,
                  ),
                  nuiAndRole(context),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox()
                ],
              ),
            ),
            infoUser(context)
          ],
        ),
      ),
    );
  }
}
