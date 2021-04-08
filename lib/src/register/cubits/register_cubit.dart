import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api.dart';
import '../../../api/user/models/user.dart';
import '../../../services/locator.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register() async {
    emit(RegisterLoading());
    final service = locator.get<UserService>();
    try {
      final user = await service.register();
      emit(RegisterSucess(user));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
