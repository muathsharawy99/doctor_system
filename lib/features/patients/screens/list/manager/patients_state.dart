import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/patient_model.dart';

class PatientsState extends Equatable {
  const PatientsState({
    this.status = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.patients = const [],
  });

  final RequestState status;
  final String msg;
  final ErrorType errorType;
  final List<PatientModel> patients;

  PatientsState copyWith({
    RequestState? status,
    String? msg,
    ErrorType? errorType,
    List<PatientModel>? patients,
  }) => PatientsState(
    status: status ?? this.status,
    msg: msg ?? this.msg,
    errorType: errorType ?? this.errorType,
    patients: patients ?? this.patients,
  );

  @override
  List<Object?> get props => [status, msg, errorType, patients];
}
