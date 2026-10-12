import 'package:doctor/core/blocs/safe_cubit.dart';
import 'package:doctor/core/extensions/cubit_enums.dart';

import '../../../service/patients_service.dart';
import 'patient_details_state.dart';

class PatientDetailsCubit extends Cubit<PatientDetailsState> {
  PatientDetailsCubit(this._service) : super(const PatientDetailsState());

  final PatientsService _service;

  Future<void> updatePatient(String id, Map<String, dynamic> body) async {
    emit(state.copyWith(saveStatus: RequestState.loading, msg: ''));
    final res = await _service.updatePatient(id, body);
    emit(
      state.copyWith(
        saveStatus: res.success ? RequestState.done : RequestState.error,
        msg: res.msg,
        errorType: res.errType,
      ),
    );
  }

  Future<void> deletePatient(String id) async {
    emit(state.copyWith(deleteStatus: RequestState.loading, msg: ''));
    final res = await _service.deletePatient(id);
    emit(
      state.copyWith(
        deleteStatus: res.success ? RequestState.done : RequestState.error,
        msg: res.msg,
        errorType: res.errType,
      ),
    );
  }
}
