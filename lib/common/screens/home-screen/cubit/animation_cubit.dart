// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'animation_state.dart';

class AnimationCubit extends Cubit<AnimationState> {
  AnimationCubit() : super(AnimationState(field: initialAnimationState()));

  // MenuBar Animation
  void onHideHeaderMenuIcon() async {
    Map menuIcon = state.field!['menuIcon'];
    menuIcon['display'] = false;
    emit(AnimationState(field: {
      ...state.field!,
      'menuIcon': menuIcon,
    }));
  }

  void onShowHeaderMenuIcon() async {
    Map menuIcon = state.field!['menuIcon'];
    menuIcon['display'] = true;
    emit(AnimationState(field: {
      ...state.field!,
      'menuIcon': menuIcon,
    }));
  }

  // SearchIcon Animation
  void onShowHeaderSearchIcon() {
    Map searchIcon = state.field!['searchIcon'];
    searchIcon['display'] = true;
    emit(AnimationState(field: {
      ...state.field!,
      'searchIcon': searchIcon,
    }));
  }

  void onHideHeaderSearchIcon() {
    Map searchIcon = state.field!['searchIcon'];
    searchIcon['display'] = false;
    emit(AnimationState(field: {
      ...state.field!,
      'searchIcon': searchIcon,
    }));
  }

  // Logo Animation
  void onShowHeaderLogo() {
    Map logo = state.field!['logo'];
    logo['display'] = true;
    emit(AnimationState(field: {
      ...state.field!,
      'logo': logo,
    }));
  }

  void onHideHeaderLogo() {
    Map logo = state.field!['logo'];
    logo['display'] = false;
    emit(AnimationState(field: {
      ...state.field!,
      'logo': logo,
    }));
  }
}
