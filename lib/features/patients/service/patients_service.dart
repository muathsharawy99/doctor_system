import 'package:doctor/core/resources/api_constants.dart';
import 'package:doctor/core/services/server_gate.dart';

/// The signed-in doctor's patients.
class PatientsService {
  /// `{data: {data: [...]}}`.
  Future<CustomResponse<Map<String, dynamic>>> getPatients() =>
      ServerGate.i.getFromServer<Map<String, dynamic>>(
        url: ApiConstants.doctorPatients,
      );

  /// [body]: name, date_of_birth, diagnosis, address, visit_time.
  Future<CustomResponse<Map<String, dynamic>>> addPatient(
    Map<String, dynamic> body,
  ) => ServerGate.i.sendToServer<Map<String, dynamic>>(
    url: ApiConstants.doctorPatients,
    body: body,
  );

  /// POST with `_method=put` (Laravel form-method spoofing).
  Future<CustomResponse<Map<String, dynamic>>> updatePatient(
    String id,
    Map<String, dynamic> body,
  ) => ServerGate.i.sendToServer<Map<String, dynamic>>(
    url: ApiConstants.updatePatient.replaceAll('{id}', id),
    params: {'_method': 'put'},
    body: body,
  );

  Future<CustomResponse<Map<String, dynamic>>> deletePatient(String id) =>
      ServerGate.i.deleteFromServer<Map<String, dynamic>>(
        url: ApiConstants.deletePatient.replaceAll('{id}', id),
      );
}
