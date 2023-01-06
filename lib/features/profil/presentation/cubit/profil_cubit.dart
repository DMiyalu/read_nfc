import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigi_android/features/authentication/database/save_token.dart';
import 'profil_state.dart';

class ProfilCubit extends Cubit<ProfilState> {
  ProfilCubit() : super(ProfilState(field: initialState()));

  Future<void> onLoadUserProfile() async {
    emit(ProfilState(field: {
      ...state.field!,
      'loading': true,
      'status': 0,
    }));

    final Map? userProfile = await SaveToken.getUserProfile();
    if (userProfile != null) {
      print('*** get userProfile success: ${userProfile.toString()}');
      emit(ProfilState(field: {
        'userProfile': userProfile,
        'loading': false,
        'status': 200,
      }));
      return;
    }
    emit(ProfilState(field: {
      'userProfile': {},
      'loading': false,
      'status': 404,
    }));
  }
}
