import 'package:doctor/core/blocs/safe_cubit.dart';
import 'package:doctor/core/extensions/cubit_enums.dart';

import '../../../service/patients_service.dart';
import 'add_patient_state.dart';

class AddPatientCubit extends Cubit<AddPatientState> {
  AddPatientCubit(this._service) : super(const AddPatientState());

  final PatientsService _service;

  /// [body]: name, date_of_birth, diagnosis, address, visit_time.
  Future<void> addPatient(Map<String, dynamic> body) async {
    emit(state.copyWith(status: RequestState.loading, msg: ''));
    final res = await _service.addPatient(body);
    emit(
      state.copyWith(
        status: res.success ? RequestState.done : RequestState.error,
        msg: res.msg,
        errorType: res.errType,
      ),
    );
  }
}
