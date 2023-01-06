class MonitoringState {
  Map? field;
  MonitoringState({this.field});
}

Map? initialState() {
  return {
    'data': {
      'text': '',
      'photos': [],
    },
    'suiviList': [],
    'sending': false,
    'showImageRequired': false,
    'status': 0,
  };
}
