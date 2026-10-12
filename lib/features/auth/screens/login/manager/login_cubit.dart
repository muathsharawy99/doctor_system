import 'package:doctor/core/blocs/safe_cubit.dart';
import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:doctor/core/shared/models/user_model.dart';

import '../service/login_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._service) : super(const LoginState());

  final LoginService _service;

  void toggleDoctor() =>
      emit(state.copyWith(isDoctor: !state.isDoctor, isAdmin: false));

  void toggleAdmin() =>
      emit(state.copyWith(isAdmin: !state.isAdmin, isDoctor: false));

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: RequestState.loading, msg: ''));
    final res = await _service.login(email: email, password: password);
    if (res.success) {
      final raw = res.data?['data'];
      UserModel.i.fromJson({
        if (raw is Map) ...Map<String, dynamic>.from(raw),
        'token': res.data?['token'],
        'password': password,
      });
      await UserModel.i.save();
    }
    emit(
      state.copyWith(
        status: res.success ? RequestState.done : RequestState.error,
        msg: res.msg,
        errorType: res.errType,
      ),
    );
  }
}
