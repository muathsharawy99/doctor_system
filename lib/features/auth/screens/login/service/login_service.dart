import 'package:doctor/core/resources/api_constants.dart';
import 'package:doctor/core/services/server_gate.dart';

class LoginService {
  Future<CustomResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) => ServerGate.i.sendToServer<Map<String, dynamic>>(
    url: ApiConstants.login,
    body: {'email': email, 'password': password},
  );
}
