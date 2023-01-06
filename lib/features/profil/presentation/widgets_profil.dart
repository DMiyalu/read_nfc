// ignore_for_file: avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:sigi_android/features/profil/presentation/cubit/profil_cubit.dart';
import 'package:sigi_android/features/profil/presentation/cubit/profil_state.dart';

Widget backIcon(context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 30, 30, 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          splashColor: Colors.orange,
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}

Widget imageProfile(context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
    child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            child: _userphoto(context),
          ),
        ),
      ],
    ),
  );
}

Widget _userphoto(context) {
  String? photo = '';
  return GestureDetector(
    child: Container(
        // ignore: unnecessary_null_comparison
        child: (photo == null || photo == '')
            ? _placeholderProfile(context)
            : SizedBox(
                width: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CircleAvatar(
                      foregroundColor: Colors.brown.withOpacity(0.5),
                      radius: 25.0,
                      backgroundImage: MemoryImage(base64Decode(photo))),
                ),
              )),
  );
}

Widget _placeholderProfile(context) {
  return ClipOval(
    child: Image.asset(
      'assets/images/user.png',
      fit: BoxFit.cover,
      height: 200,
      width: 200,
    ),
  );
}

Widget nuiAndRole(context) {
  return BlocBuilder<ProfilCubit, ProfilState>(builder: (context, state) {
    int? nui = state.field!['status'];
    var role; //state.field!['userProfile'];
    return nui == 200
        ? Column(
            children: <Widget>[
              nui == null || nui == ''
                  ? Center(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: const Text(
                          "",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ), //unknow nui
                      ),
                    )
                  : Center(
                      child: Text(
                        'NUI: ${nui.toString()}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              role == null || role == ''
                  ? Container(
                      child: Container(
                        child: const Text(""), //unknow role
                      ),
                    )
                  : Center(
                      child: Text(
                        '${role.toString()}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    )
            ],
          )
        : Container();
  });
}

Widget infoUser(context) {
  return BlocBuilder<ProfilCubit, ProfilState>(builder: (context, state) {
    Map? profile = {};
    profile = state.field!['userProfile'];
    return profile == null || profile == {}
        ? Container()
        : Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: Colors.white)),
                child: profile["monitor_profile"] == null
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            height: 10.0,
                            child: Center(
                              child: Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: 10.0, end: 20.0),
                                height: 1.0,
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          profile['monitor_profile'] == '' ||
                                  profile['monitor_profile'] == Null
                              ? Container()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        profile['monitor_profile']['user'] == ''
                                            ? Container()
                                            : const Text(
                                                'Nom',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        profile['monitor_profile']['user'] ==
                                                null
                                            ? Container()
                                            : const Text(
                                                'Post-Nom',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        profile['monitor_profile']['user']
                                                    ['firstName'] ==
                                                null
                                            ? Container()
                                            : const Text(
                                                'Prenom',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        profile['monitor_profile'] == {} ||
                                                profile['monitor_profile'] ==
                                                    null
                                            ? Container()
                                            : const Text(
                                                'Rôle',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        profile['monitor_profile']['user']
                                                    ['monitorPosts'] ==
                                                null
                                            ? Container()
                                            : const Text(
                                                'Lieu d\'affectation',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                        state.field?['smartphone_id'] == null ||
                                                state.field?['smartphone_id'] ==
                                                    ''
                                            ? Container()
                                            : const Text(
                                                'ID smartphone',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                          // height: 10,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          profile['monitor_profile']['user']
                                                          ['name'] ==
                                                      null ||
                                                  profile['monitor_profile']
                                                          ['user']['name'] ==
                                                      ''
                                              ? Container()
                                              : Text(
                                                  '${profile['monitor_profile']['user']['name'].toString().capitalize}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          profile['monitor_profile']['user']
                                                          ['lastName'] ==
                                                      null ||
                                                  profile['monitor_profile']
                                                          ['user']['name'] ==
                                                      ''
                                              ? Container()
                                              : Text(
                                                  '${profile['monitor_profile']['user']['lastName'].toString().capitalize}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          profile['monitor_profile']['user']
                                                          ['firstName'] ==
                                                      null ||
                                                  profile['monitor_profile']
                                                              ['user']
                                                          ['firstName'] ==
                                                      ''
                                              ? Container()
                                              : Text(
                                                  '${profile['monitor_profile']['user']['firstName'].toString().capitalize}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          profile['monitor_profile'] == {} ||
                                                  profile['monitor_profile'] ==
                                                      null
                                              ? Container()
                                              : const Text(
                                                  'Moniteur',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          profile['monitor_profile']['user']
                                                      ['monitorPosts'] ==
                                                  null
                                              ? Container()
                                              : Text(
                                                  '${profile['monitor_profile']['user']['monitorPosts']['territory']['name'].toString()}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                            height: 10,
                                          ),
                                          state.field?['smartphone_id'] ==
                                                      null ||
                                                  state.field![
                                                          'smartphone_id'] ==
                                                      ''
                                              ? Container()
                                              : Text(
                                                  '${state.field?['smartphone_id']}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )));
  });
}
