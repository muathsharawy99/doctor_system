import 'package:doctor/core/blocs/safe_cubit.dart';
import 'package:doctor/core/extensions/cubit_enums.dart';

import '../../../data/models/patient_model.dart';
import '../../../service/patients_service.dart';
import 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  PatientsCubit(this._service) : super(const PatientsState());

  final PatientsService _service;

  Future<void> getPatients() async {
    emit(state.copyWith(status: RequestState.loading, msg: ''));
    final res = await _service.getPatients();
    if (!res.success) {
      emit(
        state.copyWith(
          status: RequestState.error,
          msg: res.msg,
          errorType: res.errType,
        ),
      );
      return;
    }
    final data = res.data?['data'];
    final raw = data is Map ? data['data'] : null;
    final patients = [
      if (raw is List)
        for (final e in raw)
          if (e is Map) PatientModel.fromJson(Map<String, dynamic>.from(e)),
    ];
    emit(
      state.copyWith(
        status: patients.isEmpty ? RequestState.empty : RequestState.done,
        patients: patients,
      ),
    );
  }
}
