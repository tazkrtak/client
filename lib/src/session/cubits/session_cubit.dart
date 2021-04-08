import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../api/user/models/user.dart';
import '../../../api/user/user_service.dart';
import '../../../services/locator.dart';

part 'session_state.dart';

class SessionCubit extends HydratedCubit<SessionState> {
  SessionCubit() : super(SessionLoading());

  Future<void> loadSession() async {
    final service = locator.get<UserService>();
    try {
      final user = await service.register();
      emit(SessionSuccess(user));
    } catch (_) {
      emit(SessionUnknown());
    }
  }

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
