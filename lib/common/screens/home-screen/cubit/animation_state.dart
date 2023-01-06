part of 'animation_cubit.dart';

class AnimationState {
  Map? field;
  AnimationState({@required this.field});
}

Map? initialAnimationState() {
  return {
    'menuIcon': {
      'display': true,
    },
    'searchIcon': {
      'display': true,
    },
    'logo': {
      'display': true,
    },
  };
}
