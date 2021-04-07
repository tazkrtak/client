import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../api/api.dart';
import '../../../models/user.dart';
import '../../../services/locator.dart';

part 'register_state.dart';

class RegisterCubit extends HydratedCubit<RegisterState> {
  RegisterCubit() : super(RegisterLoading());

  Future<void> register() async {
    final service = locator.get<UserService>();
    try {
      final user = await service.register();
      emit(RegisterSucess(user));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    clear();
  }

  @override
  RegisterState? fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json);
      return RegisterSucess(user);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(RegisterState state) {
    if (state is RegisterSucess) {
      return state.user.toJson();
    } else {
      return null;
    }
  }
}
