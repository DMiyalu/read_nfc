import 'package:flutter_bloc/flutter_bloc.dart';
part 'fournisseur_details_state.dart';

class FournisseurDetailsCubit extends Cubit<FournisseurDetailsState> {
  FournisseurDetailsCubit()
      : super(FournisseurDetailsState(fournisseur: {}));
}