import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class DebuggableBlocObserver extends BlocObserver {
  DebuggableBlocObserver({required this.describeStateChanges});
  final bool describeStateChanges;

  @override
  void onCreate(BlocBase bloc) {
    _blocLog("Instance ${bloc.runtimeType} created");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (describeStateChanges) {
      _blocLog("${bloc.runtimeType}: stateChange"
          "{currentState: ${change.currentState.runtimeType},"
          " nextState: ${change.nextState.runtimeType}}");
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _blocLog("${bloc.runtimeType}: transistion"
        "{currentState: ${transition.currentState.runtimeType}, "
        "nextState: ${transition.nextState.runtimeType}, "
        "event: ${transition.event.runtimeType}}");
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _blocLog("Error ${bloc.runtimeType}", error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    _blocLog("Instance ${bloc.runtimeType} closed");
    super.onClose(bloc);
  }

  void _blocLog(
    String msg, {
    Object? error,
    StackTrace? stackTrace,
  }) async {
    log(msg, name: "BLOC", error: error, stackTrace: stackTrace);
  }
}
