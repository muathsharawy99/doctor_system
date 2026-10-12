import 'package:doctor/core/blocs/safe_cubit.dart';
import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:doctor/core/shared/models/user_model.dart';

import '../service/profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._service) : super(const ProfileState());

  final ProfileService _service;

  /// Clears the saved session once the server confirms.
  Future<void> logout() async {
    emit(state.copyWith(logoutStatus: RequestState.loading, msg: ''));
    final res = await _service.logout();
    if (res.success) await UserModel.i.clear();
    emit(
      state.copyWith(
        logoutStatus: res.success ? RequestState.done : RequestState.error,
        msg: res.msg,
        errorType: res.errType,
      ),
    );
  }
}
