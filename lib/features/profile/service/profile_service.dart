import 'package:doctor/core/resources/api_constants.dart';
import 'package:doctor/core/services/server_gate.dart';

class ProfileService {
  Future<CustomResponse<Map<String, dynamic>>> logout() =>
      ServerGate.i.sendToServer<Map<String, dynamic>>(url: ApiConstants.logout);
}
