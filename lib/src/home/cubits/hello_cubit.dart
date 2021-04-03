import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../api/api.dart';
import '../../../services/locator.dart';

part 'hello_state.dart';

class HelloCubit extends Cubit<HelloState> {
  HelloCubit() : super(HelloLoading());

  Future<void> fetchMessage() async {
    final service = locator.get<HelloService>();
    try {
      final message = await service.greet();
      emit(HelloSuccess(message));
    } catch (e) {
      emit(HelloFailure(e.toString()));
    }
  }
}
