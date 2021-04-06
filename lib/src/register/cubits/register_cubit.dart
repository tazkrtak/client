import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';
import '../../../models/user.dart';
import '../../../services/locator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
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
}
