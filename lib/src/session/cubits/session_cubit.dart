import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../api/api.dart';

part 'session_state.dart';

class SessionCubit extends HydratedCubit<SessionState> {
  SessionCubit() : super(SessionLoading());

  void clearSession() {
    clear();
    emit(SessionUnknown());
  }

  @override
  SessionState? fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json);
      return SessionSuccess(user);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SessionState state) {
    if (state is SessionSuccess) {
      return state.user.toJson();
    } else {
      return null;
    }
  }
}
