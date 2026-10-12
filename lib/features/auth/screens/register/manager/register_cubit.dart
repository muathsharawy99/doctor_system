import 'package:doctor/core/blocs/safe_cubit.dart';
import 'package:doctor/core/extensions/cubit_enums.dart';

import '../service/register_service.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._service) : super(const RegisterState());

  final RegisterService _service;

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String address,
  }) async {
    emit(state.copyWith(status: RequestState.loading, msg: ''));
    final res = await _service.register(
      name: name,
      email: email,
      password: password,
      address: address,
    );
    emit(
      state.copyWith(
        status: res.success ? RequestState.done : RequestState.error,
        msg: res.msg,
        errorType: res.errType,
      ),
    );
  }
}
