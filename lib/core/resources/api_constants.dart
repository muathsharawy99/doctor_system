/// Endpoint paths, relative to [baseUrl].
class ApiConstants {
  /// No Firebase project, so the base url is fixed here instead of being
  /// read from Firebase RTDB.
  static const String baseUrl = 'https://medicalapp.eraasoft.com/api';

  // ── Auth
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';

  // ── Doctor's patients. `{id}` is replaced with the patient id.
  static const String doctorPatients = 'doctorpatients';
  static const String updatePatient = 'doctorpatients/{id}';
  static const String deletePatient = 'patients/{id}';

  // ── Admin (not used yet — the admin side is "coming soon")
  static const String adminDoctors = 'getalluser';
  static const String adminAddDoctor = 'adduser';
  static const String adminUpdateDoctor = 'updateuser';
  static const String adminDeleteDoctor = 'deleteuser';
  static const String adminPatients = 'patients';
}
