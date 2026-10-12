// ignore_for_file: must_be_immutable
import 'package:doctor/core/shared/models/base.dart';

class PatientModel extends Model {
  late String name, dateOfBirth, diagnosis, address, visitTime;
  late int userId;

  PatientModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, 'id');
    name = stringFromJson(json, 'name');
    dateOfBirth = stringFromJson(json, 'date_of_birth');
    diagnosis = stringFromJson(json, 'diagnosis');
    address = stringFromJson(json, 'address');
    visitTime = stringFromJson(json, 'visit_time');
    userId = intFromJson(json, 'user_id');
  }

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'date_of_birth': dateOfBirth,
    'diagnosis': diagnosis,
    'address': address,
    'visit_time': visitTime,
    'user_id': userId,
  };
}
