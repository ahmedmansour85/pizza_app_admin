import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

/// A custom [BlocObserver] that logs all bloc state changes, events, and errors.
/// This observer is useful for debugging and monitoring bloc behavior during development.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    developer.log(
      'Bloc Created: ${bloc.runtimeType}',
      name: 'AppBlocObserver',
      time: DateTime.now(),
    );
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    developer.log(
      'Bloc ${bloc.runtimeType} State Change:\n'
      'Current State: ${change.currentState}\n'
      'Next State: ${change.nextState}',
      name: 'AppBlocObserver',
      time: DateTime.now(),
    );
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    developer.log(
      'Bloc ${bloc.runtimeType} Event: $event',
      name: 'AppBlocObserver',
      time: DateTime.now(),
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    developer.log(
      'Error in Bloc ${bloc.runtimeType}:\n'
      'Error: $error\n'
      'StackTrace: $stackTrace',
      name: 'AppBlocObserver',
      time: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    developer.log(
      'Bloc Closed: ${bloc.runtimeType}',
      name: 'AppBlocObserver',
      time: DateTime.now(),
    );
  }
}
