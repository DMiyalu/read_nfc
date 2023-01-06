part of 'synchronization_download_cubit.dart';

class SynchronizationDownloadState {
  Map? field;
  SynchronizationDownloadState({this.field});
}

Map initialState() {
  return {
    'loading': false,
    'step': '',
  };
}
