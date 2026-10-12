import 'package:doctor/core/extensions/cubit_enums.dart';
import 'package:equatable/equatable.dart';

class AddPatientState extends Equatable {
  const AddPatientState({
    this.status = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  final RequestState status;
  final String msg;
  final ErrorType errorType;

  AddPatientState copyWith({
    RequestState? status,
    String? msg,
    ErrorType? errorType,
  }) => AddPatientState(
    status: status ?? this.status,
    msg: msg ?? this.msg,
    errorType: errorType ?? this.errorType,
  );

  @override
  List<Object?> get props => [status, msg, errorType];
}
