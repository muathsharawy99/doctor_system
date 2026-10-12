import 'package:doctor/core/resources/api_constants.dart';
import 'package:doctor/core/services/server_gate.dart';

class RegisterService {
  Future<CustomResponse<Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
    required String address,
  }) => ServerGate.i.sendToServer<Map<String, dynamic>>(
    url: ApiConstants.register,
    body: {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
    },
  );
}
