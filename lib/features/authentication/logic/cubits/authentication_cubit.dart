// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigi_android/common/widgets/effects.dart';
import 'package:sigi_android/features/authentication/database/login_database.dart';
import 'package:sigi_android/features/authentication/database/save_token.dart';
import 'package:sigi_android/features/authentication/logic/authenticationModel.dart';
import 'package:sigi_android/features/authentication/logic/authentication_provider.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit()
      : super(AuthenticationState(userField: authenticationModel()));

  void onFieldChanges({required Map userField}) {
    emit(AuthenticationState(userField: {
      ...state.userField!,
      'email': userField['email'],
      'password': userField['password'],
    }));
  }

  void oncheckUserAuth() async {
    print('check local user profile');
    // Map userAuth = await LoginHiveRepository.getLocalUserProfil();
    final Map? userAuth = await SaveToken.getCredentials();

    if (userAuth!['code'] == 500) {
      emit(AuthenticationState(userField: {
        'code': 500,
        'error': userAuth['message'],
      }));
      return;
    }

    if (userAuth['code'] == 404) {
      emit(AuthenticationState(userField: {
        'code': 404,
        'error': userAuth['message'],
      }));
      return;
    }

    emit(AuthenticationState(userField: {
      'code': 200,
      'profil': userAuth['data'],
    }));
  }

  Future<void> onLoginUser(context,
      {required String email, required String password}) async {
    print('login user values $email , $password ');
    Get.dialog(
      Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: loader(context, color: Colors.white),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Theme.of(context).colorScheme.secondary.withOpacity(.7),
    );
    //verifier la connexion internet
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('il y a connection internet');
      try {
        Map? credentials = await AuthenticationProvider.getUserToken(
            user: {'email': email, 'password': password});

        if (credentials!['code'] == 200) {
          SaveToken.saveToken(token: credentials);
          Map? userInfos = await AuthenticationProvider.getUserProfil(
              credentials: credentials['data']);
          print('result get profil: $userInfos');
          if (userInfos!['code'] == 200) {
            print('profil success');
            SaveToken.saveUserProfile(
                data: {...userInfos, 'password': password});

            emit(AuthenticationState(userField: {
              'code': 200,
              'profil': userInfos,
            }));
            Get.offAllNamed('/');
          } else {
            print('profile non trouvé');
            emit(AuthenticationState(userField: {
              'code': 404,
              'erreur': 'Utilisateur non enregistré',
            }));
            Get.back();
          }
        } else if (credentials['code'] == 400) {
          print('utilisateur non trouvé');
          emit(AuthenticationState(userField: {
            'code': 404,
            "error": credentials['message'],
          }));
          Get.back();
        } else if (credentials['code'] == 404) {
          print('utilisateur non trouvé');
          emit(AuthenticationState(userField: {
            'code': 404,
            "error": credentials['message'],
          }));
          Get.back();
        } else if (credentials['code'] == 401) {
          print('utilisateur non trouvé: 401');
          emit(AuthenticationState(userField: {
            ...state.userField!,
            "error": credentials['message'],
            'code': 404,
          }));
          Get.back();
        } else if (credentials['code'] == 403) {
          print('utilisateur non trouvé: 403');
          Get.back();
          emit(AuthenticationState(userField: {
            ...state.userField!,
            'code': 404,
            "error": credentials['message'],
          }));
        } else if (credentials['code'] == 500) {
          print('utilisateur non trouvé: 500');
          String errorMessage =
              "Le serveur rencontre un problème, veuillez réeassayer";
          emit(AuthenticationState(userField: {
            ...state.userField!,
            'code': 404,
            "error": errorMessage,
          }));
          Get.back();
        } else {
          String errorMessage =
              "Le serveur rencontre un problème, veuillez réeassayer";
          emit(AuthenticationState(userField: {
            ...state.userField!,
            'code': 404,
            "error": errorMessage,
          }));
          Get.back();
        }
      } on SocketException {
        emit(AuthenticationState(userField: {
          ...state.userField!,
          'code': 404,
          "error": "Une erreur est survenue, réessayez !",
        }));
        Get.back();
        Get.back();
        throw 'Une erreur système.';
      } on TimeoutException catch (e) {
        emit(AuthenticationState(userField: {
          ...state.userField!,
          'code': 500,
          "error": "Erreur application: ${e.toString()}",
        }));
        Get.back();
        rethrow;
      } catch (e) {
        String errorMessage = "Une erreur est survenue: ${e.toString()}";
        emit(AuthenticationState(userField: {
          ...state.userField!,
          'code': 500,
          "error": errorMessage,
        }));
        Get.back();
      }
    } else {
      String errorMessage =
          "Vous n'avez pas de connection internet. Vérifiez et réeassayez";
      emit(AuthenticationState(userField: {
        ...state.userField!,
        'code': 500,
        "error": errorMessage,
      }));
      Get.back();
    }
  }

  void onLogOut() async {
    print('disconnect user');
    int status = await LoginHiveRepository.userDisconnect();
    if (status == 200) {
      Get.offAllNamed('/splash');
    } else {
      emit(AuthenticationState(userField: {
        ...state.userField!,
        'logOutStatus': status,
      }));
    }
  }
}
