import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../api/api.dart';
import '../../../services/locator.dart';

part 'session_state.dart';

class SessionCubit extends HydratedCubit<SessionState> {
  final client = locator.get<ApiClient>();

  SessionCubit() : super(SessionLoading());

  void loadSession() {
    try {
      final user = (state as SessionSuccess).user;
      startSession(user);
    } catch (_) {
      emit(SessionUnknown());
    }
  }

  void startSession(User user) {
    client.authorize(user.token);
    emit(SessionSuccess(user));
  }

  void clearSession() {
    clear();
    client.unauthorize();
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
