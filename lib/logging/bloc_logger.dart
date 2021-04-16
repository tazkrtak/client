import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

class BlocLogger extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    final message = StringBuffer();
    message.writeAll([
      '[ ${bloc.runtimeType} ] (change)\n',
      'current : ${change.currentState}',
      '   next : ${change.nextState}'
    ], '\n');

    logger.w(message);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    final message = StringBuffer();
    message.writeAll([
      '[ ${bloc.runtimeType} ] (transition)\n',
      '  event : ${transition.event}',
      'current : ${transition.currentState}',
      '   next : ${transition.nextState}'
    ], '\n');

    logger.w(message);
  }
}
